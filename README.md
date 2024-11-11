# Stat451-Project

## Research Question
The primary question we aim to explore is: **What factors have a main impact on determining the admissions status of Wharton's Class of 2025 applicants?**

## Project Overview
This project will utilize synthetic data generated from the statistics of the Wharton Class of 2025. The dataset includes various features such as applicant gender, GPA, GMAT scores, work experience, and major, as well as the admission status (Admit, Waitlist, Deny). Our goal is to perform an exploratory data analysis to understand the relationships and patterns among these variables, focusing on how they correlate with admission outcomes.

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

The chart illustrates the impact of gender and race on admission chances. The reference groups for comparison were selected based on the largest applicant group within each category: male for gender and international students for race.
In terms of gender, females exhibit a higher admission rate compared to males. Among racial groups, white and Asian applicants show a relative advantage in admission rates over international students, with applicants classified in the "other" category having the highest advantage. Conversely, Hispanic and Black applicants have comparatively lower admission rates, with Black applicants experiencing the lowest rates overall. 

plot 3

The graph provides a clear trend that the majority of admitted applicants have a GPA over 3.2 and a GMAT score over 650, suggesting that both measures of academic performance (GPA and GMAT) play an important role in admissions decisions. The relatively even distribution of scores within a given range of GPA and GMAT scores suggests that applicants with higher academic qualifications have a better chance of being admitted. This finding highlights the importance of these factors in the admissions process and provides valuable insights into how applicants can align their profiles with the expectations of admissions committees.
The x-axis of the plot represents GPA, ranging from 2.9 to 4.0, with cutoffs every 0.1; the y-axis represents GMAT scores, ranging from 550 to 800. Since no student has a GPA below 2.8 and a GMAT below 550, the x-axis starts at 2.9 and the y-axis starts at 550. 


