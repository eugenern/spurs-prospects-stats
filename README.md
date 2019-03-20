# spurs-prospects-stats
R plots depicting the season stats per 36 of Spurs prospects in their first seasons in Austin

## Overview
These R files produce images of bar graphs displaying the box score stats (per 36 minutes) for the first season in Austin of players who have had a contract with the San Antonio Spurs and have played a significant number of games in a season with the Spurs' G League affiliate, the Austin Spurs, since the 2016-17 season.

There are three graphs, one for each of the following groupings:
* the San Antonio Spurs' past three first round draft picks—Lonnie Walker IV (2018), Derrick White (2017), and Dejounte Murray (2016).
* the Spurs' past two second round draft picks—Chimezie Metu (2018) and Jaron Blossomgame (2017)—and Bryn Forbes, who signed with the Spurs as an undrafted free agent in the summer of 2016.
* the Spurs' players on two-way contracts—Drew Eubanks (2018), Ben Moore (2018), Darrun Hilliard (2017), and Matt Costello (2017). Two-way contracts were introduced to the NBA in the summer of 2017, and NBA teams may sign up to two players to a two-way contract per season.

## Notes
* These R files use the [magick](https://cran.r-project.org/package=magick) package to retrieve images of the players, add them to images of the bar graphs, and export the resulting images to files. Before running the files, make sure magick is installed.
  * I used ImageMagick because it's the first package I found to meet my rather simple image-processing needs. I have no idea which is the better software between ImageMagick and GraphicsMagick.
* The numbers in these graphs are all hardcoded and have had to be updated manually.
