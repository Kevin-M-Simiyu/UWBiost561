#' Run a simulation study comparing all 9 partial clique implementations
#'
#' For each combination of alpha level and trial, generates one random adjacency
#' matrix and applies all 9 implementations of compute_maximal_partial_clique.
#' Records the clique size, status, and validity of each result.
#'
#' @param alpha_levels A numeric vector of alpha values to test (each between 0.5 and 1).
#' @param n_trials Integer. Number of trials per alpha level.
#' @param n Integer. Number of nodes in each generated graph.
#' @param clique_fraction Numeric. Fraction of nodes forming the planted clique.
#' @param clique_edge_density Numeric. Edge density among planted clique nodes.
#' @param time_limit Numeric. Max seconds allowed per implementation call.
#'
#' @return A data frame with one row per (alpha, trial, method) combination, containing:
#'   \itemize{
#'     \item alpha: the alpha level for this trial
#'     \item trial: the trial number
#'     \item method: implementation number (1-9)
#'     \item clique_size: number of nodes in the returned clique (NA if error/timeout)
#'     \item edge_density: reported edge density (NA if error/timeout)
#'     \item true_density: verified edge density via compute_correct_density()
#'     \item status: "completed", "timed_out", or "error"
#'     \item valid: TRUE if the clique meets the alpha density requirement
#'   }
#' @export
run_simulation <- function(alpha_levels = c(0.5, 0.7, 0.9, 1.0),
                           n_trials = 10,
                           n = 20,
                           clique_fraction = 0.5,
                           clique_edge_density = 0.95,
                           time_limit = 30) {

  results_list <- vector("list", length(alpha_levels) * n_trials * 9)
  idx <- 1

  for (alpha in alpha_levels) {
    for (trial in seq_len(n_trials)) {

      # Set seed per (alpha, trial) for reproducibility
      seed <- as.integer(alpha * 100) * 1000 + trial
      set.seed(seed)
      data <- UWBiost561::generate_partial_clique(
        n = n,
        clique_fraction = clique_fraction,
        clique_edge_density = clique_edge_density
      )
      adj_mat <- data$adj_mat

      for (method in 1:9) {
        result <- UWBiost561::compute_maximal_partial_clique_master(
          adj_mat = adj_mat,
          alpha = alpha,
          number = method,
          time_limit = time_limit
        )

        # Verify density independently regardless of what method reports
        if (result$status == "completed" && !any(is.na(result$clique_idx))) {
          true_density <- UWBiost561::compute_correct_density(
            adj_mat = adj_mat,
            clique_idx = result$clique_idx
          )
          clique_size <- length(result$clique_idx)
        } else {
          true_density <- NA
          clique_size  <- NA
        }

        results_list[[idx]] <- data.frame(
          alpha        = alpha,
          trial        = trial,
          method       = method,
          clique_size  = clique_size,
          edge_density = result$edge_density,
          true_density = true_density,
          status       = result$status,
          valid        = result$valid,
          stringsAsFactors = FALSE
        )
        idx <- idx + 1
      }
    }
  }

  results_df <- do.call(rbind, results_list)
  return(results_df)
}
