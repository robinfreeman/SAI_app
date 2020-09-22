# Golbal environment for both ui and server
# Include lines 3-6 in all global.R scripts
library(plotly)
library(dplyr)
library(stringr)
#library(png)
library(shinyjs)
library(shiny)
library(shinydashboard)
#library(DT)
#library(visNetwork)
#library(rintrojs)
library(ggthemes)
library(leaflet)
library(data.table)
library(mapdeck)
library(ggtext)

#install.packages("uuid")
#install.packages("curl")
#install.packages("GAlogger", repos = "http://www.datatailor.be/rcube", type = "source")

library(GAlogger)
ga_set_tracking_id("UA-381184-3")
ga_set_approval(consent = TRUE)

set_token("pk.eyJ1IjoiY3l0b3MiLCJhIjoiSHBoWG5VQSJ9.hYFgp0rZwNLvbIff5puV8A")

source("carouselPanel.R")

species_lambdas_table = read.table("data/trends/Species_average_lambdas.txt", row.names = NULL)
colnames(species_lambdas_table)[1] = "Taxa"

population_lambdas_table = read.table("data/trends/Populations_average_lambdas.txt", row.names = NULL)
colnames(population_lambdas_table)[1] = "Taxa"

# The data is read in the global.r script
# because it is used in both the ui.R and server.R scripts
LPI_global <- read.table("data/trends/global_infile_Results.txt", stringsAsFactors=F)
LPI_global$Title = "Global"
LPI_global$Description = "<strong>The Living Planet Index: 1970 to 2016</strong>. The bold line shows the index values and the shaded areas represent the statistical certainty surrounding the trend (95%). The index represents 20,811 populations of 4,392 species. All indices are weighted by species richness, giving species-rich taxonomic groups in terrestrial and freshwater systems more weight than groups with fewer species."
LPI_global$Year = as.numeric(rownames(LPI_global))

LPI_fw <- read.table("data/trends/FW_infile_Results.txt", stringsAsFactors=F)
LPI_fw$Title = "Freshwater"
LPI_fw$Description = "<strong>The Living Planet Index for Freshwater populations: 1970 to 2016</strong>. The bold line shows the index values and the shaded areas represent the statistical certainty surrounding the trend (95%).  The index represents 3,741 populations of 944 species. All indices are weighted by species richness, giving species-rich taxonomic groups in terrestrial and freshwater systems more weight than groups with fewer species."
LPI_fw$Year = as.numeric(rownames(LPI_fw))

#LPI_terr <- read.table("data/trends/Terrestrial_D_infile_Results.txt", stringsAsFactors=F)
#LPI_terr$Title = "Terrestrial"
#LPI_terr$Year = as.numeric(rownames(LPI_terr))

#LPI_marine <- read.table("data/trends/marine_infile_Results.txt", stringsAsFactors=F)
#LPI_marine$Title = "Marine"
#LPI_marine$Year = as.numeric(rownames(LPI_marine))

LPI_reptiles <- read.table("data/trends/Reptiles_infile_Results.txt", stringsAsFactors=F)
LPI_reptiles$Title = "Reptiles"
LPI_reptiles$Description = "<strong>The Living Planet Index for Reptile populations: 1970 to 2016</strong>. The bold line shows the index values and the shaded areas represent the statistical certainty surrounding the trend (95%). The index represents 672 populations of 227 species. All indices are weighted by species richness, giving species-rich taxonomic groups in terrestrial and freshwater systems more weight than groups with fewer species."
LPI_reptiles$Year = as.numeric(rownames(LPI_reptiles))

# IPBES...

LPI_IPBES_Africa <- read.table("data/trends/IPBES_Africa_infile_Results.txt", stringsAsFactors=F)
LPI_IPBES_Africa$Title = "IPBES Africa"
LPI_IPBES_Africa$Description = "<strong>The Living Planet Index for the Africa IPBES region: 1970 to 2016</strong>. The bold line shows the index values and the shaded areas represent the statistical certainty surrounding the trend (95%). The index represents 1,318 populations of 371 species. All indices are weighted by species richness, giving species-rich taxonomic groups in terrestrial and freshwater systems more weight than groups with fewer species."
LPI_IPBES_Africa$Year = as.numeric(rownames(LPI_IPBES_Africa))

LPI_IPBES_AsiaPac <- read.table("data/trends/IPBES_AsiaPac_infile_Results.txt", stringsAsFactors=F)
LPI_IPBES_AsiaPac$Title = "IPBES Asia-Pacific"
LPI_IPBES_AsiaPac$Description = "<strong>The Living Planet Index for the Asia-Pacific IPBES region: 1970 to 2016</strong>. The bold line shows the index values and the shaded areas represent the statistical certainty surrounding the trend (95%). The index represents 2,167 populations of 581 species. All indices are weighted by species richness, giving species-rich taxonomic groups in terrestrial and freshwater systems more weight than groups with fewer species."
LPI_IPBES_AsiaPac$Year = as.numeric(rownames(LPI_IPBES_AsiaPac))

