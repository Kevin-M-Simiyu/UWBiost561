rm(list = ls())
library(UWBiost561)
library(ggplot2)

# Load simulation results
load("~/HW4_simulation.RData")

# Summarize: success rate (valid == TRUE) per alpha level and method
summary_df <- aggregate(valid ~ alpha + method,
                        data = simulation_results,
                        FUN = mean)
summary_df$method <- factor(summary_df$method)
summary_df$alpha  <- factor(summary_df$alpha)

# Plot: success rate by method across alpha levels
p <- ggplot(summary_df, aes(x = alpha, y = valid,
                            color = method, group = method)) +
  geom_line(linewidth = 0.8) +
  geom_point(size = 2.5) +
  scale_y_continuous(limits = c(0, 1), labels = scales::percent) +
  labs(
    title    = "Success Rate of Each Implementation Across Alpha Levels",
    x        = "Alpha (minimum edge density threshold)",
    y        = "Success Rate (proportion of valid cliques)",
    color    = "Implementation"
  ) +
  theme_bw()

# Save to vignettes folder
ggsave("HW4_simulation.png", plot = p, width = 8, height = 5, dpi = 150)
