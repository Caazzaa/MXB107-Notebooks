invisible(source("R/preConfigurated.R"))

# # ====================== DATA WRANGLING ===================
# MXB107_Info = read.csv("./datasets/MXB107_2025_ClassInfo.csv")
# str(MXB107_Info)

# # ======== My solution ==========
# MXB107_Info %>%
#   filter(str_detect(Type, "Practical")) %>%
#   group_by(Type) %>%
#   summarise(Count = n(),
#             .groups = "drop")

# MXB107_Info %>%
#   filter(str_detect(Type, "Lecture")) %>%
#   group_by(Type) %>%
#   summarise(Count = n(),
#             .groups = "drop")

# # ========= Proper solution ==========
# MXB107_Info %>%
#   mutate(Mode = ifelse(Location == "Online", "Online", "In-Person")) %>%
#   group_by(Type, Mode) %>%
#   summarize(Count = n(), .groups = "drop") %>%
#   arrange(Type, Mode)

         
# # =============== DATA VISUALISATION ================
# iris = read.csv("./datasets/iris.csv")
# iris %>% head()

# # Save the plot to a file so you can view it outside the terminal
# iris_plot <- ggplot(data = iris, aes(x = Sepal.Width, y = Petal.Length, color = Species)) +
#   geom_point(size = 4) +
#   facet_wrap(~ Species) +
#   labs(
#     title = "Petal Length vs Sepal Width",
#     x = "Sepal Width (cm)",
#     y = "Petal Length (cm)",
#     color = "Species Type"
#   ) +
#   theme_minimal() +
#   theme(
#     plot.title = element_text(face = "bold", size = 14, hjust = 0.5),
#     legend.position = "top"
#   )

# ggsave("plots/iris_plot.png", plot = iris_plot, width = 8, height = 6)

# iris %>%
#   select(Sepal.Length, Sepal.Width, Petal.Length, Species) %>%
#   pivot_longer(
#     cols = c(Sepal.Length, Petal.Length),
#     names_to = "Measurement",
#     values_to = "Length"
#   ) -> long_iris

# long_iris %>%
#   head()

# plot_measurement <- long_iris %>%
#   ggplot(aes(x = Sepal.Width, y = Length, color = Species)) +
#   geom_point(size = 4) +
#   facet_wrap(~ Measurement) +
#   labs(
#     title = "Sepal and Petal Length vs Sepal Width by Measurement",
#     x = "Sepal Width",
#     y = "Length (cm)"
#   ) +
#   theme_minimal()+
#   theme(
#     plot.title = element_text(face = "bold", size = 14, hjust = 0.5),
#     legend.position = "top"
#   )

# ggsave("plots/measurement_plot.png", plot = plot_measurement, width = 8, height = 6)

# ============== WORKSHOP QUESTIONS =================
epa_data = read.csv("./datasets/epa_data.csv")
str(epa_data)

ggplot(data = epa_data, aes(x = city, fill = trans)) +
  geom_histogram(aes(y = after_stat(density))) +
  facet_wrap(~ trans) +
  labs(
    title = "Manual vs Auto Fuel Economy in Cities",
    x = "City MPG",
    y = "Count"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 14, hjust = 0.5),
    legend.position = "top"
  )