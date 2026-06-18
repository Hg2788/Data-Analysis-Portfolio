# Sleep Health Analysis

# 패키지 불러오기
library(tidyverse)
library(corrplot)
library(gridExtra)

# 데이터 불러오기
sleep <- read_csv("C:/data/Sleep_health.csv")

# EDA
head(sleep)
str(sleep)
summary(sleep)
colSums(is.na(sleep))
names(sleep)

table(sleep$Gender)
prop.table(table(sleep$Gender))
table(sleep$Occupation)
prop.table(table(sleep$Occupation))
table(sleep$`BMI Category`)
prop.table(table(sleep$`BMI Category`))
table(sleep$`Blood Pressure`)
prop.table(table(sleep$`Blood Pressure`))
table(sleep$`Sleep Disorder`)
prop.table(table(sleep$`Sleep Disorder`))

#====================수치형 시작====================
# Age(나이), Sleep Duration(수면시간), Quality of Sleep(수면의 질), Physical Activity Level(활동성), Stress Level(스트레스), Heart Rate(심박수), Daily Steps(걸음 수)
# 상관관계 분석 (수치형)
num_sleep <- sleep %>%
  select(
    Age, 
    `Sleep Duration`,
    `Quality of Sleep`,
    `Physical Activity Level`,
    `Stress Level`,
    `Heart Rate`,
    `Daily Steps`)

cor_matrix <- cor(num_sleep)

corrplot(cor_matrix, 
         method = 'color',
         addCoef.col = 'black',
         number.cex = 1.2,
         tl.srt = 30,
         diag = FALSE)

# 주요 변수 P-value 확인
cor.test(sleep$`Quality of Sleep`,sleep$`Sleep Duration`)
cor.test(sleep$`Quality of Sleep`,sleep$`Stress Level`)
cor.test(sleep$`Quality of Sleep`,sleep$`Heart Rate`)
cor.test(sleep$`Sleep Duration`,sleep$`Stress Level`)

# 주요 관계 시각화
# 1. Stress Level vs Sleep Quality
g1 <- ggplot(
  sleep,
  aes(
    x = `Stress Level`,
    y = `Quality of Sleep`
  )
) +
  geom_count(
    color = "steelblue",
    alpha = 0.8,
    show.legend = FALSE
  ) + labs(size = "Legend") +
  scale_size_area(max_size = 10) +
  geom_smooth(
    method = "lm",
    color = "red",
    se = TRUE
  ) +
  labs(
    title = "Stress Level vs Sleep Quality (r = -0.90)",
    x = "Stress Level",
    y = "Quality of Sleep"
  ) +
  theme_minimal()
g1

# 2. Sleep Duration vs Sleep Quality
g2 <- ggplot(
  sleep,
  aes(
    x = `Sleep Duration`,
    y = `Quality of Sleep`
  )
) +
  geom_count(
    color = "steelblue",
    alpha = 0.8,
    show.legend = FALSE
  ) + labs(size = "Legend") +
  scale_size_area(max_size = 10) +
  geom_smooth(
    method = "lm",
    color = "red",
    se = TRUE
  ) +
  labs(
    title = "Sleep Duration vs Sleep Quality (r = 0.88)",
    x = "Sleep Duration",
    y = "Quality of Sleep"
  ) +
  theme_minimal()
g2

# 3. Heart Rate vs Sleep Quality
g3 <- ggplot(
  sleep,
  aes(
    x = `Heart Rate`,
    y = `Quality of Sleep`
  )
) +
  geom_count(
    color = "steelblue",
    alpha = 0.8,
    show.legend = FALSE
  ) + labs(size = "Legend") +
  scale_size_area(max_size = 10) +
  geom_smooth(
    method = "lm",
    color = "red",
    se = TRUE
  ) +
  labs(
    title = "Heart Rate vs Sleep Quality (r = -0.66)",
    x = "Heart Rate",
    y = "Quality of Sleep"
  ) +
  theme_minimal()
g3

#====================수치형 끝====================

#====================범주형 시작====================
# Gender(성별), Occuupation(직업), BMI, Blood Pressure(혈압), Sleep Disorder(수면장애)
# 수면장애 여부 변수 생성
sleep <- sleep %>%
  mutate(
    Disorder_YN = ifelse(`Sleep Disorder` == "None", "No", "Yes")
  )
table(sleep$Disorder_YN)
prop.table(table(sleep$Disorder_YN))

# 4.Sleep Quality by Sleep Disorder
g4 <- ggplot(
  sleep,
  aes(
    x = `Sleep Disorder`,
    y = `Quality of Sleep`,
    fill = `Sleep Disorder`
  )
) +
  geom_boxplot(
    alpha = 0.8
    ) +
  geom_jitter(
    width = 0.3,
    alpha = 0.3
    ) +
  labs(
    title = "Sleep Quality by Sleep Disorder",
    x = "Sleep Disorder",
    y = "Quality of Sleep"
  ) +
  theme_minimal() +
  theme(legend.position = 'none')
g4

#5. Sleep Duration by Sleep Disorder
g5 <- ggplot(
  sleep,
  aes(
    x = `Sleep Disorder`,
    y = `Sleep Duration`,
    fill = `Sleep Disorder`
  )
) +
  geom_boxplot(
    alpha = 0.8
  ) +
  geom_jitter(
    width = 0.3,
    alpha = 0.3
  ) +
  labs(
    title = "Sleep Duration by Disorder",
    x = "Sleep Disorder",
    y = "Sleep Duration"
  ) +
  theme_minimal() +
  theme(legend.position = 'none')
