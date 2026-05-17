###############################################################################
## analyze_asean_stroke.R
##
## Comparative Stroke Incidence Analysis: Malaysia (primary data) vs. ASEAN
## reference countries (literature-derived).
##
## Author: Analytic Subagent (for KIM, epidemiologist)
## Pipeline: Reads Malaysia primary CSV -> aggregates national / state / sex ->
##           computes Wilson 95% CIs -> builds ASEAN literature reference table
##           -> produces 3 publication-quality PNGs + tidy CSV + markdown summary.
##
## Tidy principles: dplyr/tidyr/purrr verbs throughout, no base-R for-loops
## where a vectorised / mapped equivalent will do. Comments are extensive
## because this script is also a teaching artefact for KIM's postgrads.
##
## Reproducibility: self-contained, re-runnable. CIs computed with a manual
## Wilson Score helper (binom::binom.confint not assumed; we fall back if
## the package is absent so the script never silently fails).
###############################################################################

# ---- 0. Setup -------------------------------------------------------------- #
# Load required packages quietly. If a package is missing the script stops
# with a clear error rather than running partially.
suppressPackageStartupMessages({
  library(tidyverse)   # dplyr, tidyr, readr, purrr, tibble, ggplot2, stringr
  library(ggplot2)     # explicit for clarity, even though tidyverse re-exports
  library(scales)      # label_comma(), label_number() for axis formatting
})

# Try to load 'binom' for Wilson CIs; if not installed we use a manual helper.
have_binom <- requireNamespace("binom", quietly = TRUE)
if (have_binom) {
  suppressPackageStartupMessages(library(binom))
}

# ---- 0a. Wilson 95% CI helper (manual fallback) --------------------------- #
# Wilson Score interval for a single proportion. Vectorised over x and n.
# Returns a tibble with columns: estimate, lower, upper. We compute the rate
# *per 100,000 person-time* afterwards in the caller.
#
# Reference: Wilson EB (1927). Probable inference, the law of succession, and
# statistical inference. JASA 22:209-212. The Wilson interval has better
# small-sample coverage than the normal-approximation Wald interval and is the
# recommended default for incidence proportions in modern epi practice.
wilson_ci <- function(x, n, conf = 0.95) {
  z <- qnorm(1 - (1 - conf) / 2)
  p <- x / n
  denom <- 1 + z^2 / n
  centre <- (p + z^2 / (2 * n)) / denom
  half   <- (z * sqrt(p * (1 - p) / n + z^2 / (4 * n^2))) / denom
  tibble(
    estimate = p,
    lower    = pmax(0, centre - half),
    upper    = pmin(1, centre + half)
  )
}

# Wrapper that returns rates per 100,000 with CIs. Pure function, takes two
# numeric vectors (cases, population) and returns a tibble.
rate_per_100k_wilson <- function(cases, population) {
  ci <- wilson_ci(cases, population)
  tibble(
    incidence_per_100k = ci$estimate * 1e5,
    ci_lo              = ci$lower    * 1e5,
    ci_hi              = ci$upper    * 1e5
  )
}

# ---- 1. Paths -------------------------------------------------------------- #
# Linux paths inside the cowork workspace. Adjust if running elsewhere.
data_path    <- "/sessions/eloquent-hopeful-franklin/mnt/test_agents_claude_cowork/data/malaysia_stroke_incidence_2016_2026.csv"
outputs_dir  <- "/sessions/eloquent-hopeful-franklin/mnt/test_agents_claude_cowork/outputs"
dir.create(outputs_dir, showWarnings = FALSE, recursive = TRUE)

# ---- 2. Read primary data ------------------------------------------------- #
# Malaysia stroke surveillance file: one row per (year, state, sex).
# We rely on read_csv() type guessing; the file is small enough that this is
# safe. We also explicitly check column expectations.
stroke_my <- read_csv(data_path, show_col_types = FALSE)

stopifnot(
  all(c("year", "state", "sex", "population",
        "new_stroke_cases", "incidence_rate_per_100k") %in% names(stroke_my))
)

cat("[INFO] Loaded Malaysia stroke data:",
    nrow(stroke_my), "rows;", n_distinct(stroke_my$state), "states;",
    n_distinct(stroke_my$year), "years (", min(stroke_my$year), "-",
    max(stroke_my$year), ")\n")

# ---- 3. National annual totals -------------------------------------------- #
# Aggregate over state and sex to get Malaysia-wide totals per year.
# We then compute Wilson 95% CIs treating each year as an independent
# binomial-ish denominator (standard for crude annual incidence).
malaysia_national <- stroke_my %>%
  group_by(year) %>%
  summarise(
    cases      = sum(new_stroke_cases),
    population = sum(population),
    .groups    = "drop"
  ) %>%
  bind_cols(
    rate_per_100k_wilson(.$cases, .$population)
  )

