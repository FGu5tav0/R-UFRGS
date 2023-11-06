# Manipulação de dados ----------------------------------------------------
# Carregar os dados
# Organizar (data tidy)
# Filtrar
# Selecionar
# Modificar
# Sumarizar variáveis
# Exportar os dados


# Importar arquivos para o R ----------------------------------------------

# Por meio do environment pela opção Import Dataset

# pela função file.choose()

file.choose()
direto <- file.choose()

# Com pacote base ---------------------------------------------------------
# dados .txt
# dados do absorção atômica são do tipo txt
# geralmente são mais leves que outros arquivos
# arquivo de log

read.table(file = direto)

dados <- read.table(file = "Aula_4/dados/dados.txt")

head(dados)

# head
dados <- read.table(file = "Aula_4/dados/dados.txt", header = T)

head(dados)

# alterando tipo e nome de linhas e colunas


dados <- read.table(file = "Aula_4/dados/dados.txt",
                    header = TRUE,
                    dec = ".", fill = TRUE,
                    comment.char = "|",
                    colClasses = c("numeric","character","numeric"),
                    col.names = c("nome 1","nome 2", "nome 3"),
                    row.names = paste(rep("linha"),1:20))

head(dados)

# CSV ---------------------------------------------------------------------

# argumentos iguais aos do read.table()
dados <- read.csv(file = "aula_4/dados/argila.csv") # utiliza o separador ","
dados <- read.csv2(file = "aula_4/dados/argila.csv") # utiliza o separador ";"

# para os mais diversos tipos de delimitadores
dados <- read.delim()

# Com pacote readr e readxl -----------------------------------------------
# readr é um pacote mais sofisticado
dados <- readr::read_csv("aula_4/dados/argila.csv")

head(dados)
# planilha excel ----------------------------------------------------------

dados <- readxl::read_excel("aula_4/dados/argila_floculada.xlsx")

head(dados)

# guias
library(readxl)

dados <- readxl::read_excel("aula_4/dados/argila_floculada.xlsx",
                            sheet = "planilha de dados") # nome ou número

head(dados)

# carregando apenas uma parte

read_excel(path = "aula_4/dados/argila_floculada.xlsx",
           range = "A1:C6") # limites da planilha


read_excel("aula_4/dados/argila_floculada.xlsx", n_max = 2)

read_excel("aula_4/dados/argila_floculada.xlsx", 
           col_names = c("dose", "bloco", "grau_de_floculação"),
           skip = 1)

# com link ----------------------------------------------------------------
# dados do site:
# https://www.ibge.gov.br/estatisticas/downloads-estatisticas.html

link <- "https://ftp.ibge.gov.br/Censo_Agropecuario/Censo_Agropecuario_2017/Caracteristicas_Gerais/xlsx/05_indicadores_xlsx.zip"

download.file(link, destfile = "aula_4/arquivo_net.zip")

unzip("aula_4/arquivo_net.zip", exdir = "aula_4/nova_pasta/")

dados <- readxl::read_excel("aula_4/nova_pasta/Indicador 01.xlsx",
                            skip = 1)

head(dados)

# organização da base de dados --------------------------------------------

library(tidyr)
library(readxl)
library(dplyr)

dados <- read_excel("aula_4/dados/argila_floculada.xlsx", 
                    sheet = "para pivotar")

head(dados)

# pivotanto com pivot_longer

dados <- pivot_longer(data = dados, 
                      cols = 2:6, 
                      names_to = "dose",
                      values_to = "grau_floculacao")

# dados <- mutate(dados,linha = row_number())

# duplicated(dados$grau_floculacao)
# pivotanto wider para bloco
# which(duplicated(dados$grau_floculacao))

pivot_wider(data = dados, 
            names_from = bloco,
            values_from = grau_floculacao) |>    
  unnest()

# para não ser necessário o unnest, cada linha deve ser única
# para isso se faz uma coluna com id
dados <- mutate(dados,linha = row_number())

pivot_wider(data = dados, 
            names_from = bloco,
            values_from = grau_floculacao)


# separando colunas -------------------------------------------------------

dados <- read_excel("aula_4/dados/argila_floculada.xlsx", sheet = "separar colunas")

separate(data = dados, 
         col = dose, 
         into =  c("dose","argila"))
