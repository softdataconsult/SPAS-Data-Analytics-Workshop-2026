# ==============================================================================
# SPAS WORKSHOP: NON-PARAMETRIC STATISTICAL ANALYSIS IN R
# Dataset: SPAS_Conference_Training_Data.csv
# ==============================================================================

# Load required libraries
library(tidyverse)
library(ggpubr)
library(rstatix)

# 1. Load Dataset (or use local path: read.csv("SPAS_Conference_Training_Data.csv"))
url <- "https://raw.githubusercontent.com/softdataconsult/SPAS-Data-Analytics-Workshop-2026/main/SPAS_Conference_Training_Data.csv"
df <- read.csv(url)

# ------------------------------------------------------------------------------
# EXERCISE 1: MEDIAN & INTERQUARTILE RANGE (Descriptive Non-Parametrics)
# ------------------------------------------------------------------------------
# Summary statistics reporting Median & IQR (replaces Mean & SD)
df %>%
  group_by(Department) %>%
  get_summary_stats(Enzyme_Activity, type = "median_iqr")

# ------------------------------------------------------------------------------
# EXERCISE 2: TWO INDEPENDENT GROUPS (Mann-Whitney U Test)
# Equivalent to Independent Samples t-Test
# ------------------------------------------------------------------------------
# Run Mann-Whitney U test (Wilcoxon Rank-Sum Test)
mwu_res <- df %>% 
  wilcox_test(Shelf_Life_Days ~ Packaging_Type) %>%
  add_significance()

print(mwu_res)

# Boxplot Visualization using Median and Ranks
ggboxplot(df, x = "Packaging_Type", y = "Shelf_Life_Days", 
          fill = "Packaging_Type", palette = "jco",
          add = "jitter") +
  stat_compare_means(method = "wilcox.test", label.y = 32) +
  labs(title = "Non-Parametric Shelf Life Comparison (Mann-Whitney U)",
       x = "Packaging Type", y = "Shelf Life (Days)")

# ------------------------------------------------------------------------------
# EXERCISE 3: THREE+ INDEPENDENT GROUPS (Kruskal-Wallis Test & Dunn's Post-Hoc)
# Equivalent to One-Way ANOVA
# ------------------------------------------------------------------------------
# Run Kruskal-Wallis H Test
kw_res <- df %>% 
  kruskal_test(Enzyme_Activity ~ Department)

print(kw_res)

# Pairwise Post-Hoc Comparisons (Dunn's Test with Bonferroni Correction)
dunn_res <- df %>% 
  dunn_test(Enzyme_Activity ~ Department, p.adjust.method = "bonferroni")

print(dunn_res)

# Visualization with Kruskal-Wallis Test
ggboxplot(df, x = "Department", y = "Enzyme_Activity", 
          fill = "Department", palette = "npg") +
  stat_compare_means(method = "kruskal.test", label.y = 75) +
  labs(title = "Enzyme Activity Across Departments (Kruskal-Wallis)",
       x = "Department", y = "Enzyme Activity (U/mL)")

# ------------------------------------------------------------------------------
# EXERCISE 4: MONOTONIC RELATIONSHIP (Spearman Rank Correlation)
# Equivalent to Pearson Correlation / Linear Regression
# ------------------------------------------------------------------------------
# Calculate Spearman Rank Correlation
spearman_res <- df %>% 
  cor_test(Temperature_C, Yield_Pct, method = "spearman")

print(spearman_res)

# Visualizing Monotonic Trend with LOESS / Smooth Curve
ggplot(df, aes(x = Temperature_C, y = Yield_Pct)) +
  geom_point(color = "#003366", size = 3) +
  geom_smooth(method = "loess", color = "#CC0000", se = TRUE) +
  stat_cor(method = "spearman", 
           aes(label = paste(after_stat(r.label), after_stat(p.label), sep = "~`,\n`~")),
           label.x = 30, label.y = 72) +
  labs(title = "Monotonic Association: Yield vs Temperature (Spearman)",
       x = "Temperature (°C)", y = "Yield (%)") +
  theme_minimal()