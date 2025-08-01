# Based on code from https://rpubs.com/mramos/ganttchart

# Download and install plotrix package
install.packages("plotrix")

# Load the package
library(plotrix)
library(RColorBrewer)
library(tidyverse)

# People names and  dates from common cv. Roles will be categories of student.
# 1=PI, 2=technician , 3=postdoc, 4=PhD, 5=MSc, 6=Undergrad

Ymd.format<-"%Y/%m/%d"
present <- Sys.Date() %>%
  { gsub("-", "/", .) }


gantt.df.initiate <- data.frame(labels=character(),
                 starts=character(), 
                 ends=character(), 
                 priorities=double(),
                 stringsAsFactors=FALSE) 

gantt.df <- gantt.df.initiate %>%
  add_row(labels="Trevor Rife",starts="2022/06/01",ends=present,priorities=1) %>%
  add_row(labels="Chaney Courtney",starts="2022/06/01",ends=present,priorities=2) %>% 
  add_row(labels="Mason McNair",starts="2022/10/01",ends="2024/08/02",priorities=3) %>% 
  add_row(labels="Bryan Ellerbrock",starts="2023/02/01",ends="2025/06/13",priorities=2) %>% 
  add_row(labels="Adrianna Guzman",starts="2023/06/01",ends="2023/08/15",priorities=6) %>% 
  add_row(labels="Walker Spivey",starts="2023/08/01",ends=present,priorities=4) %>% 
  add_row(labels="Siddharth Malladi",starts="2023/08/01",ends="2024/05/01",priorities=5) %>% 
  add_row(labels="Prasad Kamath",starts="2024/06/17",ends=present,priorities=2) %>% 
  add_row(labels="McKena Wilson",starts="2024/09/16",ends=present,priorities=3) %>% 
  add_row(labels="Blake Wilson",starts="2024/09/16",ends=present,priorities=2) %>% 
  add_row(labels="Landen Lloyd",starts="2025/06/09",ends="2025/07/18",priorities=6) %>% 
  add_row(labels="Reagan Mitton",starts="2025/06/09",ends="2025/07/18",priorities=6) %>% 
  add_row(labels="Rufus Brown",starts="2025/06/09",ends="2025/07/18",priorities=6) %>% 
  add_row(labels="Veronda Blue",starts="2025/06/30",ends=present,priorities=4)


gantt.info <- list(labels=gantt.df$labels,
                 starts=as.POSIXct(strptime(gantt.df$starts, format=Ymd.format)),
                 ends=as.POSIXct(strptime(gantt.df$ends, format=Ymd.format)),
                 priorities=gantt.df$priorities)

#Assign values for the set up of your Gantt Chart

years <- seq(as.Date("2022/06/01", "%Y/%m/%d"), by="year", length.out=35)
yearsLab <- format(years, format="%Y %b")

vgridpos<-as.POSIXct(years,format=Ymd.format)
vgridlab<-yearsLab

colfunc <- colorRampPalette(c("#762a83","#af8dc3","#e7d4e8","#1b7837","#7fbf7b","#d9f0d3"))
timeframe <- as.POSIXct(c("2022/05/31",present),format=Ymd.format)

#Plot and save your Gantt chart into PDF form

png("rifelab-gantt.png", width=300, height=300/1.5, units="mm", res=300,pointsize = 14)

gantt.chart(gantt.info, taskcolors=colfunc(6),xlim=timeframe, main="Rife Lab (est. 2022)", priority.legend=FALSE, 
            vgridpos=vgridpos,vgridlab=vgridlab,hgrid=FALSE,half.height=0.45,cylindrical=FALSE,border.col="black",
            label.cex=0.8,priority.label="Type",priority.extremes=c("PI","Undergrad"),time.axis=1)

legend("bottomleft",c("PI","Staff Scientist","Postdoc","PhD","MSc","Undergrad/HS"),fill = colfunc(6),inset = .1)

dev.off()
