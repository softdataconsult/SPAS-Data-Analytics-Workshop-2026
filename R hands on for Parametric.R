# ==============================================================================
# SPAS WORKSHOP: PARAMETRIC STATISTICAL ANALYSIS IN R
# Dataset: SPAS_Conference_Training_Data.csv
# ==============================================================================

# Load required packages
library(tidyverse)
library(ggpubr)
library(rstatix)

# 1. Load Dataset 
df <- read.csv("SPAS_Conference_Training_Data.csv")

# ------------------------------------------------------------------------------
# EXERCISE 1: CHECKING NORMALITY (Shapiro-Wilk Test)
# ------------------------------------------------------------------------------
# Shapiro-Wilk Test for Normality
shapiro_test(df$Enzyme_Activity)

# Q-Q Plot for Visual Evaluation
ggqqplot(df, x = "Enzyme_Activity", title = "Q-Q Plot for Enzyme Activity")


# ------------------------------------------------------------------------------
# EXERCISE 2: TWO-GROUP COMPARISON (Independent Samples t-Test)
# Research Question: Shelf Life difference between Packaging_A and Packaging_B
# ------------------------------------------------------------------------------
# Run Independent Samples t-Test
ttest_res <- t_test(Shelf_Life_Days ~ Packaging_Type, data = df, var.equal = TRUE)
print(ttest_res)

# Boxplot Visualization with Statistics
ggboxplot(df, x = "Packaging_Type", y = "Shelf_Life_Days", 
          fill = "Packaging_Type", palette = "jco",
          add = "jitter") +
  stat_compare_means(method = "t.test", label.y = 32) +
  labs(title = "Product Shelf Life by Packaging Type",
       x = "Packaging Type", y = "Shelf Life (Days)")


# ------------------------------------------------------------------------------
# EXERCISE 3: THREE+ GROUP COMPARISON (One-Way ANOVA & Tukey Post-Hoc)
# Research Question: Mean Enzyme Activity across Academic Departments
# ------------------------------------------------------------------------------
# Compute One-Way ANOVA
anova_res <- aov(Enzyme_Activity ~ Department, data = df)
summary(anova_res)

# Tukey HSD Post-Hoc Pairwise Comparisons
TukeyHSD(anova_res)

# Visualizing Group Differences
ggboxplot(df, x = "Department", y = "Enzyme_Activity", 
          fill = "Department", palette = "npg") +
  stat_compare_means(method = "anova", label.y = 75) +
  labs(title = "Enzyme Activity Across SPAS Departments",
       x = "Department", y = "Enzyme Activity (U/mL)")


# ------------------------------------------------------------------------------
# EXERCISE 4: PREDICTING OUTCOMES (Simple Linear Regression)
# Research Question: Predicting Yield Percentage from Reaction Temperature
# ------------------------------------------------------------------------------
# Fit Linear Regression Model
model <- lm(Yield_Pct ~ Temperature_C, data = df)
summary(model)

# Regression Plot with Equation and R-squared
ggplot(df, aes(x = Temperature_C, y = Yield_Pct)) +
  geom_point(color = "#003366", size = 3) +
  geom_smooth(method = "lm", color = "#CC0000", se = TRUE) +
  stat_regline_equation(label.x = 30, label.y = 80) +
  stat_cor(aes(label = paste(after_stat(rr.label), after_stat(p.label), sep = "~`,\n`~")), 
           label.x = 30, label.y = 72) +
  labs(title = "Effect of Temperature on Extraction Yield",
       x = "Temperature (°C)", y = "Yield (%)") +
  theme_minimal()