# Stat451-Project

## Research Question
The primary question we aim to explore is: **What factors have a main impact on determining the admissions status of Wharton's Class of 2025 applicants?**

## Project Overview
This project will utilize synthetic data generated from the statistics of the Wharton Class of 2025. Synthetic data was chosen to ensure privacy and flexibility, as real admissions data is confidential and not publicly accessible. Using synthetic data allows us to explore realistic trends and test hypothetical scenarios while maintaining ethical standards and avoiding exposure of personal information. The dataset includes various features such as applicant gender, GPA, GMAT scores, work experience, and major, as well as the admission status (Admit, Waitlist, Deny). Our goal is to perform an exploratory data analysis to understand the relationships and patterns among these variables, focusing on how they correlate with admission outcomes.

## Data Sources
The primary dataset consists of the following columns:
- **application_id**: Unique identifier for each application
- **gender**: Applicant's gender (Male, Female)
- **international**: International student status (TRUE/FALSE)
- **gpa**: Grade Point Average on a 4.0 scale
- **major**: Undergraduate major (Business, STEM, Humanities)
- **race**: Racial background (White, Black, Asian, Hispanic, Other)
- **gmat**: GMAT score out of 800
- **work_exp**: Years of work experience
- **work_industry**: Previous work industry (Consulting, Finance, Technology, etc.)
- **admission**: Admission status (Admit, Waitlist, Deny)

## Analysis Goals and Impact on Admissions

We will create visualizations to analyze the influence of gender, GPA, GMAT scores, work experience, and major on admission status. Our findings will provide insights into the admissions process and highlight any potential biases present in the data. By exploring the various factors that influence admission decisions, we aim to provide insights that can benefit both the admissions committee and prospective applicants in the following ways:

1. **Identifying Biases and Inequities**: Analyzing the relationships between demographic factors (such as gender, race, and international status) and admission outcomes can reveal potential biases in the admissions process. 

2. **Optimizing Admissions Criteria**: By evaluating the impact of academic performance indicators like GPA and GMAT scores alongside experiential factors like work experience and industry background, the admissions committee can refine their criteria.

3. **Enhancing Applicant Guidance**: The insights gained from this analysis can be valuable for prospective applicants. Understanding which factors significantly influence admissions can help applicants tailor their applications more effectively, focusing on areas that align with the admissions committee's expectations. 



## Analysis of visualization 

plot 1

The chart shows a very similar pattern of admission, nonadmission, and waitlist rates across the different majors (Business, Humanities, and STEM). The admission rate remains around 14-15% for each major, while the nonadmission rate is consistently above 83%. This consistency across majors suggests that an applicant’s major does not significantly influence their chances of admission, as each major displays almost identical admission rates.
If major had a stronger impact, we would expect to see distinct differences in admission rates across the majors, with some majors having significantly higher or lower admission rates than others. The lack of such variation implies that other features likely play a larger role in admission decisions.

plot 2

The graph above investigates how gender and race influence MBA admission decisions. Specifically, it answers the question: How do demographic factors like race and gender impact the likelihood of being admitted to an MBA program? The bars represent log-odds coefficients derived from a logistic regression model, with positive values indicating an increased likelihood of admission and negative values reflecting a reduced likelihood. Each demographic category is compared to a baseline or reference group (likely 'White' for race and 'Male' for gender.

Key findings include positive coefficients for Black and Hispanic applicants, suggesting they are more likely to gain admission compared to the baseline group. Meanwhile, Asian applicants have a slight disadvantage with a small negative coefficient. Gender differences are also pronounced, with female applicants having a large negative coefficient, implying they are less likely to be admitted than their male counterparts. Other racial categories, such as 'International' and 'Other,' have coefficients near zero, indicating little effect on admissions likelihood.

To analyze this data, the variables for race and gender were one-hot encoded, a preprocessing technique used in statistical modeling. One-hot encoding converts categorical variables (e.g., 'race' with categories like White, Black, or Asian) into separate binary columns. Each column takes a value of 1 if the individual belongs to that category and 0 otherwise. This method is essential because logistic regression requires numerical inputs, and one-hot encoding enables the model to analyze the impact of each category independently.

The log-odds coefficients in logistic regression explain how much the odds of admission change with each variable. Odds represent the probability of being admitted divided by the probability of not being admitted, and the log-odds are simply the logarithm of this ratio. Using log-odds ensures that predictions remain within valid probability ranges (0 to 1). Logistic regression is ideal for studying binary outcomes like admissions, as it provides interpretable results and highlights how demographic factors influence outcomes. The results here can guide diversity efforts in education and shed light on potential biases in admission decisions.

plot 3

The graph provides a clear trend that the majority of admitted applicants have a GPA over 3.2 and a GMAT score over 650, suggesting that both measures of academic performance (GPA and GMAT) play an important role in admissions decisions. The relatively even distribution of scores within a given range of GPA and GMAT scores suggests that applicants with higher academic qualifications have a better chance of being admitted. This finding highlights the importance of these factors in the admissions process and provides valuable insights into how applicants can align their profiles with the expectations of admissions committees.
The x-axis of the plot represents GPA, ranging from 2.9 to 4.0, with cutoffs every 0.1; the y-axis represents GMAT scores, ranging from 550 to 800. Since no student has a GPA below 2.8 and a GMAT below 550, the x-axis starts at 2.9 and the y-axis starts at 550. 


