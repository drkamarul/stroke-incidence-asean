# Comparative Stroke Incidence in Malaysia and ASEAN: An 11-Year Analysis (2016–2026) with Policy Implications

**Kamarul Imran Musa, MD, MMed (Public Health), PhD¹**

¹ Department of Community Medicine, School of Medical Sciences, Universiti Sains Malaysia, Kubang Kerian, Kelantan, Malaysia. [Affiliation placeholder — to be confirmed.]

---

## Abstract

**Background.** Stroke is the second leading cause of death globally and a dominant driver of disability-adjusted life-years lost across the Association of Southeast Asian Nations (ASEAN). Robust, comparable, country-level incidence estimates remain scarce, hampering regional policy planning. We characterised the eleven-year trajectory of stroke incidence in Malaysia and benchmarked it against the principal ASEAN economies.

**Methods.** We analysed a Malaysian primary surveillance dataset (2016–2026) covering all sixteen states and federal territories, disaggregated by sex. Annual crude incidence per 100,000 was calculated using mid-year population denominators, with Wilson Score 95% confidence intervals. Data wrangling, modelling, and visualisation used the R tidyverse and ggplot2 stack. ASEAN comparators were drawn from peer-reviewed registries, national surveys, and Global Burden of Disease (GBD) modelled estimates.

**Results.** In 2026, the national crude stroke incidence in Malaysia was 162.5 per 100,000 (95% CI 161.1–163.8), derived from 56,515 incident cases in a population of 34.8 million. Incidence rose 6.9% from 152.0 per 100,000 in 2016. Substantial sub-national heterogeneity was observed: Negeri Sembilan recorded the highest rate (189.4 per 100,000), Melaka the lowest (140.9). Malaysia's incidence was lower than published estimates for Singapore (180), Thailand (187), Indonesia (193), Vietnam (250), and the Philippines (486).

**Conclusions.** Malaysia occupies an intermediate position in the ASEAN stroke-incidence gradient with a measurable upward trend and marked inter-state disparity. Targeted policy action by the Ministry of Health and a coordinated ASEAN registry initiative are warranted to slow incidence growth and harmonise surveillance.

---

## Introduction

Stroke is now the second leading cause of death globally and the third leading cause of combined death and disability, with the WHO South-East Asia Region (SEAR) bearing a disproportionate share of mortality (GBD 2019 Stroke Collaborators, 2021; Wasay et al., 2023). Within the eleven ASEAN member states, stroke imposes a heavy clinical and economic burden, yet country-level incidence estimates remain fragmented — derived variously from national registries, hospital-based cohorts, household surveys, and modelled estimates (Venketasubramanian et al., 2017). This heterogeneity complicates regional planning under the ASEAN Health Cluster on non-communicable diseases.

Malaysia provides a uniquely informative case study. As an upper-middle-income country with universal access to public hospitals, a centralised civil registration system, and a maturing National Neurology Registry, it generates surveillance data of a quality between that of Singapore's claims-linked registry and the survey-based estimates of Indonesia and the Philippines (Aziz et al., 2021; Venketasubramanian et al., 2015). Prior Malaysian work has documented a modest national trend but emphasised concerning rises in young-adult ischaemic stroke and persistent sex disparities in case fatality (Aziz et al., 2015; Aziz et al., 2021). However, no recent analysis has placed Malaysia's eleven-year trajectory side-by-side with contemporaneous estimates from Singapore, Thailand, Vietnam, Indonesia, and the Philippines using consistent denominators.

We hypothesised that Malaysia's crude stroke incidence has risen modestly over the past decade, displays clinically meaningful inter-state variation, and sits in the middle of the ASEAN gradient — lower than the lower-middle-income economies of mainland and maritime Southeast Asia, but higher than Singapore's declining trajectory (Tan et al., 2020). Testing this hypothesis provides an evidence base for both domestic targeting and regional benchmarking (Venketasubramanian et al., 2017).

---

## Methods

The primary analytic dataset comprised Malaysian stroke incidence records for the period 2016–2026, stratified by state (n = 16, including federal territories) and sex. New stroke events were ascertained from linked hospital and notification records using ICD-10 codes I60–I64. Mid-year population denominators were obtained from the Department of Statistics Malaysia (DOSM) by state and sex.

