rm(list = ls())
library(UWBiost561)

# Load simulation results
load("HW4_simulation.RData")

# Summarize
summary_valid <- aggregate(valid ~ alpha + method, data = simulation_results, FUN = mean)
summary_size  <- aggregate(clique_size ~ alpha + method, data = simulation_results,
                           FUN = mean, na.rm = TRUE)

alpha_levels <- sort(unique(simulation_results$alpha))
methods <- 1:9
colors  <- rainbow(9)

png("HW4_simulation.png", width = 1400, height = 600, res = 120)
par(mfrow = c(1, 2), mar = c(5, 5, 4, 2))

# Panel 1: Success Rate
plot(NULL, xlim = c(1, 4), ylim = c(0, 1), xaxt = "n",
     xlab = "Alpha", ylab = "Success Rate",
     main = "Success Rate by Alpha Level")
axis(1, at = 1:4, labels = alpha_levels)
abline(h = seq(0, 1, 0.25), col = "grey85", lty = 2)
for (m in methods) {
  vals <- summary_valid$valid[summary_valid$method == m]
  lines(1:4, vals, col = colors[m], lwd = 2)
  points(1:4, vals, col = colors[m], pch = 16, cex = 1.2)
}
legend("bottomleft", legend = paste("Method", methods),
       col = colors, lwd = 2, pch = 16, cex = 0.7, ncol = 3)

# Panel 2: Mean Clique Size
plot(NULL, xlim = c(1, 4), ylim = c(0, max(summary_size$clique_size, na.rm = TRUE) + 1),
     xaxt = "n", xlab = "Alpha", ylab = "Mean Clique Size",
     main = "Mean Clique Size by Alpha Level")
axis(1, at = 1:4, labels = alpha_levels)
abline(h = seq(0, 20, 2), col = "grey85", lty = 2)
for (m in methods) {
  vals <- summary_size$clique_size[summary_size$method == m]
  lines(1:4, vals, col = colors[m], lwd = 2)
  points(1:4, vals, col = colors[m], pch = 16, cex = 1.2)
}
legend("topright", legend = paste("Method", methods),
       col = colors, lwd = 2, pch = 16, cex = 0.7, ncol = 3)

mtext("Simulation Study: 9 Implementations Across Alpha Levels",
      side = 3, line = -1.5, outer = TRUE, cex = 1.1, font = 2)
dev.off()rm(list = ls())
library(UWBiost561)

# Load simulation results
load("HW4_simulation.RData")

# Summarize
summary_valid <- aggregate(valid ~ alpha + method, data = simulation_results, FUN = mean)
summary_size  <- aggregate(clique_size ~ alpha + method, data = simulation_results,
                           FUN = mean, na.rm = TRUE)

alpha_levels <- sort(unique(simulation_results$alpha))
methods <- 1:9
colors  <- rainbow(9)

png("HW4_simulation.png", width = 1400, height = 600, res = 120)
par(mfrow = c(1, 2), mar = c(5, 5, 4, 2))

# Panel 1: Success Rate
plot(NULL, xlim = c(1, 4), ylim = c(0, 1), xaxt = "n",
     xlab = "Alpha", ylab = "Success Rate",
     main = "Success Rate by Alpha Level")
axis(1, at = 1:4, labels = alpha_levels)
abline(h = seq(0, 1, 0.25), col = "grey85", lty = 2)
for (m in methods) {
  vals <- summary_valid$valid[summary_valid$method == m]
  lines(1:4, vals, col = colors[m], lwd = 2)
  points(1:4, vals, col = colors[m], pch = 16, cex = 1.2)
}
legend("bottomleft", legend = paste("Method", methods),
       col = colors, lwd = 2, pch = 16, cex = 0.7, ncol = 3)

# Panel 2: Mean Clique Size
plot(NULL, xlim = c(1, 4), ylim = c(0, max(summary_size$clique_size, na.rm = TRUE) + 1),
     xaxt = "n", xlab = "Alpha", ylab = "Mean Clique Size",
     main = "Mean Clique Size by Alpha Level")
axis(1, at = 1:4, labels = alpha_levels)
abline(h = seq(0, 20, 2), col = "grey85", lty = 2)
for (m in methods) {
  vals <- summary_size$clique_size[summary_size$method == m]
  lines(1:4, vals, col = colors[m], lwd = 2)
  points(1:4, vals, col = colors[m], pch = 16, cex = 1.2)
}
legend("topright", legend = paste("Method", methods),
       col = colors, lwd = 2, pch = 16, cex = 0.7, ncol = 3)

mtext("Simulation Study: 9 Implementations Across Alpha Levels",
      side = 3, line = -1.5, outer = TRUE, cex = 1.1, font = 2)
dev.off()
