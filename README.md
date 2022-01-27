# Local climate data extraction and visualization 

## Description

This repository shows how to request, download, process, and visualize local climate data from ERA5 database, using two localities at Catalonia (Spain) as an example.

## Steps for ERA5 data request (using the [CDS API](https://cds.climate.copernicus.eu/api-how-to))

This step requires that you have *python* installed on your computer (follow [this steps](https://www.datacamp.com/community/tutorials/installing-anaconda-windows) to install it via [Conda](https://www.anaconda.com/products/individual)).  

Following steps resume how to start the ERA5 data request, you can see a good explanation in [this video](https://www.youtube.com/watch?v=cVtiVTSVdlo&t=237s).  

1. Register in [Copernicus website](https://cds.climate.copernicus.eu/#!/home) to obtain access to the Climate Data Store (CDS).  

2. Create a local file with your user information:  

  * Open a text editor file and put the following lines:  
  
    url: https://cds.climate.copernicus.eu/api/v2  
    key: userID:api-key (you can find this information at the end of the page by clicking on your user-name on the Copernicus website).  
    
  * Rename the created file to ".cdsapirc." (for *Windows*: the file must be in C:\Users\'your_user')

3. Go to the Copernicus website and select the data of interest:  

  * Select the [search tab](https://cds.climate.copernicus.eu/cdsapp#!/search) and search for the data you want to download (**ERA5** in this example).  
  
  * Select the specific data set (*e.g.* 'ERA5-Land hourly data from 1950 to present').  
  
  * In the **Download data** tab, select the data you want to download.  
    
    - For this example I select **2m temperature** data from the Variable 'Temperature', and **Total precipitation** from the variable 'Wind, Pressure and Precipitation'.  
    
    - I also specified years from 2015 to 2020, all months and days, and time from 11 h to 13 h for the sub-region '43, 0, 41, 3'.
    
  * Click on 'Show API request' buttom at the end of the page, and copy the code.  
  
  * Open the Anaconda Navigator and then a Jupyter Notebook (there is different ways to do this step, see [this example](https://problemsolvingwithpython.com/02-Jupyter-Notebooks/02.04-Opening-a-Jupyter-Notebook/#:~:text=Open%20a%20Jupyter%20Notebook%20with%20Anaconda%20Navigator,-One%20additional%20way&text=Open%20Anaconda%20Navigator%20using%20the,%2D%2D%3E%20%5BAnaconda%20Navigator%5D.&text=A%20Jupyter%20file%20browser%20will%20open%20in%20a%20web%20browser%20tab.&text=%3E%20%5BPython%203%5D-,A%20new%20notebook%20will%20open%20as,tab%20in%20your%20web%20browser.)) 
  
  * Add this code at the begging of the jupyter notebook:  
  
    - conda install -c conda-forge cdsapi
  
  * Paste the code from the API request in the jupyter notebook and run the code. 
  
    - If your data request include several years and/or several variables, I recommend you to make a request by year/variable. In this tutorial I show ho to modify the code from the API request in order to do make a request by year and to print the status of the request.    

## Data processing in R

Once we have the downloaded files by year, we`ll proceed to read and extract the data for the locations of interest. 

## Data visualization

In order to describe each location`s climate data we can make a **Climatograph** by location.

