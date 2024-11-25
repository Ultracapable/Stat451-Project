library(shiny)
library(ggplot2)
library(dplyr)

server <- function(input, output) {
  mba_data <- read.csv("MBA.csv")
  
  output$plot1 <- renderPlot({
    mba_data$race[mba_data$race == "" | is.na(mba_data$race)] <- "International"
    mba_data$admission[mba_data$admission == "Admit"] <- "Admitted"
    mba_data$admission[mba_data$admission == "" | is.na(mba_data$admission)] <- "Non-Admitted"
    
    selected_category <- input$plot1_category
    
    category_admit <- mba_data %>% 
      group_by(.data[[selected_category]], admission) %>% 
      summarise(count = n()) %>% 
      group_by(.data[[selected_category]]) %>% 
      mutate(percentage = count / sum(count) * 100)
    
    ggplot(category_admit, aes_string(x = selected_category, y = "percentage", fill = "admission")) +
      geom_bar(stat = "identity", position = "dodge") +
      geom_text(aes(label = paste0(round(percentage, 1), "%")), position = position_dodge(width = 0.9), vjust = -0.5) +
      scale_fill_manual(values = c("Admitted" = "green", "Non-Admitted" = "red", "Waitlist" = "blue")) +
      labs(title = paste("Admission Status by", selected_category, "(Percentage)"), x = selected_category, y = "Percentage of Applicants", fill = "Admission Status") +
      theme_minimal() +
      theme(
        plot.title = element_text(size = 20),          # Increase title font size
        axis.title.x = element_text(size = 16),        # Increase x-axis label font size
        axis.title.y = element_text(size = 16),        # Increase y-axis label font size
        axis.text.x = element_text(size = 14),         # Increase x-axis tick label font size
        axis.text.y = element_text(size = 14),         # Increase y-axis tick label font size
        legend.title = element_text(size = 16),        # Increase legend title font size
        legend.text = element_text(size = 16)          # Increase legend text font size
      )
  })
  
  output$plot2 <- renderPlot({
    mba_data$race[mba_data$race == "" | is.na(mba_data$race)] <- "International"
    mba_data$admission[mba_data$admission == "" | is.na(mba_data$admission)] <- "Nonadmission"
    
    mba_data$admission <- recode(mba_data$admission, "Admit" = 1,"Waitlist"= 0, "Nonadmission" = 0, )
    
    mba_data$gender <- factor(mba_data$gender)
    mba_data$race <- factor(mba_data$race)
    gender_counts <- table(mba_data$gender)
    race_counts <- table(mba_data$race)
    
    mba_data$gender <- relevel(mba_data$gender, ref = names(gender_counts)[which.max(gender_counts)])
    mba_data$race <- relevel(mba_data$race, ref = names(race_counts)[which.max(race_counts)])
    model_gender_race <- glm(admission ~ gender + race, data = mba_data, family = binomial)
    summary(model_gender_race)
    
    coef_df <- data.frame(
      variable = names(coef(model_gender_race)),  # Coefficient names
      coefficient = coef(model_gender_race)  # Coefficient values
    )
    
    coef_df <- coef_df[coef_df$variable != "(Intercept)", ]
    ggplot(coef_df, aes(x = variable, y = coefficient)) +
      geom_bar(stat = "identity", fill = "steelblue") + 
      theme_minimal() +
      coord_flip() +  # Flip the axes to make it easier to read
      labs(
        title = "Influence of Gender and Race on MBA Admission (Log-Odds Coefficients)",
        subtitle = paste('Reference group: Gender:', levels(mba_data$gender)[1], ', Race:', levels(mba_data$race)[1]),
        x = "Variable",
        y = "Coefficient (Log-Odds)"
      ) +
     theme_minimal() +
      theme(
        plot.title = element_text(size = 20),          # Increase title font size
        axis.title.x = element_text(size = 16),        # Increase x-axis label font size
        axis.title.y = element_text(size = 16),        # Increase y-axis label font size
        axis.text.x = element_text(size = 14),         # Increase x-axis tick label font size
        axis.text.y = element_text(size = 14),         # Increase y-axis tick label font size
        legend.title = element_text(size = 16),        # Increase legend title font size
        legend.text = element_text(size = 16)          # Increase legend text font size
      )
  })
  
  # Plot 3: GPA and GMAT Trends
  output$plot3 <- renderPlot({
    filtered_data <- subset(mba_data, admission %in% c("Admit"))
    ggplot(filtered_data, aes(x = gpa, y = gmat, color = admission)) +
      geom_point(alpha = 0.6, size = 1.5) +
      labs(
        title = "Relationship Between GPA, GMAT Scores, and Admission Status (Admit Only)",
        x = "GPA",
        y = "GMAT Score",
        color = "Admission Status"
      ) +
      xlim(2.5, 4.0) +  # Set x-axis limits from 2.5 to 4.0
      ylim(550, 800) +
      scale_x_continuous(breaks = seq(2.5, 4.0, by = 0.1)) +  # Set x-axis breaks from 2.5 to 4.0, stepping by 0.1
      theme_minimal() +
      theme(
        plot.title = element_text(size = 20),          # Increase title font size
        axis.title.x = element_text(size = 16),        # Increase x-axis label font size
        axis.title.y = element_text(size = 16),        # Increase y-axis label font size
        axis.text.x = element_text(size = 14),         # Increase x-axis tick label font size
        axis.text.y = element_text(size = 14),         # Increase y-axis tick label font size
        legend.title = element_text(size = 16),        # Increase legend title font size
        legend.text = element_text(size = 16)          # Increase legend text font size
      )
  })
  
  # Download Report
  output$download_report <- downloadHandler(
    filename = function() { paste("admissions_analysis", Sys.Date(), ".pdf", sep = "") },
    content = function(file) {
      library(rmarkdown)
      rmarkdown::render("report_template.Rmd", output_file = file) # Create a report template
    }
  )
}
