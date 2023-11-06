# pacotes -------------------------------------------------------

library(gtrendsR)
library(tidyverse)
library(ggrepel)
library(patchwork)
library(ggtext)

# set -----------------------------------------------------------

# dados ---------------------------------------------------------

dados <- gtrends(
  keyword = c("Agronomia", "Zootecnia"),
  geo = "BR",
  time = "all",
  gprop = "web"
)


# dados2 ------------------------------------------------------------------

dados <- read_csv("aula_4/multiTimeline.csv",
                  skip = 1)

# plot ----------------------------------------------------------

dados |>
  separate(
    col = Month,
    into = c("ano", "mes"),
    sep = "-"
  ) |>
  mutate(
    ano = as.numeric(ano),
    mes = as.numeric(mes)
  ) |>
  rename(
    "Agronomia" = `agronomia: (Brazil)`,
    "Zootecnia" = `zootecnia: (Brazil)`
  ) |>
  filter(ano < 2022) |>
  pivot_longer(
    cols = c("Agronomia", "Zootecnia"),
    names_to = "area",
    values_to = "hits"
  ) |>
  mutate(
    media_geral = mean(hits, na.rm = T),
    data = paste(ano, "-", mes, "-", "01", sep = ""),
    data = ymd(data)
  ) |>
  group_by(area) |>
  mutate(
    label_area = case_when(
      hits == max(hits) ~ as.character(area),
      TRUE ~ NA_character_
    ),
    texto_media = "Média Geral",
  ) |>
  ggplot(aes(
    x = data, y = hits,
    col = area,
    size = area
  )) +
  geom_line(show.legend = F) +
  scale_size_manual(values = c(.73, .4)) +
  # scale_x_date(date_breaks = "1 month") +
  scale_color_manual(values = c("#4987d0", "gray50")) +
  geom_hline(aes(yintercept = media_geral),
    col = "black",
    size = 0.7,
    linetype = 1
  ) +
  geom_label(
    aes(
      x = data[60],
      y = media_geral,
      label = texto_media
    ),
    size = 4,
    col = "black"
  ) +
  coord_cartesian(expand = F) +
  labs(
    title = "Padrão de interesse ao longo do tempo",
    subtitle = '<span style = "color:#4987d0"> Agronomia </span> e <span style = "color:gray50"> Zootecnia </span>',
    y = "Interesse de buscas",
    x = NULL,
    col = NULL,
    size = NULL,
    caption = "Fonte: Google Trends"
  ) +
  theme_classic(16) +
  theme(
    text = element_text(colour = "black"),
    axis.title.y = element_text(hjust = 1),
    legend.position = "none",
    plot.subtitle = element_markdown()
  )




# com gtrend do r ---------------------------------------------------------


p1 <- dados$interest_over_time |>
  select(!c(time, gprop, category, geo)) |>
  mutate(
    media_geral = mean(hits),
    area = fct(keyword),
    texto_media = "Média Geral",
    ano = year(date)
  ) |>
  filter(ano <= "2021") |>
  group_by(area) |>
  mutate(label_area = case_when(
    hits == max(hits) ~ as.character(area),
    TRUE ~ NA_character_
  )) |>
  ggplot(aes(
    x = date, y = hits,
    col = keyword,
    size = keyword
  )) +
  geom_line(show.legend = F) +
  scale_size_manual(values = c(.73, .4)) +
  scale_color_manual(values = c("#4987d0", "gray70")) +
  geom_hline(aes(yintercept = media_geral),
    col = "black",
    size = 0.7,
    linetype = 1
  ) +
  geom_label(
    aes(
      x = date[30],
      y = media_geral,
      label = texto_media
    ),
    size = 4,
    col = "black"
  ) +
  geom_label_repel(aes(label = as.character(label_area)),
    label.size = 1, size = 4,
    nudge_x = 0,
    nudge_y = 5,
    na.rm = TRUE
  ) +
  coord_cartesian(expand = F) +
  labs(
    title = "",
    y = "Interesse de buscas",
    x = NULL,
    col = NULL,
    size = NULL,
    caption = "Fonte: Google Trends"
  ) +
  theme_classic(16) +
  theme(
    text = element_text(colour = "gray40"),
    axis.title.y = element_text(hjust = 1),
    legend.position = "none"
  )

p1
# text <- tibble(
#   x = 0, y = 0,
#   label = "Redução brusca na busca por área de alto valor")
#
# p2 <- ggplot(text, aes(x = x, y = y)) +
#   geom_textbox(
#     aes(label = label),
#     box.color = "white", fill="white", width = unit(10, "lines"),
#     size = 3, lineheight = 1
#   ) +
#   coord_cartesian(expand = FALSE, clip = "off") +
#   theme_void()
#
# p1 + inset_element(p = p2, bottom = .7, top = .8,
#                  left = 2, right = -.4,
#                  align_to = "plot")

# ggsave(plot = p1, filename = "agro_do_teste.jpg", width = 8,
#        height = 6, dpi = 800)
