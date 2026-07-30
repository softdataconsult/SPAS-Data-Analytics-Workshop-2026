# Data Analytics for Scientific Research & Innovation
**Facilitator:** Dr. Isaac Oluwaseyi Ajao  
**Institution:** School of Pure and Applied Sciences (SPAS), Federal Polytechnic, Ado-Ekiti  
**Event:** SPAS 1st Biennial International Conference (August 10–13, 2026)  

---

## 📁 Workshop Resources

| Resource | File Link | Description |
| :--- | :--- | :--- |
| **Training Dataset (CSV)** | [`SPAS_Conference_Training_Data.csv`](./SPAS_Conference_Training_Data.csv) | Primary dataset for SPSS hands-on exercises |
| **Presentation Slides (PDF)** | [`training_slide2.pdf`](./training_slide2.pdf) | Workshop Beamer PDF slide deck |
| **Quarto Source Code** | [`training_slide2.qmd`](./training_slide2.qmd) | Source `.qmd` file for slides |

---

## 📊 Dataset Structure (60 Samples)

The dataset (`SPAS_Conference_Training_Data.csv`) includes data simulated across **Microbiology**, **Applied Chemistry**, and **Food Science** for the following SPSS exercises:

1. **Normality Test (Shapiro-Wilk):** `Enzyme_Activity`
2. **Independent Samples t-Test:** `Shelf_Life_Days` across `Packaging_Type`
3. **One-Way ANOVA & Tukey Post-Hoc:** `Enzyme_Activity` across `Department`
4. **Simple Linear Regression:** `Yield_Pct` predicted by `Temperature_C`

---

## 📥 Direct Raw CSV Link for R / Python
If you want to read the dataset directly into R or Python:

```r
# Load directly into R
data <- read.csv("[https://raw.githubusercontent.com/YOUR_GITHUB_USERNAME/SPAS-Data-Analytics-Workshop-2026/main/SPAS_Conference_Training_Data.csv](https://raw.githubusercontent.com/YOUR_GITHUB_USERNAME/SPAS-Data-Analytics-Workshop-2026/main/SPAS_Conference_Training_Data.csv)")