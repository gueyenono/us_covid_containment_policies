# Data dictionary: `OxCGRT_raw_USA_v1.csv`

## Source

- **Dataset:** Oxford COVID-19 Government Response Tracker (OxCGRT), Blavatnik School of Government, University of Oxford.
- **Download location:** `data/subnat_raw/OxCGRT_raw_USA_v1.csv` in OxCGRT's final dataset repository: <https://github.com/OxCGRT/covid-policy-dataset>
  - Direct link: <https://github.com/OxCGRT/covid-policy-dataset/blob/main/data/subnat_raw/OxCGRT_raw_USA_v1.csv>
- **Codebook:** `documentation_and_codebook.md` in the same repository: <https://github.com/OxCGRT/covid-policy-dataset/blob/main/documentation_and_codebook.md>
- **Reference paper:** Hale, T., Angrist, N., Goldszmidt, R., et al. (2021). A global panel database of pandemic policies (Oxford COVID-19 Government Response Tracker). *Nature Human Behaviour*, 5, 529–538. <https://doi.org/10.1038/s41562-021-01079-8>
- **What the "raw" files are:** the codebook describes them as the data the OxCGRT team collected for subnational jurisdictions, with 128 variables. Their jurisdictions are mostly WIDE or GOV, meaning each row shows the policies set by one level of government. The `fullwithnotes` and `compact` files instead use the TOTAL designation.

## File structure

**Contents:** 58,088 rows × 128 columns. One row per jurisdiction per day, 1 Jan 2020 to 31 Dec 2022 (1,096 days), covering:

- `NAT_TOTAL`: all policies in force anywhere in the United States, at any level of government (1,096 rows)
- `NAT_GOV`: policies set by the US federal government only (1,096 rows)
- `STATE_WIDE`: 50 states plus DC (51 × 1,096 = 55,896 rows). Covers policies that state governments set, together with any lower levels of government. Federal policies are not included.

**General notes**

- **Vaccine-differentiated suffixes (`E` / `NV` / `V`).** This is the "v1" format, in which policies can differ by vaccination status. `E` ("everyone") columns hold the value on days when one policy applies to everyone. `NV` (non-vaccinated) and `V` (vaccinated) columns hold the values on days when the policy differs by vaccination status. On any given row, either the `E` column is filled or the `NV`/`V` pair is filled, never both.
- **Flags** (`*_Flag`) give the geographic scope of the policy (0 = targeted to part of the jurisdiction, 1 = general, applies across the whole jurisdiction), except for E1 and H7 (see below). A flag is blank when the indicator equals 0.
- **Ordinal indicators** use monotonic scales: a higher value means a stricter or more generous policy. Each level has its own meaning, so the levels can also be treated as categories.
- **Numerical indicators** (E3, E4, H4, H5) are amounts in US dollars. A value is recorded only on the day the measure is announced, and other days are 0 or blank.
- **`*_Notes`** columns contain free-text notes from coders, with sources and the reasoning behind each code.
- Descriptions marked † come from the OxCGRT final-dataset codebook (`documentation_and_codebook.md`) rather than the 2021 paper. The paper predates the vaccine-differentiated columns and the H8 and V1–V4 indicators.

## Identifiers

| Column | Description |
|---|---|
| `CountryName` | Country name (always "United States"). |
| `CountryCode` | ISO 3166-1 alpha-3 country code (always "USA"). |
| `RegionName` | Subnational jurisdiction name (state or DC). "Country-wide" for `NAT_TOTAL` rows; blank for `NAT_GOV` rows. |
| `RegionCode` | Subnational code in the form `US_XX` (e.g., `US_CA`); `NAT_TOTAL` for national total rows; blank for `NAT_GOV` rows. |
| `Jurisdiction` | Level and scope of the record: `NAT_TOTAL`, `NAT_GOV`, or `STATE_WIDE` (see above). |
| `Date` | Observation date, integer `YYYYMMDD`. |

## C: Containment and closure policies

