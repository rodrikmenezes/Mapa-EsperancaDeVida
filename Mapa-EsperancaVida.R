# Remover objetos
rm(list = ls())

# Selecionar um ano entre 2000 e 2060
#------------
Ano = '2040'
# -----------

# Pacotes
library(readr)
library(geobr)
library(ggplot2)
library(dplyr)

# Importar dados
EsperancaVida <- read_delim("EsperancaVida.csv", 
                            ";", escape_double = FALSE, locale = locale(encoding = "WINDOWS-1252"), 
                            trim_ws = TRUE)

# Impoertar dados 
Estados = read_state()

# Unir tabelas
Tabela <- inner_join(Estados, EsperancaVida, by='name_state' )

# Seleção de dados

Selecao <- Tabela %>% select(name_state, Ano)

# Mapa
print(
ggplot() +
  geom_sf(data = Selecao, aes(fill = Selecao[[Ano]]))+
  labs(title = "Esperança de Vida", 
       caption = paste('mín = ', min(Selecao[[Ano]]), 'máx = ', max(Selecao[[Ano]])),
       subtitle = paste('Ano: ', as.character(Ano)))+
  scale_fill_distiller(palette = "Greens", name = "") +
  theme_minimal()+
  theme(axis.title=element_blank(),
                 axis.text=element_blank(),
                 axis.ticks=element_blank()))
