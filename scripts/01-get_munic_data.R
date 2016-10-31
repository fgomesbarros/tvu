###############################################################################
#
# 01 - Get Munic Data
#
###############################################################################

# Sets up environment
rm(list = ls())

# Sets variables
url_base <- "ftp://ftp.ibge.gov.br/Perfil_Municipios/"
years <- c(2011:2014)
preffix_file <- "base_MUNIC_xls_"
suffix_file <- ".zip"
data_dir <- "data"

# Creates data folder
if(!file.exists(data_dir)) dir.create(data_dir)

# Download files
for(i in years) {
  file_name <- paste(data_dir, "/", preffix_file, i, suffix_file, sep = "")
  url <- paste(url_base, i, "/", preffix_file, i, suffix_file, sep = "")
  
  download.file(url = url, destfile = file_name)
  unzip(zipfile = file_name, exdir = data_dir)
  file.remove(file_name)
  print(url)
}