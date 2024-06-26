

library(googlesheets4)
library(tidyverse)


#READ IN GOOGLE SHEET USING THE ID

df<-read_sheet(as_sheets_id('1c4967cvQp12KLbZgsT36iBuBGCAehmB8t6HFAffgGz4'), 
                sheet = "HFR",
                skip=1,
                col_types="c") 


?read_sheet()



# DL entire Google Drive folder

library(googledrive)
library(glamr)
library(readxl)


load_secrets()

# Specify the folder ID (replace with your actual folder ID)
folder_id <- "https://drive.google.com/drive/folders/1grS2QK1RIYnNa7wNrbc_r55VXV3H8KyF"

# List all files in the folder
files_in_folder <- drive_ls(as_id(folder_id))


# Download each file
walk2(files_in_folder$id, files_in_folder$name, 
      ~ drive_download(as_id(.x), 
                       path = file.path("Dataout", .y), 
                       overwrite = TRUE))

# List all the files downloaded
hfr_files<-list.files("Dataout",pattern="HFR",full.names = TRUE)

# Read in all downloaded files and combine
hfr <- hfr_files %>%
  map(~ read_excel(.x, sheet = "HFR", skip = 1)) %>%
  bind_rows()