g5

#6. Sleep Quality by Occupation
g6 <- ggplot(
  sleep,
  aes(
    x = Occupation,
    y = `Quality of Sleep`,
    fill = Occupation
  )
) +
  geom_boxplot(
    alpha = 0.8
  ) +
  geom_jitter(
    width = 0.15,
    alpha = 0.2
  ) +
  coord_flip() +
  labs(
    title = "Sleep Quality by Occupation",
    x = "Occupation",
    y = "Quality of Sleep"
  ) +
  theme_minimal() +
  theme(legend.position = 'none')
g6

#7. Sleep Duration by Occupation
g7 <- ggplot(
  sleep,
  aes(
    x = Occupation,
    y = `Sleep Duration`,
    fill = Occupation
  )
) +
  geom_boxplot(
    alpha = 0.8
  ) +
  geom_jitter(
    width = 0.15,
    alpha = 0.2
  ) +
  coord_flip() +
  labs(
    title = "Sleep Duration by Occupation",
    x = "Occupation",
    y = "Sleep Duration"
  ) +
  theme_minimal() +
  theme(legend.position = 'none')
g7

#8. Sleep Quality by BMI Category
g8 <- ggplot(
  sleep,
  aes(
    x = `BMI Category`,
    y = `Quality of Sleep`,
    fill = `BMI Category`
  )
) +
  geom_boxplot(
    alpha = 0.8
  ) +
  geom_jitter(
    width = 0.15,
    alpha = 0.2
  ) +
  labs(
    title = "Sleep Quality by BMI Category",
    x = "BMI Category",
    y = "Quality of Sleep"
  ) +
  theme_minimal() +
  theme(legend.position = 'none')
g8

#9. Sleep Duration by BMI Category
g9 <- ggplot(
  sleep,
  aes(
    x = `BMI Category`,
    y = `Sleep Duration`,
    fill = `BMI Category`
  )
) +
  geom_boxplot(
    alpha = 0.8
  ) +
  geom_jitter(
    width = 0.15,
    alpha = 0.2
  ) +
  labs(
    title = "Sleep Duration by BMI Category",
    x = "BMI Category",
    y = "Sleep Duration"
  ) +
  theme_minimal() +
  theme(legend.position = 'none')
g9

#10. Sleep Disorder ratio by BMI Category
g10 <- ggplot(
  sleep,
  aes(
    x = `BMI Category`,
    fill = `Sleep Disorder`
  )
) +
  geom_bar(
    position = 'fill'
  ) +
  labs(
    title = "Sleep Disorder ratio by BMI Category",
    x = "BMI Category",
    y = "Sleep Disorder Ratio"
  ) +
  theme_minimal()
g10

#회귀분석
#다중공선성 진단
library(car)
model <- lm(
  `Quality of Sleep` ~
    Age + 
    `Sleep Duration` +
    `Stress Level` +
    `Heart Rate` +
    `Physical Activity Level` +
    `BMI Category`,
  data = sleep
)
vif(model) # GVIF^(1/(2*Df)) 값이 2.6 이하로 나타남 // 심각한 다중공선성 문제는 없는 것으로 판단.

# 모델 해석
summary(model)

# 표준화 회귀계수
library(lm.beta)
beta_model <- lm.beta(model) # 표준화 회귀계수(Standardized Beta) // 1년, 1회, 1단계 등 기준이 다름 ... 표준화

# 변수 중요도 시각화 (표준화 회귀계수)
beta_data <- data.frame(
  Variable = names(coef(beta_model))[-1],
  Beta = coef(beta_model)[-1]
)

g11 <- ggplot(
  beta_data,
  aes(
    x = reorder(Variable, abs(Beta)),
    y = Beta,
    fill = Beta > 0
  )
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Variable Importance (Standardized Beta)",
    x = "",
    y = "Standardized Beta"
  ) +
  theme_minimal() +
  theme(
    legend.position = "none"
  )

# 그래프 저장
png(
  "g0_correlation_heatmap.png",
  width = 900,
  height = 700
)

corrplot(
  cor_matrix,
  method = "color",
  addCoef.col = "black",
  number.cex = 1.2,
  tl.srt = 30,
  diag = FALSE
)

dev.off()

ggsave("g1_stress_vs_sleep_quality.png", g1, width = 8, height = 5)
ggsave("g2_sleep_duration_vs_sleep_quality.png", g2, width = 8, height = 5)
ggsave("g3_heart_rate_vs_sleep_quality.png", g3, width = 8, height = 5)

ggsave("g4_sleep_quality_by_sleep_disorder.png", g4, width = 8, height = 5)
ggsave("g5_sleep_duration_by_sleep_disorder.png", g5, width = 8, height = 5)
ggsave("g6_sleep_quality_by_occupation.png", g6, width = 8, height = 5)
ggsave("g7_sleep_duration_by_occupation.png", g7, width = 8, height = 5)
ggsave("g8_sleep_quality_by_bmi.png", g8, width = 8, height = 5)
ggsave("g9_sleep_duration_by_bmi.png", g9, width = 8, height = 5)
ggsave("g10_sleep_disorder_ratio_by_bmi.png", g10, width = 8, height = 5)

ggsave("g11_variable_importance_beta.png", g11, width = 8, height = 5)
