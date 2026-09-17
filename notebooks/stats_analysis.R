install.packages(c("readr", "dplyr", "ggplot2"))

library(readr)
library(dplyr)

df <- read_csv("data/processed/telco_churn_clean.csv")
str(df)
summary(df)

# Chi-square test: Contract type vs Churn
contract_table <- table(df$Contract, df$Churn)
print(contract_table)
chisq.test(contract_table)

# Chi-square test: TechSupport vs Churn
techsupport_table <- table(df$TechSupport, df$Churn)
print(techsupport_table)
chisq.test(techsupport_table)

# Chi-square test: Tenure group vs Churn
tenure_table <- table(df$tenure_group, df$Churn)
print(tenure_table)
chisq.test(tenure_table)

library(ggplot2)

chi_results <- data.frame(
  factor = c("Contract Type", "Tenure Group", "TechSupport"),
  chi_squared = c(1184.6, 856.1, 828.2)
)

ggplot(chi_results, aes(x = reorder(factor, chi_squared), y = chi_squared)) +
  geom_col(fill = "indianred") +
  coord_flip() +
  labs(
    title = "Strength of Association with Churn (Chi-Square Test)",
    x = "",
    y = "Chi-Squared Statistic"
  ) +
  theme_minimal()

ggsave("dashboard/chi_square_comparison.png", width = 8, height = 5)