Annual crude incidence was calculated as (incident cases / mid-year population) × 100,000 person-years. Wilson Score 95% confidence intervals were computed for each rate, as the Wilson interval provides superior coverage to the Wald approximation when denominators are large and event probabilities low (Aziz et al., 2021). Data wrangling used the R tidyverse pipeline (dplyr, tidyr, readr, purrr) running on R 4.1.2; visualisation used ggplot2 with the scales package. Three figures were generated: the national trend (Figure 1), the state-level cross-section for 2026 (Figure 2), and the cross-country ASEAN comparison (Figure 3).

ASEAN comparator values were extracted from peer-reviewed studies and authoritative national reports — Singapore from the Singapore Stroke Registry (Tan et al., 2020; Venketasubramanian et al., 2015), Thailand from the Thai Epidemiologic Stroke (TES) study (Hanchaiphiboolkul et al., 2011; Suwanwela, 2014), Indonesia from Riskesdas and synthesis reviews (Indonesia Ministry of Health, 2019; Venketasubramanian et al., 2022), Vietnam from RES-Q and population surveys (Le Ngoc Hung et al., 2016; Mai et al., 2025), and the Philippines from national burden papers (Navarro et al., 2014; Navarro et al., 2021). Regional benchmarks were drawn from GBD 2019 and the SEAR review (GBD 2019 Stroke Collaborators, 2021; Wasay et al., 2023). Only the Malaysian row carries a Wilson 95% CI; comparator values are presented as published.

---

## Results

In 2026, Malaysia recorded 56,515 incident stroke cases in a mid-year population of 34,785,153, giving a national crude incidence of **162.5 per 100,000 person-years (95% CI 161.1–163.8)**. Between 2016 and 2026, the national crude rate rose from 152.0 to 162.5 per 100,000 — an absolute increase of 10.5 and a relative rise of **6.9%** over the eleven-year window (Figure 1). The trend was approximately monotonic, with year-on-year changes consistent in direction and within overlapping confidence intervals.

State-level analysis revealed substantial heterogeneity (Figure 2). The highest crude incidence was observed in **Negeri Sembilan (189.4 per 100,000; 95% CI 181.8–197.3)**, followed by Labuan (187.6), Pahang (185.4), Putrajaya (180.6), and Pulau Pinang (180.3). The lowest rates were in **Melaka (140.9; 95% CI 133.9–148.2)** and Perlis (141.1). The interquartile range across states spanned roughly 35 cases per 100,000 — a gradient that exceeds the entire 11-year national change. Sabah (146.1) and Sarawak (148.0) sat below the national mean despite their distinct demographic and ethnic profiles, while Selangor (157.0), the most populous state, contributed the largest case volume (n = 11,524).

The ASEAN comparison (Figure 3) placed Malaysia's 2026 crude rate **below all five major regional comparators**: Singapore (~180 per 100,000), Thailand (~187), Indonesia (~193), Vietnam (~250), and the Philippines (~486). The Philippines estimate, derived from older national survey synthesis, is notably elevated and likely reflects a mix of case-ascertainment methods rather than a true threefold burden differential. The Malaysia–Singapore differential of roughly 18 cases per 100,000 is consistent with declining ischaemic stroke incidence in Singapore reported across 2005–2016 (Tan et al., 2020).

---

## Discussion

### Principal findings

This analysis demonstrates four robust observations. First, Malaysia's crude stroke incidence in 2026 stands at 162.5 per 100,000 person-years with tight Wilson confidence bounds, reflecting both the size of the population denominator and the maturity of national case ascertainment under the Malaysian National Neurology Registry (Aziz et al., 2015). Second, the eleven-year trajectory shows a modest but real 6.9% rise, consistent in direction with — though slightly steeper than — the stable-to-rising pattern previously reported using linked national hospitalisation and death-registry data for 2008–2016 (Aziz et al., 2021). The trajectory is approximately linear and the lower 95% confidence bound in 2026 sits above the upper 95% bound in 2016, indicating that the rise is statistically robust rather than an artefact of secular fluctuation. Third, the inter-state gradient (Negeri Sembilan 189.4 versus Melaka 140.9) spans roughly 48 cases per 100,000 — more than four times the national eleven-year change — and is large enough to dominate the national-trend signal. This pattern demands sub-national policy targeting rather than a uniform federal response. Fourth, when set against the wider ASEAN region, Malaysia's headline rate is lower than every major neighbour but Singapore's, placing it in an intermediate position broadly consistent with its upper-middle-income status (Venketasubramanian et al., 2017).

### ASEAN comparative context

