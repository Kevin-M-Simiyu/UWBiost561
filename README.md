# UWBiost561

## Overview

`UWBiost561` is an R package developed for the University of Washington BIOST 561 course (Spring 2026). The package provides functions for generating random graphs with partial cliques and computing the maximal partial clique from an adjacency matrix.

## Installation

You can install the package from GitHub with:

```r
# install.packages("devtools")
devtools::install_github("Kevin-M-Simiyu/UWBiost561")
```

## Main Functions

### `generate_partial_clique()`

Generates a random adjacency matrix with a partial clique of a specified size and edge density.

```r
library(UWBiost561)

set.seed(0)
simulation <- UWBiost561::generate_partial_clique(
  n = 10,
  clique_fraction = 0.5,
  clique_edge_density = 0.9
)

simulation$adj_mat
```

- `n`: number of nodes in the graph
- `clique_fraction`: fraction of nodes that form the partial clique
- `clique_edge_density`: edge density among the nodes in the clique (1 = fully connected)

### `compute_maximal_partial_clique()`

Computes the largest partial clique in a given adjacency matrix at a required edge density `alpha`.

```r
set.seed(0)
simulation <- UWBiost561::generate_partial_clique(
  n = 10,
  clique_fraction = 0.5,
  clique_edge_density = 0.9
)

res <- UWBiost561::compute_maximal_partial_clique(
  adj_mat = simulation$adj_mat,
  alpha = 0.9
)

res$clique_idx     # indices of nodes in the maximal partial clique
res$edge_density   # edge density among the selected nodes
```

- `adj_mat`: a symmetric adjacency matrix with values 0 or 1 and 1s on the diagonal
- `alpha`: required edge density threshold (between 0.5 and 1)

## Vignettes

The package includes vignettes for Homework 1 through 4 from the BIOST 561 course:

```r
browseVignettes("UWBiost561")
```

## License

MIT
