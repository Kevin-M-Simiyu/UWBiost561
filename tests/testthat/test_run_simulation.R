# Unit tests for run_simulation()
# Uses small inputs (2 levels, 2 trials, small n) to stay well under one minute.

test_that("run_simulation returns a data frame with correct dimensions", {
  result <- UWBiost561::run_simulation(
    alpha_levels = c(0.5, 0.9),
    n_trials = 2,
    n = 10,
    clique_fraction = 0.5,
    clique_edge_density = 0.95,
    time_limit = 30
  )
  # 2 alpha levels x 2 trials x 9 methods = 36 rows
  expect_true(is.data.frame(result))
  expect_equal(nrow(result), 36)
})

test_that("run_simulation output has the expected columns", {
  result <- UWBiost561::run_simulation(
    alpha_levels = c(0.9),
    n_trials = 2,
    n = 10,
    clique_fraction = 0.5,
    clique_edge_density = 0.95,
    time_limit = 30
  )
  expected_cols <- c("alpha", "trial", "method", "clique_size",
                     "edge_density", "true_density", "status", "valid")
  expect_true(all(expected_cols %in% names(result)))
})

test_that("status column only contains valid values", {
  result <- UWBiost561::run_simulation(
    alpha_levels = c(0.9),
    n_trials = 2,
    n = 10,
    clique_fraction = 0.5,
    clique_edge_density = 0.95,
    time_limit = 30
  )
  expect_true(all(result$status %in% c("completed", "timed_out", "error")))
})

test_that("completed rows have non-NA clique_size and true_density", {
  result <- UWBiost561::run_simulation(
    alpha_levels = c(0.9),
    n_trials = 2,
    n = 10,
    clique_fraction = 0.5,
    clique_edge_density = 0.95,
    time_limit = 30
  )
  completed <- result[result$status == "completed", ]
  expect_true(all(!is.na(completed$clique_size)))
  expect_true(all(!is.na(completed$true_density)))
})

test_that("valid completed rows have true_density >= alpha", {
  result <- UWBiost561::run_simulation(
    alpha_levels = c(0.9),
    n_trials = 2,
    n = 10,
    clique_fraction = 0.5,
    clique_edge_density = 0.95,
    time_limit = 30
  )
  valid_rows <- result[result$valid == TRUE, ]
  expect_true(all(valid_rows$true_density >= valid_rows$alpha))
})

test_that("method column contains only values 1 through 9", {
  result <- UWBiost561::run_simulation(
    alpha_levels = c(0.5),
    n_trials = 2,
    n = 10,
    clique_fraction = 0.5,
    clique_edge_density = 0.95,
    time_limit = 30
  )
  expect_true(all(result$method %in% 1:9))
  expect_equal(sort(unique(result$method)), 1:9)
})