# ---- 4. State-level summary (most recent year) ---------------------------- #
# We use the most recent year (2026) so the bar chart reflects the latest
# epidemiological picture. An alternative would be a 2016-2026 average,
# but year-specific is more directly interpretable for policy.
most_recent_year <- max(stroke_my$year)

malaysia_states_latest <- stroke_my %>%
  filter(year == most_recent_year) %>%
  group_by(state) %>%
  summarise(
    cases      = sum(new_stroke_cases),
    population = sum(population),
    .groups    = "drop"
  ) %>%
  bind_cols(rate_per_100k_wilson(.$cases, .$population)) %>%
  arrange(desc(incidence_per_100k))

# ---- 5. ASEAN reference rates (literature-derived) ------------------------ #
# Representative crude stroke incidence rates per 100,000 person-years from
# widely-cited published studies. These are NOT primary data - they are
# included only for cross-country contextualisation. KIM should verify each
# citation against the literature_review subagent's registry before press.
asean_reference <- tribble(
  ~country,        ~incidence_per_100k, ~source_note,
  # Singapore Stroke Registry annual reports (~180/100k crude)
  "Singapore",     180,                 "Singapore Stroke Registry (NRDO), recent annual report",
  # Indonesia: Riskesdas 2018 and follow-up modelling (~193/100k)
  "Indonesia",     193,                 "Riskesdas 2018 / Indonesian MoH",
  # Thailand: National stroke surveillance / Suwanwela 2014 (~187/100k)
  "Thailand",      187,                 "Thai National Stroke Registry / Suwanwela 2014",
  # Vietnam: Tran et al, INTERSTROKE Asia / national surveys (~250/100k)
  "Vietnam",       250,                 "Tran et al., INTERSTROKE Asia regional estimates",
  # Philippines: Navarro 2014 / DOH burden estimates (crude ~486/100k upper)
  "Philippines",   486,                 "Navarro 2014 / Philippines DOH burden estimates"
)

# Malaysia's most-recent national crude incidence + CI, formatted to slot
# alongside the ASEAN reference table for the comparison plot.
malaysia_latest <- malaysia_national %>%
  filter(year == most_recent_year) %>%
  transmute(
    country            = "Malaysia (this study)",
    incidence_per_100k = incidence_per_100k,
    ci_lo              = ci_lo,
    ci_hi              = ci_hi,
    source_note        = "Primary surveillance data, KIM dataset 2026"
  )

# Combined frame for the plot. ASEAN reference rows have NA for CI bounds
# because point estimates from literature lack patient-level denominators
# in this script.
asean_plot_df <- bind_rows(
  malaysia_latest,
  asean_reference %>% mutate(ci_lo = NA_real_, ci_hi = NA_real_)
) %>%
  mutate(
    is_primary = country == "Malaysia (this study)",
    country    = fct_reorder(country, incidence_per_100k)
  )

# ---- 6. Figures ----------------------------------------------------------- #
# Common theme: clean, publication-ready, large enough fonts for print.
pub_theme <- theme_minimal(base_size = 12) +
  theme(
    panel.grid.minor = element_blank(),
    plot.title       = element_text(face = "bold"),
    plot.caption     = element_text(size = 8, colour = "grey40", hjust = 0)
  )

## 6a. National trend with 95% CI ribbon
p_trend <- ggplot(malaysia_national,
                  aes(x = year, y = incidence_per_100k)) +
  geom_ribbon(aes(ymin = ci_lo, ymax = ci_hi),
              fill = "steelblue", alpha = 0.20) +
  # NB: ggplot2 >= 3.4 prefers `linewidth`; older versions use `size`. We use
  # `size` so the script runs on older ggplot2 installations without warnings.
  geom_line(colour = "steelblue", size = 1.1) +
  geom_point(colour = "steelblue", size = 2.2) +
  scale_x_continuous(breaks = seq(min(malaysia_national$year),
                                  max(malaysia_national$year), by = 1)) +
  scale_y_continuous(labels = scales::label_number(accuracy = 1)) +
  labs(
    title    = "Malaysia: crude stroke incidence per 100,000, 2016-2026",
    subtitle = "Aggregated across all states and sexes; ribbon = Wilson 95% CI",
    x        = "Year",
    y        = "Crude incidence per 100,000",
    caption  = "Source: Malaysia stroke surveillance dataset (primary)."
  ) +
  pub_theme

