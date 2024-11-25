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
        plot.title = element_text(size = 20),
        axis.title.x = element_text(size = 16),
        axis.title.y = element_text(size = 16),
        axis.text.x = element_text(size = 14),
        axis.text.y = element_text(size = 14),
        legend.title = element_text(size = 16),
        legend.text = element_text(size = 16)
      )
  })
  
  output$plot2 <- renderPlot({
    
    mba_data$race[mba_data$race == "" | is.na(mba_data$race)] <- "International"
    mba_data$admission[mba_data$admission == "" | is.na(mba_data$admission)] <- "Nonadmission"
    mba_data$admission <- factor(mba_data$admission, levels = c("Admit", "Waitlist", "Nonadmission"))

    gender_onehot <- model.matrix(~ gender - 1, data = mba_data)
    race_onehot <- model.matrix(~ race - 1, data = mba_data)
    mba_data_onehot <- cbind(mba_data, gender_onehot, race_onehot)
    onehot_columns <- c(colnames(gender_onehot), colnames(race_onehot))  
    formula_onehot <- as.formula(paste("admission ~", paste(onehot_columns, collapse = " + ")))
    model_gender_race <- glm(formula_onehot, data = mba_data_onehot, family = binomial)


    coef_df <- data.frame(
      variable = names(coef(model_gender_race)),  
      coefficient = coef(model_gender_race)      
    )
    coef_df <- coef_df[coef_df$variable != "(Intercept)", ]

    ggplot(coef_df, aes(x = variable, y = coefficient)) +
    geom_bar(stat = "identity", fill = "steelblue") +
    theme_minimal() +
    coord_flip() +  # Flip the axes to make it easier to read
    labs(
      title = "Influence of Gender and Race on MBA Admission (Log-Odds Coefficients)",
      subtitle = "One-Hot Encoded Variables",
      x = "Variable",
      y = "Coefficient (Log-Odds)"
    ) +
    theme_minimal() +
    theme(
      plot.title = element_text(size = 20),
      axis.title.x = element_text(size = 16),
      axis.title.y = element_text(size = 16),
      axis.text.x = element_text(size = 14),
      axis.text.y = element_text(size = 14),
      legend.title = element_text(size = 16),
      legend.text = element_text(size = 16)
    )    

  })
  
  # Plot 3: GPA and GMAT Trends
  user_point <- reactiveVal(data.frame(gpa = numeric(0), gmat = numeric(0)))
  
  observeEvent(input$submit, {
    user_point(data.frame(gpa = input$gpa, gmat = input$gmat))
  })
  
  output$plot3 <- renderPlot({
    mba_data$race[mba_data$race == "" | is.na(mba_data$race)] <- "International"
    mba_data$admission[mba_data$admission == "" | is.na(mba_data$admission)] <- " Non-Admitted"
    mba_data$admission[mba_data$admission == "Admit"] <- "Admitted"
    
    user_data <- user_point()
    print(user_data)
    
    plot <- ggplot(mba_data, aes(x = gpa, y = gmat, color = admission)) +
      geom_point(alpha = 0.6, size = 1.5) +
      labs(
        title = "Relationship Between GPA, GMAT Scores, and Admission Status",
        x = "GPA",
        y = "GMAT Score",
        color = "Admission Status"
      ) +
      scale_x_continuous(
        limits = c(2.6, 4),
        breaks = seq(2.6, 4, by = 0.1)
      ) +
      ylim(550, 800) +
      theme_minimal() +
      theme(
        plot.title = element_text(size = 20),
        axis.title.x = element_text(size = 16),
        axis.title.y = element_text(size = 16),
        axis.text.x = element_text(size = 14),
        axis.text.y = element_text(size = 14),
        legend.title = element_text(size = 16),
        legend.text = element_text(size = 16)
      )
      if (nrow(user_data) > 0) {
        plot <- plot +
          geom_point(data = user_data, aes(x = gpa, y = gmat), 
                    color = "blue", size = 5, shape = 18) +  # Blue star for user input
          annotate("text", x = user_data$gpa, y = user_data$gmat + 10, 
                  label = "You", color = "blue", size = 5)
      }
    plot
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
