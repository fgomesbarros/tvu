#
# 02 - explore TRV data
#

# Sets up R env
rm(list = ls())
require(readr)
require(dplyr)

# Reads data
proposta <- read_delim("data/siconv_proposta.csv", 
                       delim = ";", escape_double = FALSE, trim_ws = TRUE)

# Update data
subs <- proposta$SIT_PROPOSTA == "Proposta/Plano de Trabalho Aprovados"
proposta$SIT_PROPOSTA[subs] <- "Aprovado"

subs <- proposta$SIT_PROPOSTA %in% 
  c("Proposta/Plano de Trabalho Rejeitados",
    "Proposta/Plano de Trabalho Rejeitados por Impedimento técnico")
proposta$SIT_PROPOSTA[subs] <- "Rejeitado"

# Gets sample and cleans data 
proposta <- proposta %>% 
  
  # Filters proposals
  filter(SIT_PROPOSTA %in% c("Aprovado", "Rejeitado")) %>%

  # Converts data types
  mutate(VL_GLOBAL_PROP = as.numeric(VL_GLOBAL_PROP)) %>% 
  mutate(VL_REPASSE_PROP = as.numeric(VL_REPASSE_PROP)) %>% 
  mutate(VL_CONTRAPARTIDA_PROP = as.numeric(VL_CONTRAPARTIDA_PROP)) %>% 
  
  # Change NA to 0
  mutate(VL_REPASSE_PROP = if_else(is.na(VL_REPASSE_PROP), 0, 
                                   VL_REPASSE_PROP)) %>% 
  mutate(VL_CONTRAPARTIDA_PROP = ifelse(is.na(VL_CONTRAPARTIDA_PROP), 0, 
                                        VL_CONTRAPARTIDA_PROP)) %>% 
  # Calculates PERC_CONTRAPARTIDA_PROP
  mutate(PERC_CONTRAPARTIDA_PROP = VL_CONTRAPARTIDA_PROP / VL_GLOBAL_PROP) %>%
  
  # Select features
  select(UF_PROPONENTE, MES_PROP, DESC_ORGAO_SUP, DESC_ORGAO, MODALIDADE, 
         NM_BANCO, SITUACAO_CONTA, SITUACAO_PROJETO_BASICO, 
         VL_GLOBAL_PROP, PERC_CONTRAPARTIDA_PROP, SIT_PROPOSTA) %>%

  # Transforms variables to factor
  lapply(function(x) if(is.integer(x) | is.character(x)) factor(x) else x) %>% 
  as.data.frame()