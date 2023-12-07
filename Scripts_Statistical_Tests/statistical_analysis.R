install.packages("data.table", dependencies = TRUE, type = "binary")
install.packages("gmodels", dependencies = TRUE)
install.packages("car", dependencies = TRUE)
install.packages("DescTools", dependencies = TRUE)
install.packages("ggplot2", dependencies = TRUE)
install.packages("qqplotr", dependencies = TRUE)
install.packages("dplyr", dependencies = TRUE)
install.packages("effsize", dependencies = TRUE)
install.packages("tidyr", dependencies = TRUE)
install.packages("forcats", dependencies = TRUE)
install.packages("hrbrthemes", dependencies = TRUE)
install.packages("viridis", dependencies = TRUE)
install.packages("reshape2", dependencies = TRUE)
install.packages("beeswarm", dependencies=TRUE)

library(data.table)
library("gmodels")
library("car")
library("DescTools")
library("ggplot2")
library("qqplotr")
library("dplyr")
library(effsize)
library(reshape2)
library(beeswarm)

## Empirical Data Assessment

### Collect data from .csv sheets
pasta_files <- c("Pasta_experiments_ex1.csv",
                  "Pasta_experiments_ex2.csv",
                  "Pasta_experiments_ex3.csv",
                  "Pasta_experiments_ex4.csv",
                  "Pasta_experiments_ex5.csv",
                  "Pasta_experiments_ex6.csv",
                  "Pasta_experiments_ex7.csv",
                  "Pasta_experiments_ex8.csv",
                  "Pasta_experiments_ex9.csv",
                  "Pasta_experiments_ex10.csv")
max_entries <- 0
i <- 1
#### Each while loop will collect the full dataset and rewrite a dataframe, namely df, with three columns: experiment #, RFTC value, MTTF value.
while (i < 11){
    pasta_dat <- fread(pasta_files[i], dec=",", sep=";", encoding="UTF-8")

    ##### calculates RFTC for PASTA
    pasta_diff <- as.integer(pasta_dat$Difference)
    tbl <- table(pasta_diff)
    pasta <- cbind(tbl,round(prop.table(tbl)*100,2))
    colnames(pasta) <- c('Count','Percentage')
    j <- 1
    RFTC <- 0
    while(j < nrow(pasta)*2+1){
        if (j>=3 & j < nrow(pasta) + 1) {
            RFTC <- RFTC + as.integer(pasta[j])
        } 
        j <- j + 1
    }

    entries <- nrow(pasta_dat)
    if(entries>max_entries ){
        max_entries <- entries
    }

    ##### calculates MTTF for PASTA, note that a subset of the data is used, only when there is a failure (diff>2)
    faulty_patients <- pasta_dat %>% group_by(Patient) %>% filter(Difference>1)
    faulty_patients <- unique(faulty_patients$Patient)
    pasta_dat <- pasta_dat[pasta_dat$Patient %in% faulty_patients]
    init_df <- pasta_dat %>% group_by(Patient) %>% slice(which.min(Timestamp)) 
    ff_df <- pasta_dat %>% group_by(Patient) %>% filter(Difference>1) %>% slice(which.min(Timestamp))
    MTFFs_lst <- mapply('-', ff_df$Timestamp, init_df$Timestamp, SIMPLIFY = TRUE)
    MTFF <- mean(MTFFs_lst)
    
    if (i == 1){
        df <- data.frame(RFTC,MTFF,method="PASTA") # creates a dataframe
    } else {
        df <- df %>% add_row(RFTC=RFTC,MTFF=MTFF,method="PASTA")
    }

    i <- i + 1
}

##### collects pasta dataset size to slicing random for RFTC calculation
pasta_size <- length(pasta_diff)

random_files <- c("random_experiments_ex1.csv",
                  "random_experiments_ex2.csv",
                  "random_experiments_ex3.csv",
                  "random_experiments_ex4.csv",
                  "random_experiments_ex5.csv",
                  "random_experiments_ex6.csv",
                  "random_experiments_ex7.csv",
                  "random_experiments_ex8.csv",
                  "random_experiments_ex9.csv",
                  "random_experiments_ex10.csv") 