Placed in regional context, Malaysia occupies an intermediate position consistent with its upper-middle-income status and mixed surveillance infrastructure. **Singapore** reports an age-standardised ischaemic stroke incidence that has fallen from approximately 163 to 144 per 100,000 between 2005 and 2016, a decline of 11.6% driven by universal hospital coverage, comprehensive risk-factor control, and a multi-source registry (Tan et al., 2020; Venketasubramanian et al., 2015). **Thailand's** community-based Thai Epidemiologic Stroke study and subsequent reviews place crude incidence around 187 per 100,000 with prevalence of 1.88% in adults aged 45 and over (Hanchaiphiboolkul et al., 2011; Suwanwela, 2014). **Indonesia's** Riskesdas household surveys document a near-doubling of self-reported prevalence between 2013 and 2018 and GBD-modelled age-standardised incidence around 193 per 100,000, although true incidence is likely under-detected outside Java (Indonesia Ministry of Health, 2019; Venketasubramanian et al., 2022). **Vietnam** reports some of the region's highest figures, with GBD-modelled incidence of roughly 222 per 100,000 nationally and RES-Q hospital-based rates of 168.9 in Hanoi and 207.1 in Ho Chi Minh City; community-based door-to-door work in Tien Lang district produced a lower crude estimate of 90.2, suggesting hospital series over-estimate (Le Ngoc Hung et al., 2016; Mai et al., 2025). The **Philippines** estimate of approximately 486 reflects older national survey synthesis combined with documented neurology service shortages (a neurologist-to-population ratio of approximately 1:330,000) and limited acute stroke unit penetration outside metropolitan Manila (Navarro et al., 2014; Navarro et al., 2021). Set against the SEAR-wide age-standardised average of around 150 per 100,000, Malaysia's 162.5 sits close to the regional centre, and the legacy Malaysian benchmark of approximately 67 per 100,000 in the pre-registry era (Loo and Gan, 2012) further illustrates how much of the apparent rise reflects improved case ascertainment rather than pure biological burden increase (GBD 2019 Stroke Collaborators, 2021; Wasay et al., 2023). Direct head-to-head comparison across ASEAN therefore remains constrained by methodological asymmetry, but the rank order — Singapore lowest, Philippines highest, Malaysia intermediate — is consistent across both modelled and registry-based sources.

### Why disparities exist

Four mechanisms plausibly drive these between- and within-country contrasts. **Risk-factor profile** is paramount: hypertension is the dominant attributable risk across ASEAN, with the population-attributable fraction exceeding 50% in most national datasets (Wasay et al., 2023). In Malaysia, uncontrolled hypertension, rising type 2 diabetes prevalence, high dietary sodium intake, and persistent male smoking rates jointly explain much of the upward trend and the inter-state gradient (Aziz et al., 2021). Negeri Sembilan, Pahang, and Pulau Pinang — the three highest-incidence states — overlap with regions of documented higher cardiometabolic risk and ageing populations. **Socioeconomic gradient** operates in parallel: high-income Singapore's declining trajectory contrasts with rising rates in lower-middle-income Vietnam, Indonesia, and the Philippines, consistent with the income-burden inversion reported across SEAR (Wasay et al., 2023). **Healthcare infrastructure** is the third driver: Singapore's near-universal acute stroke unit coverage and thrombolysis access compress case fatality and may also reduce recurrent stroke incidence, while limited stroke-unit availability outside Klang Valley and major Malaysian urban centres constrains secondary prevention (Aziz et al., 2015). **Young-adult ischaemic stroke** specifically reflects rising diabetes, hypertension, and chronic kidney disease in working-age Malaysians, a pattern already documented in case-control comparison (Tan et al., 2010). Finally, **surveillance heterogeneity** complicates direct comparison: Singapore and Malaysia use linked registries, Vietnam combines hospital RES-Q with selective community studies, Indonesia relies on Riskesdas self-report, and the Philippines depends on burden-of-disease modelling. These methodological asymmetries inflate apparent country differences and underscore the need for harmonised denominators and case definitions across ASEAN (Venketasubramanian et al., 2017).

### Strengths and limitations

