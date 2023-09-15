# Cancer-Tumor-Diagnosis-Machine-Learning
# Cancer Tumor Diagnosis with Machine Learning 🩺📊

## Introduction 📝

Machine learning is a powerful concept and tool that can be applied to numerous real-world applications. In this project, we leverage machine learning to work with cancer data to diagnose whether a specific tumor is benign or malignant. 

A benign tumor is non-cancerous and does not spread, while a malignant tumor is cancerous and could potentially spread throughout the body. The significance of this project lies in its potential to provide important insights and solutions for cancer diagnosis and treatment.

Cancer is a major global health concern, with millions of individuals being diagnosed each year. In the United States alone, cancer is the second leading cause of death. In 2023, approximately two million individuals are expected to be diagnosed with some form of cancer. In this project, we focus on breast cancer, which accounts for approximately 15% of all cancer diagnoses.

## Data & Variables 📊

### Data Source
The dataset used for this project was obtained from Kaggle.com and is titled "Cancer Data, Benign and Malignant Cancer Data." It comprises observations on 570 different tumors, with 30 independent quantitative variables describing the tumor and one qualitative response variable indicating the diagnosis as benign or malignant.

### Data Preparation
- We transformed the qualitative response variable into a quantitative value, with 'benign' represented as '0' and 'malignant' as '1'.
- Lasso variable selection was performed to choose the most significant variables, resulting in 22 important features for all models.

### Variables Used
Here are the variables used in our models:
- Mean values (denoted as 'mean') for various tumor characteristics
- Standard error values (denoted as 'SE') for the same characteristics
- Worst values (denoted as 'worst'), representing the mean of the three largest/worst values for these characteristics

## Statistics & Data Visualization 📈

We provided summary statistics for the 22 variables used in our models, including minimum, median, mean, and maximum values, along with quartiles.

We used histograms and box plots to visualize the data, making it easier to understand the distribution and identify common and uncommon values for each variable. The box plots specifically differentiate between benign and malignant cells.

## Models 🧠

### Generalized Linear Model (GLM) 📈
- Advantages: Flexibility, interpretability, ability to handle non-normal distributions.
- Disadvantages: Limited application for complex relationships, assumption of independence.

### Naive Bayesian Model 📊
- Advantages: Simplicity, efficiency, scalability, and interpretability.
- Disadvantages: Independence assumption, limited expressiveness.

### Decision Tree 🌳
- Advantages: Simple, easy to understand, feature selection, non-parametric.
- Disadvantages: Overfitting, instability, bias, limited predictive power.

### Pruned Tree 🌲
- We pruned the decision tree to combat overfitting, resulting in a more stable model.
- Pruning may not always improve performance; the base decision tree may be more suitable.

### Random Forest 🌲🌳
- Advantages: High accuracy, resilience to noise and outliers, handles large datasets, feature importance.
- Disadvantages: Overfitting, interpretability, computational expense, biased in unbalanced data.

## Model Selection 📊

- The Random Forest model achieved the highest accuracy and AUC among all models.
- Four most important variables for classification: Area_worst, concave.points_worst, radius_worst, and concave.points_mean.

## Conclusion 🏁

In conclusion, this project demonstrates the power of machine learning in diagnosing breast cancer tumors. The Random Forest model emerged as the best-performing model, offering high accuracy and predictive power. It identified four crucial variables for tumor classification.

By focusing on these attributes, cancer researchers can gain valuable insights into tumor behavior, potentially leading to improved cancer diagnosis and treatment strategies.

## References 📚

- [National Cancer Institute - Cancer Stat Facts](https://seer.cancer.gov/statfacts/html/common.html)
- [NCI Dictionary of Cancer Terms - Benign](https://www.cancer.gov/publications/dictionaries/cancer-terms/def/benign)
- [NCI Dictionary of Cancer Terms - Malignant](https://www.cancer.gov/publications/dictionaries/cancer-terms/def/malignant)

## Appendix 📁

- Additional visualizations and details can be found in the [Appendix](appendix.md) file.