i <- 1
while (i < 11){
    random_dat <- fread(random_files[i], dec=",", sep=";", encoding="UTF-8")

    ##### calculates RFTC for random
    random_diff <- as.integer(random_dat$Difference)
    #tbl <- table(random_diff)
    tbl <- table(random_diff[1:pasta_size]) #crops to the size of pasta for RFTC calculation
    random <- cbind(tbl,round(prop.table(tbl)*100,2))
    colnames(random) <- c('Count','Percentage')
    j <- 1
    RFTC <- 0
    while(j < nrow(random)*2+1){
        if (j>=3 & j < nrow(random) + 1) {
            RFTC <- RFTC + as.integer(random[j])
        } 
        j <- j + 1
    }
    
    ##### calculates MTTF for random
    init_df <- random_dat %>% slice(which.min(Timestamp)) 
    ff_df <- random_dat %>% filter(Difference>1) %>% slice(which.min(Timestamp))
    MTFFs_lst <- mapply('-', ff_df$Timestamp, init_df$Timestamp, SIMPLIFY = TRUE)
    MTFF <- mean(MTFFs_lst)
    df <- df %>% add_row(RFTC=RFTC,MTFF=MTFF,method="random")

    i <- i + 1
}


## Statistical Analysis


### The statistical analysis starts by plotting boxplots from MTFF and RFTC for both PASTA and the baseline
ggplot(melt(df, id.var="method")) +
    geom_boxplot(aes(method, value, colour=method), show.legend=FALSE) +
    facet_grid(variable ~ .) +
    scale_y_continuous(limits = c(2000,9050)) #### We scale the y axis to maximum of 9050 limiting the visualization which hides outliers from MTTF random.
    theme_bw()

### Produces descriptive statistics for RFTC
df %>% select(method, RFTC) %>% group_by(method) %>% 
  summarise(n = n(), 
            mean = mean(RFTC, na.rm = TRUE), 
            sd = sd(RFTC, na.rm = TRUE),
            stderr = sd/sqrt(n),
            LCL = mean - qt(1 - (0.05 / 2), n - 1) * stderr, # lower control limit
            UCL = mean + qt(1 - (0.05 / 2), n - 1) * stderr, # upper control limit
            median = median(RFTC, na.rm = TRUE),
            min = min(RFTC, na.rm = TRUE), 
            max = max(RFTC, na.rm = TRUE),
            IQR = IQR(RFTC, na.rm = TRUE), #interquartile range
            LCLmed = MedianCI(RFTC, na.rm=TRUE)[2],
            UCLmed = MedianCI(RFTC, na.rm=TRUE)[3])

### Calculates and prints descriptive statistics

### Produces descriptive statistics for MTTF
df %>% select(method, MTFF) %>% group_by(method) %>% 
  summarise(n = n(), 
            mean = mean(MTFF, na.rm = TRUE), 
            sd = sd(MTFF, na.rm = TRUE),
            stderr = sd/sqrt(n),
            LCL = mean - qt(1 - (0.05 / 2), n - 1) * stderr, # lower control limit
            UCL = mean + qt(1 - (0.05 / 2), n - 1) * stderr, # upper control limit
            median = median(MTFF, na.rm = TRUE),
            min = min(MTFF, na.rm = TRUE), 
            max = max(MTFF, na.rm = TRUE),
            IQR = IQR(MTFF, na.rm = TRUE), #interquartile range
            LCLmed = MedianCI(MTFF, na.rm=TRUE)[2],
            UCLmed = MedianCI(MTFF, na.rm=TRUE)[3])

###Test each RTFC group for normality (shapiro-wilk's test)
df %>%
  group_by(method) %>%
  summarise(`W Stat` = shapiro.test(RFTC)$statistic,
            p.value = shapiro.test(RFTC)$p.value)

###Test each MTFF group for normality (shapiro-wilk's test)
df %>%
  group_by(method) %>%
  summarise(`W Stat` = shapiro.test(MTFF)$statistic,
            p.value = shapiro.test(MTFF)$p.value)

### Calculates significance analysis to RFTC and MTTF

### Performs  the T-Student test
t.test(RFTC ~ method, data=df, na.rm=TRUE, paired=FALSE, exact=FALSE, conf.int=TRUE)

###Perform the Mann-Whitney U-test
wilcox.test(MTFF ~ method, data=df, na.rm=TRUE, paired=FALSE, exact=FALSE, conf.int=TRUE, alternative="less")