| Column | Description |
|---|---|
| `C1E_School closing` | School closing, applies to everyone. 0 = no measures; 1 = recommend closing, or all schools open with significant changes to how they operate; 2 = require closing some levels or categories (e.g., only high schools, or only public schools); 3 = require closing all levels. |
| `C1E_Flag` | Geographic scope of C1E: 0 = targeted, 1 = general. |
| `C1NV_School closing` | School closing for non-vaccinated people (same scale as C1E)†. |
| `C1NV_Flag` | Geographic scope of C1NV: 0 = targeted, 1 = general†. |
| `C1V_School closing` | School closing for vaccinated people (same scale as C1E)†. |
| `C1V_Flag` | Geographic scope of C1V: 0 = targeted, 1 = general†. |
| `C1_Notes` | Coder notes and sources for C1. |
| `C2E_Workplace closing` | Workplace closing, applies to everyone. 0 = no measures; 1 = recommend closing or working from home, or businesses open with significant changes to how they operate; 2 = require closing or working from home for some sectors or categories of workers; 3 = require closing or working from home for all but essential workplaces (e.g., grocery stores, doctors). |
| `C2E_Flag` | Geographic scope of C2E: 0 = targeted, 1 = general. |
| `C2NV_Workplace closing` | Workplace closing for non-vaccinated people (same scale as C2E)†. |
| `C2NV_Flag` | Geographic scope of C2NV†. |
| `C2V_Workplace closing` | Workplace closing for vaccinated people (same scale as C2E)†. |
| `C2V_Flag` | Geographic scope of C2V†. |
| `C2_Notes` | Coder notes and sources for C2. |
| `C3E_Cancel public events` | Cancellation of public events, applies to everyone. 0 = no measures; 1 = recommend cancelling; 2 = require cancelling. |
| `C3E_Flag` | Geographic scope of C3E: 0 = targeted, 1 = general. |
| `C3NV_Cancel public events` | Cancellation of public events for non-vaccinated people (same scale as C3E)†. |
| `C3NV_Flag` | Geographic scope of C3NV†. |
| `C3V_Cancel public events` | Cancellation of public events for vaccinated people (same scale as C3E)†. |
| `C3V_Flag` | Geographic scope of C3V†. |
| `C3_Notes` | Coder notes and sources for C3. |
| `C4E_Restrictions on gatherings` | Limits on the size of gatherings, applies to everyone. 0 = no restrictions; 1 = very large gatherings restricted (limit above 1,000 people); 2 = limit of 101–1,000 people; 3 = limit of 11–100 people; 4 = limit of 10 people or fewer. |
| `C4E_Flag` | Geographic scope of C4E: 0 = targeted, 1 = general. |
| `C4NV_Restrictions on gatherings` | Limits on gatherings for non-vaccinated people (same scale as C4E)†. |
| `C4NV_Flag` | Geographic scope of C4NV†. |
| `C4V_Restrictions on gatherings` | Limits on gatherings for vaccinated people (same scale as C4E)†. |
| `C4V_Flag` | Geographic scope of C4V†. |
| `C4_Notes` | Coder notes and sources for C4. |
| `C5E_Close public transport` | Closure of public transport, applies to everyone. 0 = no measures; 1 = recommend closing, or significantly reduce volume, routes, or means of transport; 2 = require closing, or prohibit most citizens from using it. |
| `C5E_Flag` | Geographic scope of C5E: 0 = targeted, 1 = general. |
| `C5NV_Close public transport` | Public transport closure for non-vaccinated people (same scale as C5E)†. |
| `C5NV_Flag` | Geographic scope of C5NV†. |
| `C5V_Close public transport` | Public transport closure for vaccinated people (same scale as C5E)†. |
| `C5V_Flag` | Geographic scope of C5V†. |
| `C5_Notes` | Coder notes and sources for C5. |
| `C6E_Stay at home requirements` | Stay-at-home ("shelter-in-place") orders, applies to everyone. 0 = no measures; 1 = recommend not leaving the house; 2 = require not leaving the house, with exceptions for daily exercise, grocery shopping, and essential trips; 3 = require not leaving the house, with minimal exceptions (e.g., allowed out once a week, or one person at a time). |
| `C6E_Flag` | Geographic scope of C6E: 0 = targeted, 1 = general. |
| `C6NV_Stay at home requirements` | Stay-at-home requirements for non-vaccinated people (same scale as C6E)†. |
| `C6NV_Flag` | Geographic scope of C6NV†. |
| `C6V_Stay at home requirements` | Stay-at-home requirements for vaccinated people (same scale as C6E)†. |
| `C6V_Flag` | Geographic scope of C6V†. |
| `C6_Notes` | Coder notes and sources for C6. |
| `C7E_Restrictions on internal movement` | Restrictions on movement between cities or regions, applies to everyone. 0 = no measures; 1 = recommend not travelling between regions or cities; 2 = internal movement restrictions in place. |
| `C7E_Flag` | Geographic scope of C7E: 0 = targeted, 1 = general. |
| `C7NV_Restrictions on internal movement` | Internal movement restrictions for non-vaccinated people (same scale as C7E)†. |
| `C7NV_Flag` | Geographic scope of C7NV†. |
| `C7V_Restrictions on internal movement` | Internal movement restrictions for vaccinated people (same scale as C7E)†. |
| `C7V_Flag` | Geographic scope of C7V†. |
| `C7_Notes` | Coder notes and sources for C7. |
| `C8E_International travel controls` | Restrictions on international travel (applies to foreign travellers, not citizens), applies to everyone. 0 = no restrictions; 1 = screening of arrivals; 2 = quarantine of arrivals from some or all regions; 3 = ban on arrivals from some regions; 4 = ban on arrivals from all regions, or total border closure. No flag variable. |
| `C8NV_International travel controls` | International travel controls for non-vaccinated travellers (same scale as C8E)†. |
| `C8V_International travel controls` | International travel controls for vaccinated travellers (same scale as C8E)†. |
| `C8_Notes` | Coder notes and sources for C8. |