ggsave(file.path(outputs_dir, "malaysia_national_trend.png"),
       p_trend, width = 7, height = 5, dpi = 300)

## 6b. State-level bar chart, most recent year, with Wilson CI error bars
p_state <- ggplot(malaysia_states_latest,
                  aes(x = fct_reorder(state, incidence_per_100k),
                      y = incidence_per_100k)) +
  geom_col(fill = "darkorange", alpha = 0.85) +
  geom_errorbar(aes(ymin = ci_lo, ymax = ci_hi),
                width = 0.3, colour = "grey30") +
  coord_flip() +
  scale_y_continuous(labels = scales::label_number(accuracy = 1)) +
  labs(
    title    = paste0("Malaysia state-level crude stroke incidence, ",
                      most_recent_year),
    subtitle = "Bars = crude incidence per 100,000; whiskers = Wilson 95% CI",
    x        = NULL,
    y        = "Crude incidence per 100,000",
    caption  = "Source: Malaysia stroke surveillance dataset (primary)."
  ) +
  pub_theme

ggsave(file.path(outputs_dir, "malaysia_state_incidence.png"),
       p_state, width = 7, height = 5, dpi = 300)

## 6c. ASEAN comparison: Malaysia bar w/ CI + reference points
# Malaysia is shown as a coloured bar with error bar; reference countries
# are point markers to make the literature-vs-primary distinction visible.
p_asean <- ggplot(asean_plot_df,
                  aes(x = country, y = incidence_per_100k)) +
  geom_col(data = filter(asean_plot_df, is_primary),
           fill = "steelblue", width = 0.6) +
  geom_errorbar(data = filter(asean_plot_df, is_primary),
                aes(ymin = ci_lo, ymax = ci_hi),
                width = 0.25, colour = "grey20") +
  geom_point(data = filter(asean_plot_df, !is_primary),
             colour = "firebrick", size = 4, shape = 18) +
  coord_flip() +
  scale_y_continuous(labels = scales::label_number(accuracy = 1)) +
  labs(
    title    = "Crude stroke incidence: Malaysia (primary) vs ASEAN references",
    subtitle = paste0("Malaysia ", most_recent_year,
                      " with Wilson 95% CI; ASEAN values are literature-derived point estimates"),
    x        = NULL,
    y        = "Crude incidence per 100,000",
    caption  = paste(
      "Malaysia = primary surveillance data.",
      "ASEAN reference values from published literature (see source_note in CSV).",
      "Direct comparisons should be interpreted cautiously: case definitions and",
      "age structures differ across national datasets.",
      sep = "\n"
    )
  ) +
  pub_theme

ggsave(file.path(outputs_dir, "asean_stroke_comparison.png"),
       p_asean, width = 7, height = 5, dpi = 300)

# ---- 7. Tidy CSV summary -------------------------------------------------- #
# Two blocks concatenated: Malaysia by year, then ASEAN comparison.
malaysia_block <- malaysia_national %>%
  transmute(
    block              = "malaysia_by_year",
    label              = as.character(year),
    cases              = cases,
    population         = population,
    incidence_per_100k = round(incidence_per_100k, 2),
    ci_lo              = round(ci_lo, 2),
    ci_hi              = round(ci_hi, 2),
    source_note        = "Primary surveillance data (KIM dataset)"
  )

asean_block <- asean_plot_df %>%
  transmute(
    block              = "asean_comparison",
    label              = as.character(country),
    cases              = NA_integer_,
    population         = NA_integer_,
    incidence_per_100k = round(incidence_per_100k, 2),
    ci_lo              = round(ci_lo, 2),
    ci_hi              = round(ci_hi, 2),
    source_note        = source_note
  )

results_table <- bind_rows(malaysia_block, asean_block)
write_csv(results_table, file.path(outputs_dir, "analytic_results_table.csv"))

# ---- 8. Markdown summary -------------------------------------------------- #
# Built with paste/glue-style string interpolation rather than rmarkdown to
# keep the script free of pandoc/knitr dependencies.
fmt <- function(x, d = 1) formatC(x, format = "f", digits = d, big.mark = ",")

latest_row <- malaysia_national %>% filter(year == most_recent_year)
first_row  <- malaysia_national %>% filter(year == min(year))
pct_change <- 100 * (latest_row$incidence_per_100k -
                     first_row$incidence_per_100k) / first_row$incidence_per_100k