# indica o separador
separate(data = dados, 
         col = dose, 
         into =  c("dose","argila"), 
         sep = " ")
# permite a alteração da classe das colunas
df <- separate(data = dados, 
               col = dose, 
               into =  c("dose","argila"), 
               sep = " ", 
               convert = T)

df |> head()

# juntando duas colunas em uma só

unite(df, col = nova_coluna, dose, argila)
unite(df, col = nova_coluna, dose, argila, sep = "-separador-")

# manipulação -------------------------------------------------------------
rm(list = ls())

df <- readxl::read_excel("aula_4/dados/argila_floculada.xlsx", 
                         sheet = "manipulacao")

glimpse(df)

str(df)

# ordem de colunas  -------------------------------------------------------

relocate(df, K)
relocate(df, c(K,P))

relocate(df, -K) |> View()

# ordem de linhas ---------------------------------------------------------

arrange(df, pH)
arrange(df, desc(pH))


# mudar o nome da coluna --------------------------------------------------

colnames(df)
colnames(df)[1] <- "amostra"
colnames(df)

# com dplyr

rename(df, amostra = ID)
rename(df, prof = profundidade)

# mais colunas
novos_nomes <- c("Potássio", "Fósforo")
rename_with(df, ~ novos_nomes, c(K,P))

# seleção de vars ---------------------------------------------------------

df[,1:8]
df[,c(1,2,3,4,7,8)]
nomes <- colnames(df)[1:8]
df[,nomes]
df[,c("dose","P","K")]
df[,c("dose","P","K")]

# com dplyr

select(df, 1:8)

select(df, c(1,2,3,4,8))

select(df, c("dose","P","K"))

select(df, starts_with("ca", ignore.case = T))

select(df, !bloco)
select(df, !c(bloco, profundidade, pH)) # com" !"
select(df, -c(bloco, profundidade, pH)) # com "-"

# filtro  -----------------------------------------------------------------

df[1:7,]
df[df$pH >= 5.5,]
df[df$pH >= 5.5 & df$pH <= 5.7,]
df[df$pH >= 5.5 & df$m_sat <= 10,]

# com dplyr

filter(df, pH >= 5.5)
filter(df, pH >= 5.5 & pH <= 5.7)
filter(df, pH >= 5.5 & `m_%` <= 10)

filter(df, ID %in% c(31,32))

# grupos ------------------------------------------------------------------

group_by(df, dose)
group_by(df, bloco, dose)

# removendo grupos
ungroup()

# criando colunas ---------------------------------------------------------

df$h_al_smp <- round(exp(10.665 - (1.1483 * df$SMP)) / 10, 2)

df$local <- "Palmas"

# com dplyr

mutate(df,
       h_al_smp = round(exp(10.665 - (1.1483 * SMP)) / 10, 2),
       local = "Palmas",
       dose = as.factor(dose)) |> View()


# sumário de dados --------------------------------------------------------

summary(df)

# com dplyr
summarise(df, mean(pH))
summarise(df, media = mean(pH))
summarise(df, media = mean(pH), desviop = sd(pH))


# variantes  --------------------------------------------------------------

# sem sufixo é o padrão
# sufixo all indica tudo
# sufixo at indica apenas as vars selecionadas
# sufixo if é sob alguma condição

filter()
filter_all() 
filter_at()
filter_if()

select()
select_all()
select_at()
select_if()

mutate()
mutate_all()
mutate_at()
mutate_if()

summarise()
summarise_all()
summarise_at()
summarise_if()


# mais de uma função com pipe ---------------------------------------------

df |> group_by(dose) |>
  summarise(mean(pH))

df |> group_by(dose, profundidade) |>
  summarise(mean(pH))

df |> group_by(dose) |>
  summarise_at(.vars = vars(P,K),
               .funs = list(media = mean, desvio = sd))

# exemplo real ------------------------------------------------------------

# vários pivotes ----------------------------------------------------------

library(tidyverse)
# falar dos conflitos entre as funções de mesmo nome

dados <- readxl::read_excel("aula_4/dados/ts_129.xlsx") |>
  janitor::clean_names()

# solução de ocnflitos entre funções de mesmo nome
conflicted::conflict_prefer("filter", "dplyr")
filter(df, dose == 0)


