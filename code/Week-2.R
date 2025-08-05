invisible(source("R/preConfigurated.R"))

X = read.csv("./datasets/centraltendency")

median(X$G0)
median(X$G0_oult25)
median(X$G0_oult50)
median(X$G0_oult100)

# =========== Exercise 1 =============
modeRawG0 = Mode(X$G0)
print(modeRawG0)

length(modeRawG0)

binnedG0 = FDbinning(X$G0)
binnedG0_oult25 = FDbinning(X$G0_oult25)

print(binnedG0)
length(binnedG0)
Mode(binnedG0)

print(binnedG0_oult25)
length(binnedG0_oult25)
Mode(binnedG0_oult25)

# ============== Exercise 2 ==============
boxplot(X, main = "Boxplots of several Gaussian datasets with/without outliers")

cMeans = colMeans(X)
cMedians = apply(X, 2, median)
cModes = apply(X, 2, ModeBinMidpoint)

points(1:4, cMeans, pch = 19, col = "red", cex = 1.25)
points(1:4, cMedians, pch = 15, col = "blue", cex = 1.25)
points(1:4, cModes, pch = 15, col = "green", cex = 1.25)
# Add legend
legend("topleft", legend = c("Mean", "Median", "Mode"),
       cex = rep(1.25, 3), col = c("red", "blue", "green"), bty = "n",
       pch = c(19,15, 17))

# ============== Example ==================
# outlVals = c(0,25,50,100)
# meanVals = apply(X,2,mean)
# varVals = apply(X,2,var)
# sdVals = apply(X, 2, sd)


# plot(outlVals, varVals, type = "l", lty = 4, col = "black", xaxt = "n")
# points(outlVals, varVals,pch = 3, col = "black")
# axis(side = 1, at = c(0, 25, 50, 100))

# lines(outlVals, sdVals, type = "l", lty = 3, col = "blue", xaxt = "n")
# points(outlVals, sdVals,pch = 4, col = "blue")

# lines(outlVals, meanVals, type = "l", lty = 2, col = "red")
# points(outlVals, meanVals,pch = 5, col = "red")

# legend("topleft", legend = c("VAR", "sd", "Mean"), pch = c(3,4,5), col = c("black", "blue", "red"), lty = c(4,3,2))

# ============= Example 3 =============
set.seed(59)
data = rnorm(2000)
chebyshevRule(data, xlim = c(min(data), max(data)), ks = 1:3)

set.seed(59)
data = rnorm(2000)
empiricalRuleGaussian(data, xlim = c(min(data), max(data)), ks = 1:3)

# ============ Example 4 =============
class(mean)
class(function(arg) quantile(arg, probs))

q75 = apply(X,2,function(arg) quantile(arg, probs = 0.75))
q25 = apply(X,2,function(arg) quantile(arg, probs = 0.25))
print(q75)
print(q25)

iqr = q75 - q25
print(iqr)

# ============= Workshop Questions ============
# = 1 =
sp500_dailyReturn = 100*read.csv("datasets/s&p500.csv")$daily.returns
print(sp500_dailyReturn)

empiricalRuleGaussian(sp500_dailyReturn, xlim = c(min(sp500_dailyReturn), max(sp500_dailyReturn)), ks = 1:6)

# = 2 =
epa_data = read.csv("./datasets/epa_data.csv")
str(epa_data)

epa_data %>%
summarise(
        mean_city = mean(epa_data$city),
        median_city = median(epa_data$city),
        mode_disp = Mode(epa_data$disp),
        mean_disp = mean(epa_data$disp, na.rm = TRUE),
        median_disp = median(epa_data$disp, na.rm = TRUE)
        )

# = 3 =
sd_city = sd(epa_data$city)
sd_highway = sd(epa_data$hwy)
print(sd_city)
print(sd_highway)

empiricalRuleGaussian(epa_data$city, ks = 1:3)
chebyshevRule(epa_data$city, ks = 1:3)
empiricalRuleGaussian(epa_data$hwy, ks = 1:3)
chebyshevRule(epa_data$hwy, ks = 1:3)

# = 4 =
qr25_city = quantile(epa_data$city, 0.25)
qr50_city = quantile(epa_data$city, 0.50)
qr75_city = quantile(epa_data$city, 0.75)
iqr_city = qr75_city - qr25_city

qr25_hwy = quantile(epa_data$hwy, 0.25)
qr50_hwy = quantile(epa_data$hwy, 0.50)
qr75_hwy = quantile(epa_data$hwy, 0.75)
iqr_hwy = qr75_hwy - qr25_hwy

epa_data %>%
  pivot_longer(cols = c(city, hwy),
               names_to = "type",
               values_to = "value") %>% #long-format df
  ggplot(aes(x = type, y = value, colour = type)) +
  geom_boxplot() +
  labs(title = "EPA: City driving vs. highway driving",
       x = "Type", y = "Miles per gallon") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold", size = 14, hjust = 0.5),
        legend.position = "top")