# Clear workspace
# ------------------------------------------------------------------------------
rm(list=ls())

# Load libraries
# ------------------------------------------------------------------------------
library('tidyverse')
library('cowplot')

# Set seed for reproducibility
# ------------------------------------------------------------------------------
set.seed(584167)

# Synthesise data
x = runif(n = 1000, min = 0, max = 10)
y = rep(x = NA, 1000)
y[which(x<5)]  = runif(n = length(which(x<5)), min = 0, max = 5)
y[which(x>=5)] = runif(n = length(which(x>=5)), min = 5, max = 10)
d = tibble(x = x, y = y)

# Create plot objects
# ------------------------------------------------------------------------------

# p1: Density plot of x
p1 = d %>% ggplot(aes(x = x)) +
  geom_density() +
  theme_bw()

# p2: Density plot of y
p2 = d %>% ggplot(aes(x = y)) +
  geom_density() +
  theme_bw()

# p3: Scatter/contour plot of x,y
p3 = d %>% ggplot(aes(x = x, y = y)) +
  geom_point() +
  geom_density_2d() +
  theme_bw()

# Setup multi-plotting
p = ggdraw() +
  draw_plot(plot = p1, x = 0.0, y = 0.5, width = 0.5, height = 0.5) +
  draw_plot(plot = p2, x = 0.5, y = 0.5, width = 0.5, height = 0.5) +
  draw_plot(plot = p3, x = 0.0, y = 0.0, width = 1.0, height = 0.5) +
  draw_plot_label(label = c("A", "B", "C"), x = c(0, 0.5, 0), y = c(1, 1, 0.5),
                  size = 10)

# Setup labels
# ------------------------------------------------------------------------------
A = 'A: Density plot of x - no apparent grouping.'
B = 'B: Density plot of y - no apparent grouping'
C = 'C: Scatter plot of x and y with 2d contour lines - obvious grouping.'
D = 'Leon Eyrich Jessen, June 2017'
p = p + labs(title   = 'Univariate versus multivariate',
             caption = paste0(A,' ',B,' ',C,"\n",D))

# Plot
# ------------------------------------------------------------------------------
ggsave(filename = 'univariate_vs_multivariate.png', plot = p,
       width = 16, height = 9)