## E: Economic policies

| Column | Description |
|---|---|
| `E1_Income support` | Government income support for people who lose their jobs or cannot work. 0 = no income support; 1 = government replaces less than 50% of lost salary (or pays a flat sum worth less than 50% of the median salary); 2 = government replaces 50% or more of lost salary (or pays a flat sum worth 50% or more of the median salary). |
| `E1_Flag` | Sectoral scope of E1: 0 = formal-sector workers only, or informal-sector workers only; 1 = all workers. |
| `E1_Notes` | Coder notes and sources for E1. |
| `E2_Debt/contract relief` | Government freezes financial obligations for households (e.g., stopping loan repayments, preventing services such as water from being cut off, banning evictions). 0 = no relief; 1 = narrow relief, specific to one kind of contract; 2 = broad debt or contract relief. No flag variable. |
| `E2_Notes` | Coder notes and sources for E2. |
| `E3_Fiscal measures` | New economic stimulus spending, including spending and tax cuts, in USD. Excludes spending recorded in E4, H4, and H5. Recorded on the day of announcement only. Not used in any index. |
| `E3_Notes` | Coder notes and sources for E3. |
| `E4_International support` | Announced spending to support other countries, in USD. Recorded on the day of announcement only. Not used in any index. |
| `E4_Notes` | Coder notes and sources for E4. |

## H: Health system policies