LPI_IPBES_ECA <- read.table("data/trends/IPBES_ECA_infile_Results.txt", stringsAsFactors=F)
LPI_IPBES_ECA$Title = "IPBES Europe-Central Asia"
LPI_IPBES_ECA$Description = "<strong>The Living Planet Index for the Europe-Central Asia IPBES region: 1970 to 2016</strong>. The bold line shows the index values and the shaded areas represent the statistical certainty surrounding the trend (95%). The index represents 4,283 populations of 608 species. All indices are weighted by species richness, giving species-rich taxonomic groups in terrestrial and freshwater systems more weight than groups with fewer species."
LPI_IPBES_ECA$Year = as.numeric(rownames(LPI_IPBES_ECA))

LPI_IPBES_LatAmCarib <- read.table("data/trends/IPBES_LatAmCarib_infile_Results.txt", stringsAsFactors=F)
LPI_IPBES_LatAmCarib$Title = "IPBES Latin America and Caribbean"
LPI_IPBES_LatAmCarib$Description = "<strong>The Living Planet Index for the Latin America and Caribbean IPBES region: 1970 to 2016</strong>. The bold line shows the index values and the shaded areas represent the statistical certainty surrounding the trend (95%). The index represents 1,159 populations of 761 species. All indices are weighted by species richness, giving species-rich taxonomic groups in terrestrial and freshwater systems more weight than groups with fewer species."
LPI_IPBES_LatAmCarib$Year = as.numeric(rownames(LPI_IPBES_LatAmCarib))

LPI_IPBES_NorthAm <- read.table("data/trends/IPBES_NorthAm_infile_Results.txt", stringsAsFactors=F)
LPI_IPBES_NorthAm$Title = "IPBES North America"
LPI_IPBES_NorthAm$Description = "<strong>The Living Planet Index for the North America IPBES region: 1970 to 2016</strong>. The bold line shows the index values and the shaded areas represent the statistical certainty surrounding the trend (95%). The index represents 2,473 populations of 944 species. All indices are weighted by species richness, giving species-rich taxonomic groups in terrestrial and freshwater systems more weight than groups with fewer species."
LPI_IPBES_NorthAm$Year = as.numeric(rownames(LPI_IPBES_NorthAm))

#LPI_trends <- rbind(LPI_global, LPI_fw, LPI_terr, LPI_marine, LPI_reptiles)
LPI_trends <- rbind(LPI_global, LPI_fw, LPI_reptiles, LPI_IPBES_Africa, LPI_IPBES_AsiaPac, LPI_IPBES_ECA, LPI_IPBES_LatAmCarib, LPI_IPBES_NorthAm)
LPI_trends$Title = as.factor(LPI_trends$Title)
cat(file=stderr(), "Created trends data frame")
#print(LPI_trends)

colmap = c("Global" = "#e7298a", "Freshwater" = "#a6cee3", "Terrestrial" = "#33a02c", "Marine" = "#1f78b4", 
           "Reptiles" = "#b2df8a", "IPBES Africa" = "#ff7f00", "IPBES Asia-Pacific" = "#fb9a99", 
           "IPBES Europe-Central Asia" = "#cab2d6", "IPBES Latin America and Caribbean" = "#e31a1c", "IPBES North America" = "#fdbf6f")

#['#a6cee3','#1f78b4','#b2df8a','#33a02c','#fb9a99','#e31a1c','#fdbf6f','#ff7f00','#cab2d6']


global_10yr <- read.table("data/trends/global_infile_Results_TS10.txt", stringsAsFactors=F)
global_10yr$Title = "Global LPI (10 years+)"
global_10yr$Description = "<strong>The Living Planet Index for only time-series of 10 years or more</strong>. The bold line shows the index values and the shaded areas represent the statistical certainty surrounding the trend (95%). All indices are weighted by species richness, giving species-rich taxonomic groups in terrestrial and freshwater systems more weight than groups with fewer species."
global_10yr$Year = as.numeric(rownames(global_10yr))

global_5yr <- read.table("data/trends/global_infile_Results_TS5.txt", stringsAsFactors=F)
global_5yr$Title = "Global LPI (5 years+)"
global_5yr$Description = "<strong>The Living Planet Index for only time-series of 5 years or more</strong>. The bold line shows the index values and the shaded areas represent the statistical certainty surrounding the trend (95%). All indices are weighted by species richness, giving species-rich taxonomic groups in terrestrial and freshwater systems more weight than groups with fewer species."
global_5yr$Year = as.numeric(rownames(global_5yr))

global_3yr <- read.table("data/trends/global_infile_Results_TS3.txt", stringsAsFactors=F)
global_3yr$Title = "Global LPI (3 years+)"
global_3yr$Description = "<strong>The Living Planet Index for only time-series of 3 years or more</strong>. The bold line shows the index values and the shaded areas represent the statistical certainty surrounding the trend (95%). All indices are weighted by species richness, giving species-rich taxonomic groups in terrestrial and freshwater systems more weight than groups with fewer species."
global_3yr$Year = as.numeric(rownames(global_3yr))