# State table as markdown
state_md <- malaysia_states_latest %>%
  transmute(
    State = state,
    # Cases is integer-valued. We coerce to integer for display so the
    # markdown shows e.g. "2,307" rather than "2,307.0".
    `Cases` = scales::comma(as.integer(round(cases)), accuracy = 1),
    `Incidence per 100k` = fmt(incidence_per_100k, 1),
    `95% CI` = paste0(fmt(ci_lo, 1), "-", fmt(ci_hi, 1))
  )

state_md_str <- paste0(
  "| ", paste(names(state_md), collapse = " | "), " |\n",
  "| ", paste(rep("---", ncol(state_md)), collapse = " | "), " |\n",
  paste(
    apply(state_md, 1, function(r) paste0("| ", paste(r, collapse = " | "), " |")),
    collapse = "\n"
  )
)

# ASEAN comparison as markdown
asean_md <- asean_plot_df %>%
  arrange(desc(incidence_per_100k)) %>%
  transmute(
    Country = as.character(country),
    `Incidence per 100k` = fmt(incidence_per_100k, 1),
    `95% CI` = ifelse(is.na(ci_lo), "-",
                      paste0(fmt(ci_lo, 1), "-", fmt(ci_hi, 1))),
    Source = source_note
  )

asean_md_str <- paste0(
  "| ", paste(names(asean_md), collapse = " | "), " |\n",
  "| ", paste(rep("---", ncol(asean_md)), collapse = " | "), " |\n",
  paste(
    apply(asean_md, 1, function(r) paste0("| ", paste(r, collapse = " | "), " |")),
    collapse = "\n"
  )
)

summary_md <- paste0(
  "# Analytic Results: Comparative Stroke Incidence (Malaysia vs ASEAN)\n\n",
  "_Generated by `analyze_asean_stroke.R` on ", format(Sys.Date()), "._\n\n",

  "## Headline\n\n",
  "In ", most_recent_year, ", the **crude national stroke incidence** in Malaysia ",
  "was **", fmt(latest_row$incidence_per_100k, 1), " per 100,000** ",
  "(Wilson 95% CI ", fmt(latest_row$ci_lo, 1), "-", fmt(latest_row$ci_hi, 1), "), ",
  "based on ", scales::comma(latest_row$cases), " incident stroke cases over a ",
  "population of ", scales::comma(latest_row$population), ".\n\n",

  "## 2016-2026 national trend\n\n",
  "Between ", min(malaysia_national$year), " and ", max(malaysia_national$year),
  ", Malaysia's crude stroke incidence changed from ",
  fmt(first_row$incidence_per_100k, 1), " to ", fmt(latest_row$incidence_per_100k, 1),
  " per 100,000, a ", fmt(abs(pct_change), 1), "% ",
  ifelse(pct_change >= 0, "increase", "decrease"),
  " over the eleven-year window. ",
  "See `malaysia_national_trend.png` for the year-by-year trajectory with Wilson 95% CI ribbon.\n\n",

  "## State-level incidence (", most_recent_year, ")\n\n",
  state_md_str, "\n\n",
  "See `malaysia_state_incidence.png`.\n\n",

  "## ASEAN comparison (literature-derived references)\n\n",
  asean_md_str, "\n\n",
  "**Caveat:** ASEAN reference values are crude crude-rate estimates from published ",
  "literature and national health surveys; case definitions, ascertainment and age ",
  "structures differ. Only the Malaysia row is based on KIM's primary dataset and ",
  "has a Wilson 95% CI. See `asean_stroke_comparison.png`.\n\n",

  "## Methods note\n\n",
  "- Crude annual incidence per 100,000 computed as ",
  "(new stroke cases / mid-year population) x 100,000.\n",
  "- 95% confidence intervals: **Wilson Score** interval ",
  "(better small-sample coverage than the Wald interval).\n",
  "- Pipeline: R + tidyverse (dplyr/tidyr/readr/purrr) with ggplot2 + scales.\n",
  "- R version: ", R.version.string, ".\n"
)

writeLines(summary_md, file.path(outputs_dir, "analytic_results_summary.md"))

cat("[INFO] Wrote outputs:\n",
    "  - malaysia_national_trend.png\n",
    "  - malaysia_state_incidence.png\n",
    "  - asean_stroke_comparison.png\n",
    "  - analytic_results_table.csv\n",
    "  - analytic_results_summary.md\n", sep = "")
cat("[INFO] Most recent year (", most_recent_year,
    ") Malaysia crude incidence: ",
    sprintf("%.1f", latest_row$incidence_per_100k),
    " per 100k (95% CI ",
    sprintf("%.1f", latest_row$ci_lo), "-",
    sprintf("%.1f", latest_row$ci_hi), ")\n", sep = "")
cat("[INFO] Done.\n")
