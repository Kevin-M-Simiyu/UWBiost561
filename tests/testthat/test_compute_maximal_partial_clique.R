# Category 1: Input validation — bad inputs throw errors
test_that("invalid inputs throw errors", {
  set.seed(0)
  sim <- project561::generate_partial_clique(n = 10, clique_fraction = 0.5,
                                             clique_edge_density = 0.9)
  mat <- sim$adj_mat

  expect_error(project561::compute_maximal_partial_clique(adj_mat = mat, alpha = 0.3))
  expect_error(project561::compute_maximal_partial_clique(adj_mat = mat, alpha = 1.5))
  expect_error(project561::compute_maximal_partial_clique(adj_mat = as.data.frame(mat),
                                                          alpha = 0.9))
})

# Category 2: Output structure — correct names and types
test_that("output has correct structure", {
  set.seed(1)
  sim <- project561::generate_partial_clique(n = 10, clique_fraction = 0.5,
                                             clique_edge_density = 0.9)
  res <- project561::compute_maximal_partial_clique(adj_mat = sim$adj_mat, alpha = 0.9)

  expect_true(is.list(res))
  expect_true("clique_idx" %in% names(res))
  expect_true("edge_density" %in% names(res))
  expect_true(is.numeric(res$clique_idx))
  expect_true(is.numeric(res$edge_density))
})

# Category 3: Output validity — edge density constraint is satisfied
test_that("returned clique meets the alpha edge density requirement", {
  set.seed(2)
  sim <- project561::generate_partial_clique(n = 15, clique_fraction = 0.5,
                                             clique_edge_density = 0.9)
  res <- project561::compute_maximal_partial_clique(adj_mat = sim$adj_mat, alpha = 0.9)

  idx <- res$clique_idx
  m <- length(idx)
  actual_density <- (sum(sim$adj_mat[idx, idx]) - m) / (m * (m - 1))
  expect_gte(actual_density, 0.9)
  expect_equal(res$edge_density, actual_density)
})

# Category 4: Correctness — recovers a clearly planted clique
test_that("recovers a large obvious planted clique", {
  set.seed(3)
  # Plant a near-perfect clique in a sparse background
  sim <- project561::generate_partial_clique(n = 10, clique_fraction = 0.6,
                                             clique_edge_density = 1.0)
  res <- project561::compute_maximal_partial_clique(adj_mat = sim$adj_mat, alpha = 0.9)

  # Should find at least as many nodes as the planted clique
  expect_gte(length(res$clique_idx), round(10 * 0.6))
})

# Category 5: Edge case — minimal valid matrix (5x5, identity-like)
test_that("works on a minimal 5x5 diagonal matrix", {
  mat <- diag(5)
  res <- project561::compute_maximal_partial_clique(adj_mat = mat, alpha = 0.5)

  expect_true(length(res$clique_idx) >= 1)
  expect_true(all(res$clique_idx >= 1))
  expect_true(all(res$clique_idx <= 5))
  expect_gte(res$edge_density, 0)
})
