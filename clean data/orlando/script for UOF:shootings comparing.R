#first I want to call libraries
library(dplyr)
library(tidyr)

#turn off scientific notation
options(scipen=999)

# change these two lines!
#I want to call in my datasets (shootings, use of force).
UOF <-read.csv(file='OPD_Response_To_Resistance.csv', stringsAsFactors = FALSE)
shootings<-read.csv(file='OPD_Officer-Involved_Shootings.csv', stringsAsFactors = FALSE)

#numericize the data (UOF)
#first split year/date into two separate variables
SplitDateTime_UOF<-strsplit(as.character(UOF$Incident.Date.Time),"\\s")
SplitDateTime_UOF<-do.call(rbind, SplitDateTime_UOF)
colnames(SplitDateTime_UOF)<-(c("date","time", "hour"))
SplitDateTime_UOF<-as.data.frame(SplitDateTime_UOF, stringsAsFactors=FALSE)

NoTitle_UOF <- UOF[UOF$Incident.Date.Time != "", ]

#making a table with all relevant metadata for UOF
AllMetadata_UOF<-cbind.data.frame(SplitDateTime_UOF$date,SplitDateTime_UOF$time,SplitDateTime_UOF$hour,NoTitle_UOF$Officers.Race,NoTitle_UOF$Officers.Ethnicity,NoTitle_UOF$Officers.Sex,NoTitle_UOF$Offenders.Race,NoTitle_UOF$Offenders.Ethnicity,NoTitle_UOF$Offenders.Sex, stringsAsFactors=FALSE)

colnames(AllMetadata_UOF)<-(c("date","time", "hour", "Officers.Race","Officers.Ethnicity","Officers.Sex", "Offenders.Race","Offenders.Ethnicity","Offenders.Sex"))

#make all null values = U for UOF
AllMetadata_UOF_U<-AllMetadata_UOF
AllMetadata_UOF_U[AllMetadata_UOF=="Not Specified"]<-"U"
AllMetadata_UOF_U[AllMetadata_UOF=="-"]<-"U"
AllMetadata_UOF_U[AllMetadata_UOF=="X"]<-"U"

#Change race, ethnicity, sex to be consistent with UOF
AllMetadata_UOF_Fix<-AllMetadata_UOF_U

AllMetadata_UOF_Fix$Officers.Race <- gsub('W', 'White', AllMetadata_UOF_Fix$Officers.Race)
AllMetadata_UOF_Fix$Officers.Race <- gsub('A', 'Asian', AllMetadata_UOF_Fix$Officers.Race)
AllMetadata_UOF_Fix$Officers.Race <- gsub('B', 'Black', AllMetadata_UOF_Fix$Officers.Race)
AllMetadata_UOF_Fix$Officers.Race <- gsub('U', 'Unknown', AllMetadata_UOF_Fix$Officers.Race)

AllMetadata_UOF_Fix$Officers.Ethnicity <- gsub('NH', 'Non-hispanic', AllMetadata_UOF_Fix$Officers.Ethnicity)
AllMetadata_UOF_Fix$Officers.Ethnicity <- gsub('HI', 'Hispanic', AllMetadata_UOF_Fix$Officers.Ethnicity)
AllMetadata_UOF_Fix$Officers.Ethnicity <- gsub('U', 'Unknown', AllMetadata_UOF_Fix$Officers.Ethnicity)

AllMetadata_UOF_Fix$Officers.Sex <- gsub('M', 'Male', AllMetadata_UOF_Fix$Officers.Sex)
AllMetadata_UOF_Fix$Officers.Sex <- gsub('F', 'Female', AllMetadata_UOF_Fix$Officers.Sex)
AllMetadata_UOF_Fix$Officers.Sex <- gsub('U', 'Unknown', AllMetadata_UOF_Fix$Officers.Sex)

AllMetadata_UOF_Fix$Offenders.Race <- gsub('W', 'White', AllMetadata_UOF_Fix$Offenders.Race)
AllMetadata_UOF_Fix$Offenders.Race <- gsub('A', 'Asian', AllMetadata_UOF_Fix$Offenders.Race)
AllMetadata_UOF_Fix$Offenders.Race <- gsub('B', 'Black', AllMetadata_UOF_Fix$Offenders.Race)
AllMetadata_UOF_Fix$Offenders.Race <- gsub('U', 'Unknown', AllMetadata_UOF_Fix$Offenders.Race)