nomes_novos <- c(
  paste(rep("ph", 3), "_", 1:3, sep = ""),
  paste(rep("p", 3), "_", 1:3, sep = ""),
  paste(rep("k", 3), "_", 1:3, sep = "")
)

nomes_velhos <- colnames(dados[, 4:12])

df <- dados |>
  rename_at(vars(nomes_velhos), ~ all_of(nomes_novos)) |>
  pivot_longer(
    cols = c(-calcario, -p_e_k, -local),
    names_to = c("var", "prof"),
    names_sep = "_"
  ) |>
  pivot_wider(names_from = var, values_from = value) |>
  unnest()

df |> head()



# filtrando dados ---------------------------------------------------------

rm(list = ls())

library(tidyverse)

dados <- readxl::read_excel("F:/Área de trabalho/dados_Cariopsi_aquosa.xlsx",
                            sheet = 2) |>
  janitor::clean_names()


algas <- dados |>
  filter(tratamentos %in% c(1,2,3,8,9,21,22,23,24,26,27))

fosfitos <- dados |>
  filter(tratamentos %in% c(1,2,3,13,14,15,16,17,18,19,20))

quimica <- dados |>
  filter(tratamentos %in% c(1,2,3,4,5,6,7,10,11,12,25))


writexl::write_xlsx(x = list(algas = algas, 
                             fosfitos = fosfitos, 
                             quimica = quimica), 
                    path = "F:/Área de trabalho/dados_Cariopsi_aquosa.xlsx")


# exportando dados --------------------------------------------------------

# em csv
readr::write_csv()

# em excel
library(writexl)
write_xlsx(x = banco_dados, path = "caminho")

# salvando os dados de df
writexl::write_xlsx(x = df, path = "aula_4/dados_pronto.xlsx")

# mutate_at() -------------------------------------------------------------
library(tidyverse)

dados <- tibble(a = seq(1,2, length = 10),
                b = letters[1:10],
                c = seq(4,7, length = 10),
                d = letters[1:10],
                e = 1:10,
                f = letters[1:10],
                g = seq(1,10, length = 10),
                grupo = c(rep("um",5),rep("dois",5)),
                grupo_dois = c(rep("sim",3),rep("não",3), rep("claro",4))
)

dados |> head()

dados |> mutate_at(vars(a,c,e,g), ~ as.factor(round(., 2)))

dados |> mutate_at(vars(grupo, grupo_dois), ~ as.factor(.))

dados |> mutate_if(is.numeric, ~ round(., 0))

dados |> top_n(10)
dados |> count(grupo)
dados |> count(grupo, grupo_dois)


# juntar e separar bases de dados -----------------------------------------

# nativo
merge()
cbind()
rbind()
subset()

# dplyr

full_join()
left_join()
right_join()
anti_join()
inner_join()
join_by() # fazer os grupos iguais

bind_cols()
bind_rows()

# juntar dois bancos de dados ---------------------------------------------
rm(list = ls())

# dados 1

d1 <- readxl::read_excel(path = "aula_4/join/t_1.xlsx")

d2 <- readxl::read_excel(path = "aula_4/join/t_2.xlsx")


dados_ok <- full_join(d1, d2)

# map ---------------------------------------------------------------------
# pacote purrr para programação funcional

pasta <- "aula_4/join/"

docs <- list.files(pasta, full.names = T)

lista_de_arquivos <-  map(docs, read_excel)

dft <- map_df(docs, read_excel)

# outras funções úteis ----------------------------------------------------

df <- data.frame(x = c(1,2,3,NA,5,7),
                 y = 1:6,
                 grup = c(rep("a",3),rep("b",3)))

df |> head()

# substitui os valores faltantes
replace_na(df, list(x = 0))

df |> mutate(x = replace_na(x, 0))

# permanece apenas com as colunas modificadas

df |> transmute(x1 = x^2)

# conta a quantidade de observações
df |> count()
df |> group_by(grup) |> count()

# fatiar os dados
# min
iris |> slice_min(order_by = Sepal.Length)
min(iris$Sepal.Length)
# max
iris |> slice_max(order_by = Sepal.Length)
max(iris$Sepal.Length)

# maiores valores de determinada coluna
iris |> top_n(Sepal.Length, n = 2)



