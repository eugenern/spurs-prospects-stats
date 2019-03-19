# spurs-prospects-stats
R plots depicting the season stats per 36 of Spurs prospects in their first seasons in Austin

## Overview
These R files produce images of bar graphs displaying the box score stats (per 36 minutes) for the first season in Austin of players who have had a contract with the San Antonio Spurs and have played a significant number of games in a season with the Spurs' G League affiliate, the Austin Spurs, since the 2016-17 season.

## Notes
* These R files use the [magick](https://cran.r-project.org/package=magick) package to retrieve images of the players, add them to images of the bar graphs, and export the resulting images to files. Before running these files, make sure magick is installed.
  * I used ImageMagick because it's the first package I found to meet my relatively light image-processing needs. I have no idea whether ImageMagick or GraphicsMagick is better.
* The numbers in these graphs are all hardcoded and have to be updated manually.
