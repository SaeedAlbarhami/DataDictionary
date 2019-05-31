#install.packages("data.table")
library(data.table)
#make sure your csv dataset is in the same directory where this file exist, else change the path for fread
nyc311<- fread("311_Service_Requests_from_2010_to_Present.csv", nrows = 1000)
names(nyc311)<-names(nyc311) %>% stringr::str_replace_all("\\s", ".")



#install.packages("xtable")
library(xtable) 
#install.packages("magrittr")
library(magrittr)
#install.packages("dplyr")
library(dplyr)
#install.packages("knitr") 
library(knitr)
#install.packages("dataMeta")
library(dataMeta)



options(xtable.comment=FALSE)
options(xtable.booktabs=TRUE)
narrow <- nyc311 %>%
    select(Agency, Complaint.Type, Descriptor, Incident.Zip, Status, Borough)

#Display the selected columns
kable(head(narrow)) 

#Create Dic
variable_description <- c("Acronym of responding City Government Agency", 
                          
              "This is the first level of a hierarchy
              identifying the topic of the incident or condition. 
              Complaint Type may have a corresponding Descriptor 
              (below) or may stand alone",
              
              "This is associated to the Complaint Type, and provides
              further detail on the incident or condition. 
              Descriptor values are dependent on the Complaint Type,
              and are not always required in SR.",
              
              "Incident location zip code, provided by geo validation.",
              
              "Status of SR submitted",
              
              "Provided by the submitter and confirmed by geovalidation.")

#Change the following variable types
#variable_type <- c(0, 1, 0, 1, 0, 1)

linker <- build_linker(my.data = narrow, variable_description = variable_description, variable_type = variable_type)


kable(linker, caption = "Data dictionary for original dataset")

dict <- build_dict(my.data = narrow, linker = linker,
                   prompt_varopts = FALSE)
  


kable(dict, caption = "311 Data dictionary")


## Including Plots 