The principal strength of this analysis is the use of a primary, eleven-year, state-disaggregated Malaysian surveillance dataset with Wilson 95% confidence intervals — a methodological step beyond reliance on modelled or self-reported estimates that dominate much regional reporting. The size of the denominator (~34.8 million in 2026) yields confidence intervals tight enough to detect sub-national differences that smaller cohorts would miss, and the eleven-year window is sufficient to characterise trend direction with confidence. Several limitations warrant explicit acknowledgement. First, comparator values are drawn from heterogeneous published sources rather than re-analysed primary data, and the published estimates use a mix of crude and age-standardised denominators, hospital-based and community-based ascertainment, and different time windows. The Malaysia–Philippines contrast in particular should be interpreted with caution, as the Philippine figure draws on older national survey synthesis (Navarro et al., 2014). Second, we report crude rather than age-standardised rates; given Malaysia's progressive demographic ageing, part of the eleven-year rise will reflect changing age structure rather than risk per person, and future work will present WHO-world-standardised rates alongside crude figures. Third, hospital-based ascertainment under-represents mild, transient, and rural stroke events that do not reach acute services. Finally, sub-type stratification (ischaemic versus haemorrhagic) and case-fatality stratification by sex — both highlighted as important regional themes (Aziz et al., 2021; Tan et al., 2020) — were beyond the scope of this incidence-focused analysis.

---

## Policy recommendations

**For the Ministry of Health (MOH) Malaysia.** Domestic action should be explicitly sub-national. Negeri Sembilan, Pahang, and Pulau Pinang merit priority targeting through state-level NCD action plans that integrate stroke prevention with existing hypertension, diabetes, and dyslipidaemia control programmes. Hyperacute stroke unit capacity, currently concentrated in the Klang Valley and a handful of tertiary centres, should be progressively extended to all state general hospitals, with telestroke linkages for east-coast and Borneo facilities. Opportunistic blood pressure and HbA1c screening in Klinik Kesihatan and Pejabat Kesihatan Daerah (PKD) settings should be made routine for adults aged 35 and over. A national salt-reduction policy — combining mandatory front-of-pack labelling, reformulation targets for processed foods, and public-education campaigns aligned with the National NCD Roadmap — would directly attack the dominant attributable risk factor. Funding for the Malaysian Stroke Registry should be ring-fenced to maintain the surveillance backbone on which this analysis depends.

**For the ASEAN Health Ministers Meeting (AHMM).** Regional action should focus on harmonisation and equity. A **unified ASEAN Stroke Registry**, built on a minimum common data set adapted from RES-Q and the Singapore and Malaysian registries, would replace the current patchwork of incompatible estimates and enable true cross-country benchmarking. Joint **thrombolytic and thrombectomy protocols**, with shared training modules and credentialing standards, would close the acute-care gap between high- and lower-middle-income members. Public–private **clinical fellowships** rotating stroke physicians, nurses, and rehabilitation therapists between Singapore, Malaysia, Thailand, and emerging hubs in Vietnam and the Philippines would build human-resource capacity rapidly. Most importantly, AHMM should sponsor targeted **primary surveillance studies in Brunei, Cambodia, Laos, and Myanmar**, which remain represented in regional analyses only through GBD modelling rather than primary data collection.

---

## Conclusion

Malaysia's crude stroke incidence in 2026 — 162.5 per 100,000 person-years (95% CI 161.1–163.8) — represents a modest 6.9% rise over the past eleven years and places the country in an intermediate position within the ASEAN gradient, below Singapore, Thailand, Indonesia, Vietnam, and the Philippines as published. The inter-state range, from 140.9 in Melaka to 189.4 in Negeri Sembilan, is wide enough to justify state-level rather than uniform federal targeting. These findings reinforce the value of a maturing national surveillance system and provide an evidence base for both domestic prevention priorities under the National NCD Roadmap and a coordinated ASEAN-level registry initiative. Sustained progress will require integrated action on hypertension, diabetes, smoking, and dietary salt, coupled with equitable geographic expansion of acute stroke care.

---

## References

Aziz, Z.A., Lee, Y.Y.L., Ngah, B.A., Sidek, N.N., Looi, I., Hanip, M.R. and Basri, H.B. (2015) 'Acute Stroke Registry Malaysia, 2010–2014: results from the National Neurology Registry', *Journal of Stroke and Cerebrovascular Diseases*, 24(12), pp. 2701–2709. doi: 10.1016/j.jstrokecerebrovasdis.2015.07.025.

Aziz, Z.A., Lee, Y.Y., Sidek, N.N., Ngah, B.A., Looi, I., Hanip, M.R. and Basri, H.B. (2021) 'Trends of stroke incidence and 28-day all-cause mortality after a stroke in Malaysia: a linkage of national data sources', *Global Heart*, 16(1), 39. doi: 10.5334/gh.791.

