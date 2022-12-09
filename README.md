# WECC-and-NPCC-Electricity-Economic-Data
This repository includes relevent code and data for economic data on WECC and NPCC systems.

# Authors and Contact information
Qiwei Zhang (qzhang41@vols.utk.edu) and Fangxing Fran Li (fli6@utk.edu)  
Dept. of EECS & CURENT, The University of Tennessee - Knoxville

# How should this data set be used?
This data set would be of interest to you if you are doing electricity economic simulations, such as economic dispatch and LMP calculation. We provide a comprehensive economic data set for WECC and NPCC systems based on real-world grid operation data. Users can access the developed data set to perform . Users are also encouraged to use MATPOWER.  
The detailed description on the developed data can be found next. 


# Data Descriptions
Two root folders are created: the Source_Data contains all the source files used to generate the data set; and the WECC_NPCC_Systems stores all the developed data set. Folders are organized by data type.
## Folder: Source_Data
Containing all the source files used to generate the data set. All soruce files used are based on year 2020
### Folder: Generator_fuel_generation_capacity
This folder contains  generations, fuel consumptions, and capacities for all of the generators in WECC and NPCC area. They are from EIA-860 and EIA-923 forms.
### Folder: Load
This folder contains hourly regional loads covering all WECC and NPCC area. They are from EIA Electric Grid Monitor.
### Folder: Power_flow_interchange
This folder contains hourly regional power flow interchange covering all WECC and NPCC area. They are from EIA Electric Grid Monitor.
### Folder: Wholesale price
This folder contains hourly wholesale elecitricity market price at WECC and NPCC areas. They are provided by EIA throguh Intercontinental Exchange（ICE）. The price at New York state is not covered by ICE, and thus it is from NYISO.

## Folder: WECC_NPCC_Systems  
Containing all the developed data set
### Folder: System_matpower_format
MATPOWER case files are built based on the developed data set for the NPCC and WECC systems. User can access the data set by loading the "npcc.m" and "wecc.m" case file with MATPOWER function 'loadcase()'
### Folder: Generator Aggregation  
This folder stores generator aggregation information for NPCC/WECC system. it provides a list of detailed real-world power plants that are aggregated to each bus in the NPCC/WECC system. The pie chart comparison between the real-world generation resource mix and aggregated resource mix is also provided at each state within NPCC/WECC area.
### Folder: Capacity
This file stores the capacity (megawatt) of aggregated generators in sheet 'NPCC and sheet 'WECC' for NPCC and WECC systems, respectively. The first column indicates the generator id.
### Folder: Line_rating
This file stores the line rating (megawatt) in sheet 'NPCC and sheet 'WECC' for NPCC and WECC systems, respectively. The line ID, from bus, and end bust are also indicated.
### Folder: Load
This file provides a year-round hourly load (megawatt) for each bus in NPCC and WECC systems, and it is stored in sheet 'NPCC and sheet 'WECC', respectively. The first column indicates the bus id, and the second line indicates the corresponding hour.
A '.mat' type load file is also provided for users' convenience on applying the load with MATPOWER on MATLAB.
### Folder: Cost
This file stores the cost (dollar) of aggregated generators in sheet 'NPCC and sheet 'WECC' for NPCC and WECC systems, respectively. The first column indicates the generator id. The second column is the incremental cost, and the third column is the fixed cost.
### Folder: System_Geographical_Coordinates
This file stores the bus coordinates in sheet 'NPCC and sheet 'WECC' for NPCC and WECC systems, respectively.
### Folder: Price
This file provides a year-round hourly electricity price (dollar) for each bus in NPCC and WECC systems, and it is stored in sheet 'NPCC and sheet 'WECC', respectively. The first column indicates the bus id, and the second line indicates the corresponding hour.
	File: NPCC_LMP.m and WECC_LMP.m
A '.mat' type load file is also provided for users' convenience on investigating the price on MATLAB.

# Codes Descriptions
## Folder: Cost_and_cap

# Lisence
This public data set is licensed under the GPL v3 License.
