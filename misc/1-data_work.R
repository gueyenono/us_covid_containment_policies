# Build a state x day panel of the OxCGRT containment indicators (C1-C8) that
# make up the stringency index, coded from state-government policies only
# (STATE_WIDE: excludes federal policies). See
# data/raw/covid/OxCGRT_raw_USA_v1-data_dictionary.md for column definitions.
#
# For each indicator the script keeps:
#   - <id>_level: ordinal policy level for non-vaccinated people, i.e. the E
#     (everyone) value, or the NV value on days when the policy differs by
#     vaccination status (from 2021-01-11 onwards). This is the series that
#     feeds OxCGRT's StringencyIndex_NonVaccinated.
#   - <id>_flag:  geographic scope (0 = targeted, 1 = statewide); none for C8.
#   - <id>_score: OxCGRT sub-index score on 0-100,
#                 100 * (level - 0.5 * (1 - flag)) / max_level, 0 if level is 0.

library(dplyr)
library(tidyr)
library(purrr)

# Indicators -------------------------------------------------------------------

indicators <- tibble::tribble(
  ~id,  ~name,                               ~max_level, ~has_flag, ~vax_split,
  "C1", "School closing",                    3,          TRUE,      TRUE,
  "C2", "Workplace closing",                 3,          TRUE,      TRUE,
  "C3", "Cancel public events",              2,          TRUE,      TRUE,
  "C4", "Restrictions on gatherings",        4,          TRUE,      TRUE,
  "C5", "Close public transport",            2,          TRUE,      TRUE,
  "C6", "Stay at home requirements",         3,          TRUE,      TRUE,
  "C7", "Restrictions on internal movement", 2,          TRUE,      TRUE,
  "C8", "International travel controls",     4,          FALSE,     TRUE,
  # H1 is not a containment policy but is the 9th stringency component; it is
  # only used below to check the scores against the published index.
  "H1", "Public information campaigns",      2,          TRUE,      FALSE
)

# Read -------------------------------------------------------------------------

# Every column is read as character first: the NV/V columns are empty for the
# first year, so readr's type guessing would turn them into logicals and drop
# their later values.
covid <- readr::read_csv(
  file = here::here("data/raw/covid/OxCGRT_raw_USA_v1.csv"),
  col_types = readr::cols(.default = readr::col_character()),
  col_select = !ends_with("_Notes")
)

states <- covid |>
  filter(Jurisdiction == "STATE_WIDE") |>
  mutate(
    state_code = sub("^US_", "", RegionCode),
    state_name = RegionName,
    date = as.Date(Date, format = "%Y%m%d"),
    across(c(matches("^[CH][0-9]"), StringencyIndex_NonVaccinated,
             ConfirmedCases, ConfirmedDeaths, PopulationVaccinated),
           as.numeric)
  )

# Indicator levels, flags and scores --------------------------------------------

score_indicator <- function(level, flag, max_level, has_flag) {
  penalty <- if (has_flag) 0.5 * (1 - coalesce(flag, 0)) else 0
  if_else(coalesce(level, 0) > 0, 100 * (level - penalty) / max_level, 0)
}

build_indicator <- function(id, name, max_level, has_flag, vax_split) {
  if (vax_split) {
    level <- coalesce(states[[paste0(id, "E_", name)]],
                      states[[paste0(id, "NV_", name)]])
    flag <- if (has_flag) {
      coalesce(states[[paste0(id, "E_Flag")]], states[[paste0(id, "NV_Flag")]])
    }
  } else {
    level <- states[[paste0(id, "_", name)]]
    flag <- states[[paste0(id, "_Flag")]]
  }

  out <- tibble(level = level, flag = flag,
                score = score_indicator(level, flag, max_level, has_flag))
  names(out) <- paste0(tolower(id), "_", names(out))
  out
}

indicator_cols <- pmap(indicators, build_indicator) |> list_cbind()

panel <- states |>
  select(state_code, state_name, date) |>
  bind_cols(indicator_cols) |>
  mutate(
    # TRUE on days when at least one C indicator differs by vaccination status
    vax_differentiated = states |>
      select(matches("^C[1-8]NV_")) |>
      mutate(across(everything(), \(x) !is.na(x))) |>
      reduce(`|`),
    stringency_index = states$StringencyIndex_NonVaccinated,
    confirmed_cases = states$ConfirmedCases,
    confirmed_deaths = states$ConfirmedDeaths,
    population_vaccinated = states$PopulationVaccinated
  )

# Check: the nine scores reproduce OxCGRT's published stringency index ----------

recomputed_index <- panel |>
  select(matches("^(c[1-8]|h1)_score$")) |>
  rowMeans()
max_gap <- max(abs(recomputed_index - panel$stringency_index))
stopifnot(max_gap < 0.01)

stopifnot(
  n_distinct(panel$state_code) == 51,
  !anyDuplicated(panel[c("state_code", "date")]),
  !anyNA(select(panel, matches("^c[1-8]_level$")))
)

# Save -------------------------------------------------------------------------

panel <- panel |>
  select(-starts_with("h1_")) |>
  arrange(state_code, date)

readr::write_csv(
  panel,
  here::here("data/processed/oxcgrt_state_containment_panel.csv")
)
