library(shiny)

ui <- fluidPage(
  titlePanel("Wharton Admissions Analysis"),
  
  tabsetPanel(
    tabPanel("Overview", 
             p("This Shiny app analyzes synthetic data of Wharton's Class of 2025 applicants."),
             p("It includes visualizations exploring the factors influencing admission status."),
             h3("Research Question"),
             p("The primary question we aim to explore is: What factors have a main impact on determining the admissions status of Wharton's Class of 2025 applicants?"),
             h3("Project Overview"),
             p("This project will utilize synthetic data generated from the statistics of the Wharton Class of 2025. Synthetic data was chosen to ensure privacy and flexibility, as real admissions data is confidential and not publicly accessible. Using synthetic data allows us to explore realistic trends and test hypothetical scenarios while maintaining ethical standards and avoiding exposure of personal information. The dataset includes various features such as applicant gender, GPA, GMAT scores, work experience, and major, as well as the admission status (Admit, Waitlist, Deny). Our goal is to perform an exploratory data analysis to understand the relationships and patterns among these variables, focusing on how they correlate with admission outcomes."),
             h3("Data Sources"),
             p("The primary dataset consists of the following columns:"),
             tags$ul(
               tags$li("application_id: Unique identifier for each application"),
               tags$li("gender: Applicant's gender (Male, Female)"),
               tags$li("international: International student status (TRUE/FALSE)"),
               tags$li("gpa: Grade Point Average on a 4.0 scale"),
               tags$li("major: Undergraduate major (Business, STEM, Humanities)"),
               tags$li("race: Racial background (White, Black, Asian, Hispanic, Other)"),
               tags$li("gmat: GMAT score out of 800"),
               tags$li("work_exp: Years of work experience"),
               tags$li("work_industry: Previous work industry (Consulting, Finance, Technology, etc.)"),
               tags$li("admission: Admission status (Admit, Waitlist, Deny)")
             ),
             h3("Analysis Goals and Impact on Admissions"),
             p("We will create visualizations to analyze the influence of gender, GPA, GMAT scores, work experience, and major on admission status. Our findings will provide insights into the admissions process and highlight any potential biases present in the data. By exploring the various factors that influence admission decisions, we aim to provide insights that can benefit both the admissions committee and prospective applicants in the following ways:"),
             tags$ul(
               tags$li("Identifying Biases and Inequities: Analyzing the relationships between demographic factors (such as gender, race, and international status) and admission outcomes can reveal potential biases in the admissions process."),
               tags$li("Optimizing Admissions Criteria: By evaluating the impact of academic performance indicators like GPA and GMAT scores alongside experiential factors like work experience and industry background, the admissions committee can refine their criteria."),
               tags$li("Enhancing Applicant Guidance: The insights gained from this analysis can be valuable for prospective applicants. Understanding which factors significantly influence admissions can help applicants tailor their applications more effectively, focusing on areas that align with the admissions committee's expectations.")
             )
    ),
    tabPanel("Plot 1: Admission Rates by Major",
             plotOutput("plot1"),
             p("The chart shows a very similar pattern of admission, nonadmission, and waitlist rates across the different majors (Business, Humanities, and STEM). The admission rate remains around 14-15% for each major, while the nonadmission rate is consistently above 83%. This consistency across majors suggests that an applicant’s major does not significantly influence their chances of admission, as each major displays almost identical admission rates. If major had a stronger impact, we would expect to see distinct differences in admission rates across the majors, with some majors having significantly higher or lower admission rates than others. The lack of such variation implies that other features likely play a larger role in admission decisions.")
    ),
    tabPanel("Plot 2: Gender and Race Impact",
             plotOutput("plot2"),
             p("In this plot, the question we aim to answer is: How do gender and race impact the chances of admission for MBA applicants? The plot helps us visualize these relationships by comparing the admission rates of various demographic groups to those of the selected reference groups (male for gender and international for race). The reference groups for comparison were selected based on the largest applicant group within each category: male for gender and international students for race."),
             p(" From the plot, we conclude that gender and race are associated with different admission probabilities. Female applicants have a higher likelihood of admission compared to males, suggesting a potential gender-based differential in admissions. Similarly, among racial groups, white and Asian applicants have an advantage over international students, while applicants in the other racial category have the greatest advantage. In contrast, Hispanic and Black applicants have lower admission rates, with Black applicants having the lowest likelihood of admission among all groups. These patterns highlight notable disparities that may reflect underlying biases or systematic factors influencing admissions based on demographic characteristics.")
    ),
    tabPanel("Plot 3: GPA and GMAT Trends",
             plotOutput("plot3"),
             p("The graph provides a clear trend that the majority of admitted applicants have a GPA over 3.2 and a GMAT score over 650, suggesting that both measures of academic performance (GPA and GMAT) play an important role in admissions decisions. The relatively even distribution of scores within a given range of GPA and GMAT scores suggests that applicants with higher academic qualifications have a better chance of being admitted. This finding highlights the importance of these factors in the admissions process and provides valuable insights into how applicants can align their profiles with the expectations of admissions committees. The x-axis of the plot represents GPA, ranging from 2.9 to 4.0, with cutoffs every 0.1; the y-axis represents GMAT scores, ranging from 550 to 800. Since no student has a GPA below 2.8 and a GMAT below 550, the x-axis starts at 2.9 and the y-axis starts at 550.")
    ),
    tabPanel("Download Report",
             downloadButton("download_report", "Download Analysis Report"))
  )
)

