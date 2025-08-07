invisible(source("R/preConfigurated.R"))

# titanic = read.csv("./datasets/titanic.csv", stringsAsFactors = T)

# table(titanic$Class, titanic$Survived)

# prop.table(table(titanic$Class, titanic$Survived), margin = 1)*100

# titanic %>%
#   group_by(Class, Survived) %>%
#   summarise(Count = n(), .groups = "drop") %>%
#   ggplot(aes(x = Class, y = Count, fill = Survived)) +
#   geom_bar(stat = "identity", position = "dodge") +
#   labs(y = "Count", title = "Survival by Class")

# titanic %>%
#   group_by(Class, Survived) %>%
#   summarise(Count = n(), .groups = "drop") %>%
#   group_by(Class) %>%
#   mutate(Freq = 100*Count / sum(Count)) %>% #Here sum(Count) is computed within Class
#   ungroup() %>%
#   select(Class, Survived, Freq) %>%
#   ggplot(aes(x = Class, y = Freq, fill = Survived)) +
#   geom_bar(stat = "identity", position = "dodge") +
#   labs(y = "Frequency", title = "Survival Frequency by Class")

# titanic %>%
#   select(Class, Survived) %>%
#   table() %>%
#   mosaicplot(main = "Survival by Class",
#              xlab = "Passenger Class",
#              ylab = "Proportion Survived",
#              color = TRUE,
#              shade = TRUE,
#              las = 1)

# titanic %>%
#   select(Class, Survived) %>%
#   table() %>%
#   prop.table(margin = 1) %>%
#   multiply_by(100) %>%
#   mosaicplot(main = "Survival by Class",
#              xlab = "Passenger Class",
#              ylab = "Proportion Survived",
#              color = TRUE,
#              shade = TRUE,
#              las = 1)

iris %>%
  select(Sepal.Length, Species) %>%
  head(5)

# =============== Exercise 1 ===============
iris %>%
    group_by(Species) %>%
    summarise(
        mean_length = mean(Sepal.Length),
        sd_length = sd(Sepal.Length)
    ) %>%
    ungroup() %>%
    mutate(lowerInterval = mean_length - 2*sd_length,
            upperInterval = mean_length + 2*sd_length)

# ================= Exercie 2 ================
iris %>%
    ggplot(aes(x = Species, y = Sepal.Length, fill = Species)) +
    geom_boxplot() + 
    labs(title = "Distribution of Sepal Length by Species",
        x = "Species",
        y = "Sepal Length") +
    theme_minimal()

# ============== Exercise 3 =================
epa_data = read.csv("./datasets/epa_data.csv")
epa_data %>% head()

epa_data %>%
    ggplot(aes(x = city, fill = trans)) +
    geom_histogram(aes(y = after_stat(density)),
        bins = 30,
        alpha = 0.7,
        color = "black", #border color
        position = "identity") +             
    labs(title = "Stacked Normalised City MPG Distribution by Transmission Type",
        x = "City MPG",
        y = "Density",
        fill = "Transmission") +
    theme_minimal()