#LPI_trends <- rbind(LPI_global, LPI_fw, LPI_terr, LPI_marine, LPI_reptiles)
LPI_trends_ts_length <- rbind(global_10yr, global_5yr, global_3yr)
LPI_trends_ts_length$Title = as.factor(LPI_trends_ts_length$Title)

cat(file=stderr(), "Created ts trends data frame")
#print(LPI_trends)

reptile_pops = read.table("data/trends/Reptiles_pops.txt", header = T)

datapoints = fread("data/trends/Datapoints.csv")

datapoints$Reptile = FALSE
datapoints$Reptile[datapoints$ID %in% reptile_pops$ID] = TRUE

datapoints = subset(datapoints, year >= 1970)
datapoints = subset(datapoints, year <= 2016)

datapoints$LPR_IPBES_Region = datapoints$IPBES_region
datapoints$LPR_IPBES_Region[datapoints$IPBES_subregion == "North America"] = "North America"
datapoints$LPR_IPBES_Region[datapoints$IPBES_subregion %in% c("Caribbean", "South America", "Mesoamerica")] = "Latin America and Caribbean"

lpi_data_map <- fread("data/Final_dataset_20200424.csv", na.strings = "NA", select = c("Latitude", "Longitude", "Confidential", "New_LPR20", "New_spp_LPR20", "ID", "Binomial", "Common_name"))

#cat(file=stderr(), nrow(lpi_data_map))

# Hide confidential data from map
lpi_data_map <- subset(lpi_data_map, Confidential == 0)

#cat(file=stderr(), nrow(lpi_data_map))
lpi_data_map$Latitude = as.numeric(lpi_data_map$Latitude)
lpi_data_map$Longitude = as.numeric(lpi_data_map$Longitude)

lpi_data_map$Binomial = gsub("_", " ", lpi_data_map$Binomial)

# Quick fixes for incorrect lat/longs
lpi_data_map$Latitude[lpi_data_map$ID == 1397] = 63
lpi_data_map$Longitude[lpi_data_map$ID == 1397] = -20

lpi_data_map$Latitude[lpi_data_map$ID == 19135] = 58.2225
lpi_data_map$Longitude[lpi_data_map$ID == 19135] = 20.07

lpi_data_map$Latitude[lpi_data_map$ID == 19584] = 23.13389	
lpi_data_map$Longitude[lpi_data_map$ID == 19584] = -83.3444

lpi_data_map$Latitude[lpi_data_map$ID == 19823] = 49.7746	
lpi_data_map$Longitude[lpi_data_map$ID == 19823] = -57.954

lpi_data_map$Latitude[lpi_data_map$ID == 2069] = 55	
lpi_data_map$Longitude[lpi_data_map$ID == 2069] = 155

lpi_data_map$Latitude[lpi_data_map$ID == 2071] = 55	
lpi_data_map$Longitude[lpi_data_map$ID == 2071] = 155

# Using common names seems to break the map - perhaps a funny character encoding?
#lpi_data_map$Common_name = gsub("_", " ", lpi_data_map$Common_name)
# Replace underscore with space in Species and common name for display
#DisplayName = paste(gsub("_", " ", lpi_data_map$Common_name), " (", gsub("_", " ", lpi_data_map$Binomial) ,")", sep="_")

#lpi_data_map <- lpi_data[, c("Latitude", "Longitude", "New_LPR20", "New_spp_LPR20", "Binomial")]
#colnames(lpi_data_map) <- c("latitude", "longitude")

lpi_data_all <- fread("data/LPI_pops_20180814.csv", select = c("ID","Binomial","Class", "TS_length","Av_lambda","T_lambda","Trend"))


lpi_data_all$Taxa <- lpi_data_all$Class
lpi_data_all$Taxa <- gsub("Actinopterygii", "Fishes",lpi_data_all$Taxa)
lpi_data_all$Taxa <- gsub("Sarcopterygii", "Fishes",lpi_data_all$Taxa)
lpi_data_all$Taxa <- gsub("Elasmobranchii", "Fishes",lpi_data_all$Taxa)
lpi_data_all$Taxa <- gsub("Chondrichthyes", "Fishes",lpi_data_all$Taxa)
lpi_data_all$Taxa <- gsub("Cephalaspidomorphi", "Fishes",lpi_data_all$Taxa)
lpi_data_all$Taxa <- gsub("Holocephali", "Fishes",lpi_data_all$Taxa)
lpi_data_all$Taxa <- gsub("Myxini", "Fishes",lpi_data_all$Taxa)
lpi_data_all$Taxa <- gsub("Aves", "Birds",lpi_data_all$Taxa)
lpi_data_all$Taxa <- gsub("Mammalia", "Mammals",lpi_data_all$Taxa)
lpi_data_all$Taxa <- gsub("Amphibia", "Amphibians",lpi_data_all$Taxa)
lpi_data_all$Taxa <- gsub("Reptilia", "Reptiles",lpi_data_all$Taxa)

sp_lambdas <- fread("data/trends/Species_average_lambdas.txt")