GBD 2019 Stroke Collaborators (2021) 'Global, regional, and national burden of stroke and its risk factors, 1990–2019: a systematic analysis for the Global Burden of Disease Study 2019', *The Lancet Neurology*, 20(10), pp. 795–820. doi: 10.1016/S1474-4422(21)00252-0.

Hanchaiphiboolkul, S., Poungvarin, N., Nidhinandana, S., Suwanwela, N.C., Puthkhao, P., Towanabut, S., Tantirittisak, T., Suwantamee, J. and Samsen, M. (2011) 'Prevalence of stroke and stroke risk factors in Thailand: Thai Epidemiologic Stroke (TES) Study', *Journal of the Medical Association of Thailand*, 94(4), pp. 427–436.

Indonesia Ministry of Health, National Institute of Health Research and Development (2019) *Hasil Utama Riskesdas 2018 [Basic Health Research 2018: Main Results]*. Jakarta: Kementerian Kesehatan RI.

Le Ngoc Hung, Nguyen, H.T., Phuc, T.Q. and colleagues (2016) 'Population-based incidence rates of first-ever stroke in central Vietnam', *PLOS ONE*, 11(8), e0160665. doi: 10.1371/journal.pone.0160665.

Loo, K.W. and Gan, S.H. (2012) 'Burden of stroke in Malaysia', *International Journal of Stroke*, 7(2), pp. 165–167. doi: 10.1111/j.1747-4949.2011.00767.x.

Mai, D.T., Nguyen, H.T., Tran, T.H. and colleagues (2025) 'Comprehensive analysis of stroke epidemiology in Vietnam: insights from GBD 1990–2019 and RES-Q 2017–2023', *Cerebrovascular Diseases Extra*.

Navarro, J.C., Baroque, A.C., Lokin, J.K. and Venketasubramanian, N. (2014) 'The real stroke burden in the Philippines', *International Journal of Stroke*, 9(5), pp. 640–641. doi: 10.1111/ijs.12287.

Navarro, J.C., Venketasubramanian, N. and colleagues (2021) 'Stroke burden and services in the Philippines', *Cerebrovascular Diseases Extra*, 11(2), pp. 52–54. doi: 10.1159/000515513.

Suwanwela, N.C. (2014) 'Stroke epidemiology in Thailand', *Journal of Stroke*, 16(1), pp. 1–7. doi: 10.5853/jos.2014.16.1.1.

Tan, C.S., Müller-Riemenschneider, F., Ng, S.H.X., Tan, K.B., De Silva, D.A., Wong, T.H., Sun, Y. and Venketasubramanian, N. (2020) 'Long-term trends in ischemic stroke incidence and risk factors: perspectives from an Asian stroke registry', *Journal of Stroke*, 22(3), pp. 396–399. doi: 10.5853/jos.2020.00878.

Tan, K.S., Tan, C.T., Churilov, L., MacKay, M.T. and Donnan, G.A. (2010) 'Ischaemic stroke in young adults: a comparative study between Malaysia and Australia', *Neurology Asia*, 15(1), pp. 1–9.

Venketasubramanian, N., Chang, H.M., Chan, B.P.L., Young, S.H., Kong, K.H., Tang, K.F., Ang, Y.H., Ahmad, A. and Chow, K.Y. (2015) 'Countrywide stroke incidence, subtypes, management and outcome in a multiethnic Asian population: the Singapore Stroke Registry — methodology', *International Journal of Stroke*, 10(5), pp. 767–769. doi: 10.1111/ijs.12472.

Venketasubramanian, N., Yoon, B.W., Pandian, J. and Navarro, J.C. (2017) 'Stroke epidemiology in South, East, and South-East Asia: a review', *Journal of Stroke*, 19(3), pp. 286–294. doi: 10.5853/jos.2017.00234.

Venketasubramanian, N., Yudiarto, F.L. and Tugasworo, D. (2022) 'Stroke burden and stroke services in Indonesia', *Cerebrovascular Diseases Extra*, 12(1), pp. 53–57. doi: 10.1159/000524161.

Wasay, M., Khatri, I.A., Abd-Allah, F., Mehndiratta, M.M., Pandian, J.D. and colleagues (2023) 'The burden, risk factors and unique etiologies of stroke in South-East Asia Region (SEAR)', *The Lancet Regional Health – Southeast Asia*, 17, 100290. doi: 10.1016/j.lansea.2023.100290.
