#' Generate a random adjacency matrix with a partial clique
#'
#' @param n Positive integer. Number of nodes in the graph.
#' @param clique_fraction Numeric in [0,1]. Fraction of nodes that form the partial clique.
#' @param clique_edge_density Numeric in [0,1]. Edge density among the clique nodes.
#'
#' @return A list with element \code{adj_mat}, a symmetric 0/1 matrix with 1s on the diagonal.
#' @export
generate_partial_clique <- function(n = 10,
                                    clique_fraction = 0.5,
                                    clique_edge_density = 0.9) {
  
  # Input validation
  stopifnot(
    "n must be a positive integer" = is.numeric(n) && length(n) == 1 &&
      n == round(n) && n > 0,
    "clique_fraction must be a single numeric in [0,1]" =
      is.numeric(clique_fraction) && length(clique_fraction) == 1 &&
      clique_fraction >= 0 && clique_fraction <= 1,
    "clique_edge_density must be a single numeric in [0,1]" =
      is.numeric(clique_edge_density) && length(clique_edge_density) == 1 &&
      clique_edge_density >= 0 && clique_edge_density <= 1
  )
  n <- as.integer(n)
  m <- round(n * clique_fraction)      # number of clique nodes
  
  # Initialize adjacency matrix with zeros
  adj_mat <- matrix(0L, nrow = n, ncol = n)
  diag(adj_mat) <- 1L
  
  # Sample which nodes form the clique
  clique_nodes <- sample(1:n, size = m, replace = FALSE)
  
  # Determine required number of clique edges
  max_edges <- m * (m - 1) / 2
  required_edges <- round(clique_edge_density * max_edges)
  if (max_edges > 0 && required_edges > 0) {
    # All possible pairs within the clique
    pairs <- combn(clique_nodes, 2)          # 2 x max_edges matrix
    selected <- sample(1:ncol(pairs),
                       size = required_edges,
                       replace = FALSE)
    for (k in selected) {
      i <- pairs[1, k]; j <- pairs[2, k]
      adj_mat[i, j] <- 1L
      adj_mat[j, i] <- 1L
    }
  }
  
  list(adj_mat = adj_mat, clique_nodes = clique_nodes)
}