| Column | Description |
|---|---|
| `H1_Public information campaigns` | Public information campaigns about COVID-19. 0 = no campaign; 1 = public officials urging caution about COVID-19; 2 = coordinated public information campaign (e.g., across traditional and social media). |
| `H1_Flag` | Geographic scope of H1: 0 = targeted, 1 = general. |
| `H1_Notes` | Coder notes and sources for H1. |
| `H2_Testing policy` | Who can get a PCR test (tests for current infection, not antibodies). 0 = no testing policy; 1 = only people who both have symptoms and meet specific criteria (e.g., key workers, hospital admissions, contacts of known cases, returning travellers); 2 = anyone showing COVID-19 symptoms; 3 = open public testing (e.g., drive-through testing available to people without symptoms). No flag variable. |
| `H2_Notes` | Coder notes and sources for H2. |
| `H3_Contact tracing` | Contact tracing after a positive diagnosis. 0 = no contact tracing; 1 = limited contact tracing, not done for all cases; 2 = comprehensive contact tracing for all identified cases. No flag variable. |
| `H3_Notes` | Coder notes and sources for H3. |
| `H4_Emergency investment in healthcare` | Announced short-term spending on the healthcare system (e.g., hospitals, masks), in USD. Recorded on the day of announcement only. Not used in any index. |
| `H4_Notes` | Coder notes and sources for H4. |
| `H5_Investment in vaccines` | Announced public spending on COVID-19 vaccine development, in USD. Recorded on the day of announcement only. Not used in any index. |
| `H5_Notes` | Coder notes and sources for H5. |
| `H6E_Facial Coverings` | Rules on wearing face coverings outside the home, applies to everyone. 0 = no policy; 1 = recommended; 2 = required in some specified shared or public spaces where other people are present, or in some situations where social distancing is not possible; 3 = required in all shared or public spaces where other people are present, or in all situations where social distancing is not possible; 4 = required outside the home at all times, whatever the location or whether other people are present. |
| `H6E_Flag` | Geographic scope of H6E: 0 = targeted, 1 = general. |
| `H6NV_Facial Coverings` | Face covering requirements for non-vaccinated people (same scale as H6E)†. |
| `H6NV_Flag` | Geographic scope of H6NV†. |
| `H6V_Facial Coverings` | Face covering requirements for vaccinated people (same scale as H6E)†. |
| `H6V_Flag` | Geographic scope of H6V†. |
| `H6_Notes` | Coder notes and sources for H6. |
| `H7_Vaccination policy` | Which groups can get a COVID-19 vaccine. 0 = not available; 1 = available to one of the following groups: key workers, clinically vulnerable (non-elderly) people, elderly people; 2 = available to two of these groups; 3 = available to all three groups; 4 = available to all three groups plus partial additional availability (selected broad groups or ages); 5 = universal availability. |
| `H7_Flag` | Funding of H7 vaccinations: 0 = at cost to the individual (or funded by an NGO or insurance, or only partly by government); 1 = no or minimal cost to the individual (government funded or subsidised). |
| `H7_Notes` | Coder notes and sources for H7. |
| `H8E_Protection of elderly people`† | Measures to protect elderly people in long-term care facilities (LTCFs) and at home, applies to everyone. 0 = no measures; 1 = recommended isolation, hygiene, and visitor restrictions in LTCFs, and/or elderly people advised to stay home; 2 = narrow restrictions on isolation and hygiene in LTCFs, some limits on outside visitors, and/or restrictions protecting elderly people at home; 3 = extensive restrictions on isolation and hygiene in LTCFs, all non-essential outside visitors banned, and/or all elderly people required to stay home with minimal exceptions and no outside visitors. |
| `H8E_Flag` | Geographic scope of H8E: 0 = targeted, 1 = general†. |
| `H8NV_Protection of elderly people` | Elderly protection measures applying to non-vaccinated people (same scale as H8E)†. |
| `H8NV_Flag` | Geographic scope of H8NV†. |
| `H8V_Protection of elderly people` | Elderly protection measures applying to vaccinated people (same scale as H8E)†. |
| `H8V_Flag` | Geographic scope of H8V†. |
| `H8_Notes` | Coder notes and sources for H8. |

## M: Miscellaneous

| Column | Description |
|---|---|
| `M1_Notes` | M1 "wildcard": free text describing other notable policy responses that the indicators above do not capture. Not used in any index. |

## V: Vaccination policies† (summary indicators)

| Column | Description |
|---|---|
| `V1_Vaccine Prioritisation (summary)` | Whether a plan sets priority groups for vaccination. 0 = no plan; 1 = a plan with priority groups is in place; 2 = universal eligibility, with no prioritisation between groups. (US national: 0 → 1 on 2020-12-01 → 2 on 2021-04-19.) |
| `V1_Notes` | Coder notes and sources for V1. |
| `V2A_Vaccine Availability (summary)` | Vaccine eligibility. 0 = no categories receiving vaccines; 1 = vaccines available to some categories; 2 = available to anyone over 16; 3 = available to anyone over 16 plus one or both of the 5–15 and 0–4 age groups. |
| `V2_Notes` | Coder notes and sources for V2 (V2A–V2G). |
| `V2B_Vaccine age eligibility/availability age floor (general population summary)` | Youngest age band of the "General" population category currently receiving vaccines (text band, e.g., "80+ yrs", "16-19 yrs", "5-15 yrs", "0-4 yrs"). 0 = no categories receiving vaccines; blank = no data. |
| `V2C_Vaccine age eligibility/availability age floor (at risk summary)` | Youngest age band in either the "General" or the "At-risk" category currently receiving vaccines (text band). 0 = no categories receiving vaccines; blank = no data. |
| `V2D_Medically/ clinically vulnerable (Non-elderly)` | Eligibility of non-elderly medically or clinically vulnerable people, measured by how many of the group's sub-categories are receiving vaccines. 0 = none; 1 = one or two sub-categories; 2 = three or more sub-categories, or all general-population age bands from 16–19 to 80+ eligible. Blank = no data (before vaccines were available). |
| `V2E_Education` | Eligibility of education workers, by sub-category count. 0 = none; 1 = one sub-category; 2 = two or more sub-categories, or all general age bands from 16–19 to 80+ eligible. |
| `V2F_Frontline workers  (non healthcare)` | Eligibility of frontline workers outside healthcare, by sub-category count. 0 = none; 1 = one or two sub-categories; 2 = three or more sub-categories, or all general age bands from 16–19 to 80+ eligible. Selecting "Frontline/essential workers (when subcategories not specified)" automatically gives 2. Note the double space in the column name. |
| `V2G_Frontline workers  (healthcare)` | Eligibility of frontline healthcare workers, by sub-category count. 0 = none; 1 = one sub-category; 2 = two sub-categories, or all general age bands from 16–19 to 80+ eligible. Note the double space in the column name. |
| `V3_Vaccine Financial Support (summary)` | Who pays for vaccination. 0 = no vaccines available; 1 = full cost paid by the individual, for all categories; 2 = full cost paid by the individual for some categories, with government subsidies for others; 3 = partial government funding for all categories; 4 = partial government funding for some categories, full funding for others; 5 = all categories fully funded by the government. (US national: 0 → 5 on 2020-12-14.) |
| `V3_Notes` | Coder notes and sources for V3. |
| `V4_Mandatory Vaccination (summary)` | Whether vaccination is mandatory. 0 = no requirement; 1 = vaccination required for one or more groups. |
| `V4_Notes` | Coder notes and sources for V4. |

