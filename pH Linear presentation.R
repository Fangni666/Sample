library(ggplot2)
library(lubridate)
library(readxl)
library(tidyr)
library(dplyr)
library(scales)

# 1. 设置文件路径（脱敏为通用相对路径）
file_path <- "data/sample_ph_data.xlsx"

# 2. 从 Excel 文件读取数据
df_wide <- read_excel(file_path, sheet = "Cleaned_Data")

# 3. 将宽格式数据转换为长格式，并解析时间
df_long <- df_wide %>%
  pivot_longer(
    cols = c(Station_Alpha, Station_Beta),
    names_to = "Station",
    values_to = "pH"
  ) %>%
  mutate(
    DateTime = ymd_hms(DateTime)
  )

# 4. 绘制 pH 值的时间序列图
ggplot(df_long, aes(x = DateTime, y = pH, color = Station)) +
  geom_line() +
  labs(
    title = "pH",
    x = NULL,
    y = NULL,
    color = NULL
  ) +
  scale_color_manual(
    name = NULL,
    values = c(
      "Station_Alpha" = "#FAAFBE",
      "Station_Beta"  = "#39C5BB"
    )
  ) +
  scale_x_datetime(date_breaks = "5 days", date_labels = "%Y/%m/%d") +
  theme_bw() +
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.position = "bottom",
    axis.text.x = element_text(angle = 45, hjust = 1)
  )