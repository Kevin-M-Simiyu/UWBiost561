test_that("generate_partial_clique returns correct structure", {
  res <- UWBiost561::generate_partial_clique(n = 10, clique_fraction = 0.5,
                                             clique_edge_density = 0.9)
  expect_true(is.list(res))
  expect_true("adj_mat" %in% names(res))
})

test_that("adj_mat is a valid symmetric 0/1 matrix with 1s on diagonal", {
  res <- UWBiost561::generate_partial_clique(n = 10, clique_fraction = 0.5,
                                             clique_edge_density = 0.9)
  mat <- res$adj_mat
  expect_true(is.matrix(mat))
  expect_equal(nrow(mat), 10)
  expect_equal(ncol(mat), 10)
  expect_true(all(mat %in% c(0L, 1L)))
  expect_true(isSymmetric(mat))
  expect_true(all(diag(mat) == 1))
  expect_null(rownames(mat))
  expect_null(colnames(mat))
})

test_that("clique has at least the required number of edges", {
  set.seed(42)
  res <- UWBiost561::generate_partial_clique(n = 20, clique_fraction = 0.5,
                                             clique_edge_density = 0.8)
  idx <- res$clique_nodes
  m <- length(idx)
  actual_edges <- (sum(res$adj_mat[idx, idx]) - m) / 2
  required_edges <- round(0.8 * m * (m - 1) / 2)
  expect_gte(actual_edges, required_edges)
})

test_that("invalid inputs throw errors", {
  expect_error(UWBiost561::generate_partial_clique(n = -1))
  expect_error(UWBiost561::generate_partial_clique(n = 10, clique_fraction = 1.5))
  expect_error(UWBiost561::generate_partial_clique(n = 10, clique_edge_density = -0.1))
})