AllMetadata_UOF_Fix$Offenders.Ethnicity <- gsub('NH', 'Non-hispanic', AllMetadata_UOF_Fix$Offenders.Ethnicity)
AllMetadata_UOF_Fix$Offenders.Ethnicity <- gsub('HI', 'Hispanic', AllMetadata_UOF_Fix$Offenders.Ethnicity)
AllMetadata_UOF_Fix$Offenders.Ethnicity <- gsub('U', 'Unknown', AllMetadata_UOF_Fix$Offenders.Ethnicity)

AllMetadata_UOF_Fix$Offenders.Sex <- gsub('M', 'Male', AllMetadata_UOF_Fix$Offenders.Sex)
AllMetadata_UOF_Fix$Offenders.Sex <- gsub('F', 'Female', AllMetadata_UOF_Fix$Offenders.Sex)
AllMetadata_UOF_Fix$Offenders.Sex <- gsub('U', 'Unknown', AllMetadata_UOF_Fix$Offenders.Sex)

#####################

#numericize the data (SHOOTINGS)
NoTitle_shootings <- shootings[shootings$Date != "", ]

#making a table with all relevant metadata for shootings
AllMetadata_shootings<-cbind.data.frame(NoTitle_shootings$Date,NoTitle_shootings$Officer.Race,NoTitle_shootings$Ethnicity,NoTitle_shootings$Officer.Gender,NoTitle_shootings$Suspect.Race,NoTitle_shootings$Suspect.Gender,NoTitle_shootings$Suspect.Hit,NoTitle_shootings$Fatal, stringsAsFactors=FALSE)
colnames(AllMetadata_shootings)<-(c("date","Officer.Race","Officer.Ethnicity","Officer.Gender", "Suspect.Race","Suspect.Gender","Suspect.Hit","Fatal"))

#make all null values = U for shootings
AllMetadata_shootings_U<-AllMetadata_shootings
AllMetadata_shootings_U[AllMetadata_shootings=="n/a"]<-"U"
AllMetadata_shootings_U[AllMetadata_shootings=="Exempt"]<-"U"

#Change race, ethnicity, sex to be consisted with shootings
AllMetadata_shootings_Fix<-AllMetadata_shootings_U

AllMetadata_shootings_Fix$Officer.Race <- gsub('W', 'White', AllMetadata_shootings_Fix$Officer.Race)
AllMetadata_shootings_Fix$Officer.Race <- gsub('A', 'Asian', AllMetadata_shootings_Fix$Officer.Race)
AllMetadata_shootings_Fix$Officer.Race <- gsub('B', 'Black', AllMetadata_shootings_Fix$Officer.Race)
AllMetadata_shootings_Fix$Officer.Race <- gsub('U', 'Unknown', AllMetadata_shootings_Fix$Officer.Race)
AllMetadata_shootings_Fix$Officer.Race <- gsub('O', 'Omitted', AllMetadata_shootings_Fix$Officer.Race)

AllMetadata_shootings_Fix$Officer.Ethnicity <- gsub('N', 'Non-hispanic', AllMetadata_shootings_Fix$Officer.Ethnicity)
AllMetadata_shootings_Fix$Officer.Ethnicity <- gsub('H', 'Hispanic', AllMetadata_shootings_Fix$Officer.Ethnicity)
AllMetadata_shootings_Fix$Officer.Ethnicity <- gsub('U', 'Unknown', AllMetadata_shootings_Fix$Officer.Ethnicity)

AllMetadata_shootings_Fix$Officer.Gender <- gsub('M', 'Male', AllMetadata_shootings_Fix$Officer.Gender)
AllMetadata_shootings_Fix$Officer.Gender <- gsub('F', 'Female', AllMetadata_shootings_Fix$Officer.Gender)
AllMetadata_shootings_Fix$Officer.Gender <- gsub('U', 'Unknown', AllMetadata_shootings_Fix$Officer.Gender)

AllMetadata_shootings_Fix$Suspect.Gender <- gsub('F', 'Female', AllMetadata_shootings_Fix$Suspect.Gender)
AllMetadata_shootings_Fix$Suspect.Gender <- gsub('M', 'Male', AllMetadata_shootings_Fix$Suspect.Gender)
