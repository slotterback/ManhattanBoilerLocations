#download url:http://www1.nyc.gov/assets/planning/download/zip/data-maps/open-data/nyc_pluto_15v1.zip
PLUTO_MANHATTAN = read.csv("C:/DataIncubator/nyc_pluto_15v1/Mn.csv",header = TRUE)
#download url: https://data.cityofnewyork.us/api/views/f4rp-2kvy/rows.csv?accessType=DOWNLOAD
CATS = read.csv("C:/DataIncubator/CATS_PErmits.csv",header = TRUE)

Manhattan_Boiler_BBL <- CATS[  (CATS$Borough == "MANHATTAN" | CATS$Borough == "1")
                            & (CATS$PrimaryFuel == "NATURALGAS" | CATS$SecondaryFuel == "NATURAL GAS")
                            , c("Block","Lot","Quantity") ]

Manhattan_Boiler_BBL$x <- rep(0,nrow(Manhattan_Boiler_BBL))
Manhattan_Boiler_BBL$y <- rep(0,nrow(Manhattan_Boiler_BBL))

for(i in 1:nrow(Manhattan_Boiler_BBL)){
  Manhattan_Boiler_BBL$x[i] = PLUTO_MANHATTAN$XCoord[
                                      PLUTO_MANHATTAN$Block == Manhattan_Boiler_BBL$Block[i]
                                    & PLUTO_MANHATTAN$Lot   == Manhattan_Boiler_BBL$Lot[i]  ][1]
  Manhattan_Boiler_BBL$y[i] = PLUTO_MANHATTAN$YCoord[
                                      PLUTO_MANHATTAN$Block == Manhattan_Boiler_BBL$Block[i]
                                    & PLUTO_MANHATTAN$Lot   == Manhattan_Boiler_BBL$Lot[i]  ][1]}

a <- ggplot(Manhattan_Boiler_BBL, aes(x = x, y = y)) + geom_point() 
print(a)
b <- ggplot(Manhattan_Boiler_BBL, aes(x = x, y = y)) + geom_density2d() 
print(b)