## Epidemiological and vaccination coverage data

| Column | Description |
|---|---|
| `ConfirmedCases` | Cumulative number of reported COVID-19 cases since the start of the pandemic. The paper names the external sources as the European Centre for Disease Prevention and Control and Johns Hopkins University. |
| `ConfirmedDeaths` | Cumulative number of deaths attributed to COVID-19 since the start of the pandemic, from the same sources. |
| `MajorityVaccinated` | Whether most of the population is fully vaccinated: `NV` = majority unvaccinated (under 50% fully vaccinated), `V` = majority vaccinated; blank = no data. Source: mainly Our World in Data's "people fully vaccinated per hundred" series. (US national switches to `V` on 2021-07-09.)† |
| `PopulationVaccinated` | Percentage of the population fully vaccinated (0–100), mainly from Our World in Data; blank = no data†. Used as the weight in the `*_WeightedAverage` indices. |

## Composite indices (0–100)

To build each index, OxCGRT first gives each component indicator a sub-index score: I = 100 × (v − 0.5 × (F − f)) / N. Here v is the recorded level, N is the indicator's maximum, F = 1 if the indicator has a flag (0 otherwise), and f is the recorded flag. A targeted policy therefore loses half a point. A missing value or a value of 0 scores 0. The index is the simple average of its k sub-index scores. The variants differ as follows†:

- `_NonVaccinated` uses the `E` value, or the `NV` value when the policy differs by vaccination status.
- `_Vaccinated` uses the `E` value, or the `V` value when the policy differs.
- `_SimpleAverage` is the mean of the non-vaccinated and vaccinated versions.
- `_WeightedAverage` weights the two versions by vaccination coverage: NV × (1 − p) + V × p, where p = `PopulationVaccinated` / 100.

| Column | Description |
|---|---|
| `StringencyIndex_NonVaccinated` | Stringency ("lockdown") index for non-vaccinated people. Components: C1–C8 and H1 (k = 9). |
| `StringencyIndex_Vaccinated` | Stringency index for vaccinated people. |
| `StringencyIndex_SimpleAverage` | Simple average of the two stringency indices. |
| `StringencyIndex_WeightedAverage` | Average of the two stringency indices, weighted by vaccination coverage. |
| `GovernmentResponseIndex_NonVaccinated` | Overall government response index for non-vaccinated people. Components: C1–C8, E1–E2, H1–H3, H6–H8 (k = 16 per the codebook; the paper lists k = 13, before H6–H8 were added). |
| `GovernmentResponseIndex_Vaccinated` | Overall government response index for vaccinated people. |
| `GovernmentResponseIndex_SimpleAverage` | Simple average of the two government response indices. |
| `GovernmentResponseIndex_WeightedAverage` | Average of the two government response indices, weighted by vaccination coverage. |
| `ContainmentHealthIndex_NonVaccinated` | Containment and health index for non-vaccinated people. Components: C1–C8, H1–H3, H6–H8 (k = 14 per the codebook; the paper lists k = 11). |
| `ContainmentHealthIndex_Vaccinated` | Containment and health index for vaccinated people. |
| `ContainmentHealthIndex_SimpleAverage` | Simple average of the two containment and health indices. |
| `ContainmentHealthIndex_WeightedAverage` | Average of the two containment and health indices, weighted by vaccination coverage. |
| `EconomicSupportIndex` | Economic support index. Components: E1–E2 (k = 2). These policies are not differentiated by vaccination status, so there is only one version. |
