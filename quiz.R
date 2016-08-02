source('assignment1.R')

# Question
print('Question 1')
pollutantmean("specdata", "sulfate", 1:10) %>% round(3) %>% print()

# Question
print('Question 2')
pollutantmean("specdata", "nitrate", 70:72) %>% round(3) %>% print()

# Question
print('Question 3')
pollutantmean("specdata", "sulfate", 34) %>% round(3) %>% print()

# Question
print('Question 4')
pollutantmean("specdata", "nitrate") %>% round(3) %>% print()

# Question
print('Question 5')
cc <- complete("specdata", c(6, 10, 20, 34, 100, 200, 310))
print(cc$nobs)

# Question
print('Question 6')
cc <- complete("specdata", 54)
print(cc$nobs)

# Question
print('Question 7')
set.seed(42)
cc <- complete("specdata", 332:1)
use <- sample(332, 10)
print(cc[use, "nobs"])

# Question
print('Question 8')
cr <- corr("specdata")
cr <- sort(cr)
set.seed(868)
out <- round(cr[sample(length(cr), 5)], 4)
print(out)

# Question
print('Question 9')
cr <- corr("specdata", 129)
cr <- sort(cr)
n <- length(cr)
set.seed(197)
out <- c(n, round(cr[sample(n, 5)], 4))
print(out)

# Question
print('Question 10')
cr <- corr("specdata", 2000)
n <- length(cr)
cr <- corr("specdata", 1000)
cr <- sort(cr)
print(c(n, round(cr, 4)))

