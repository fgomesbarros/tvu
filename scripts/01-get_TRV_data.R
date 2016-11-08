#
# 01 - Get TRV data
#
  
# Sets up R env
rm(list = ls())
url_data <- "http://portal.convenios.gov.br/images/docs/CGSIS/csv/siconv.zip"

# Creates data folder
if(!file.exists("data")) dir.create("data")

# Downloads data
download.file(url = url_data, destfile = "data/siconv.zip")
unzip(zipfile = "data/siconv.zip", exdir = "data")
file.remove("data/siconv.zip")