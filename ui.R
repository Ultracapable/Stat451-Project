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
    tabPanel("Plot 1: Admission Rates by Category",
             sidebarPanel(
               selectInput(
                 inputId = "plot1_category",
                 label = "Select a category to view:",
                 choices = c("Major" = "major",
                             "Race" = "race",
                             "Gender" = "gender"),
                 selected = "major"
               )
             ),
             mainPanel(
               plotOutput("plot1")
             ),
             p(" The charts reveal consistent patterns in admission, non-admission, and waitlist rates across different categories, including major, race, and gender. For majors (Business, Humanities, and STEM), the admission rate remains stable at around 14-15%, while the non-admission rate is consistently above 83%. This uniformity indicates that an applicant's major does not significantly influence their chances of admission. If major were a stronger determinant, distinct variations in admission rates across different fields would be expected."),
             p(" Similarly, the chart analyzing race shows consistently high non-admission rates across all racial groups, ranging from 78.9% to 90.2%. Admission rates are highest for Asian applicants (16.6%) and lowest for Hispanic applicants (10.4%), but the overall variation in admission rates between racial groups is limited. These trends suggest that while there may be slight differences in outcomes by race, other factors likely have a more substantial impact on admission decisions."),
             p(" Lastly, the chart by gender shows that female applicants have a higher admission rate (20%) compared to male applicants (11.4%), though non-admission dominates for both genders, with rates of 77.8% for females and 87.3% for males. The waitlist percentages remain minimal across all categories analyzed. The consistency of these patterns across major, race, and gender suggests that none of these individual characteristics significantly influence admission decisions on their own, and other variables likely play a more critical role.")
    ),
    tabPanel("Plot 2: Gender and Race Impact",
         plotOutput("plot2"),
       p("The graph explores how gender and race impact MBA admission decisions, using log-odds coefficients derived from a logistic regression model. Positive values indicate an increased likelihood of admission, while negative values reflect a reduced likelihood, with comparisons made to the reference groups “raceAsian” and “genderMale.”"),
      p("The results show that being female significantly increases the odds of admission, while Black and Hispanic applicants face lower odds, with Black applicants experiencing the most disadvantage. White applicants and other racial categories have slightly higher odds of admission, while international categories show minimal impact compared with Asian students."),
      p("One-hot encoding, a preprocessing technique used in statistical modeling, was applied to convert categorical variables (e.g., race or gender) into separate binary columns. Each column takes a value of 1 if the individual belongs to that category and 0 otherwise, enabling the model to analyze the impact of each category independently. Log-odds coefficients represent how much the odds of admission change for a variable, where odds are the ratio of the probability of being admitted to the probability of not being admitted. These insights highlight potential disparities in admission decisions and can inform efforts to promote fairness and diversity in MBA programs.")
    ),
    tabPanel("Plot 3: GPA and GMAT Trends",
             sidebarLayout(
               sidebarPanel(
                 numericInput("gpa", "Enter Your GPA:", value = 3.5, min = 0, max = 4.0, step = 0.1),
                 numericInput("gmat", "Enter Your GMAT Score:", value = 700, min = 0, max = 800, step = 10),
                 actionButton("submit", "Submit"),
                 p("Enter your GPA and GMAT scores to see your data point added to the plot.")
               ),
               mainPanel(
                 plotOutput("plot3"),
                 p("This graph provides an overall grades for all applicants for Wharton admission. And also this graph provides a clear trend that the majority of admitted applicants have a GPA over 3.2 and a GMAT score over 650, suggesting that both measures of academic performance (GPA and GMAT) play an important role in admissions decisions. The relatively even distribution of scores within a given range of GPA and GMAT scores suggests that applicants with higher academic qualifications have a better chance of being admitted. This finding highlights the importance of these factors in the admissions process and provides valuable insights into how applicants can align their profiles with the expectations of admissions committees. The x-axis of the plot represents GPA, ranging from 2.9 to 4.0, with cutoffs every 0.1; the y-axis represents GMAT scores, ranging from 550 to 800. Since no student has a GPA below 2.8 and a GMAT below 550, the x-axis starts at 2.9 and the y-axis starts at 550.")
               )
             )
    ),
    tabPanel("Download Report",
             downloadButton("download_report", "Download Analysis Report"))
  )
)

