.libPaths(c("/home/users/kevsim98/R/library", .libPaths()))
rm(list = ls())
library(UWBiost561)

alpha_levels      <- c(0.5, 0.7, 0.9, 1.0)
n_trials          <- 10
n                 <- 20
clique_fraction   <- 0.5
clique_edge_density <- 0.95
time_limit        <- 30

simulation_results <- UWBiost561::run_simulation(
  alpha_levels        = alpha_levels,
  n_trials            = n_trials,
  n                   = n,
  clique_fraction     = clique_fraction,
  clique_edge_density = clique_edge_density,
  time_limit          = time_limit
)

date_of_run  <- Sys.time()
session_info <- devtools::session_info()

save(simulation_results, alpha_levels, date_of_run, session_info,
     file = "~/HW4_simulation.RData")
