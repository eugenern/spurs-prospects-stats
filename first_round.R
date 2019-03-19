library(magick)
fig <- image_graph(width = 1920, height = 1080, res = 96)

# incomplete stats; will need updating
lw.stats <-
    c(21.5,
      8.7,
      20.2,
      1.4,
      4.1,
      2.8,
      3.4,
      0.9,
      3,
      3.9,
      2.4,
      1.6,
      0.6,
      1.9,
      2.5)
lw.shooting <- c(42.9, 33.3, 80.6, 49.5)
dw.stats <-
    c(25.7,
      9.2,
      20.3,
      2.6,
      7.7,
      4.7,
      5.4,
      1.6,
      4.7,
      6.3,
      4.5,
      1.7,
      1.4,
      3.1,
      2.1)
dw.shooting <- c(45.3, 33.1, 87.3, 56.6)
dm.stats <-
    c(17.6, 7, 15.9, 0.5, 3.1, 3.1, 4.4, 1.3, 6.8, 8.1, 6.4, 2, 0.1, 5.1, 2.9)
dm.shooting <- c(44.2, 15.6, 70.3, 49.4)

player.names <-
    c(
        'Lonnie Walker IV - G\nAge: 20 GP: 26 MPG: 27.2',
        'Derrick White - G\nAge: 23 GP: 24 MPG: 28.2',
        'Dejounte Murray - G\nAge: 20 GP: 15 MPG: 35.1'
    )
stats.names <-
    c(
        'PTS',
        'FGM',
        'FGA',
        '3PM',
        '3PA',
        'FTM',
        'FTA',
        'OREB',
        'DREB',
        'REB',
        'AST',
        'STL',
        'BLK',
        'TOV',
        'PF'
    )
shooting.names <- c('FG%', '3P%', 'FT%', 'TS%')

# i don't know what's the best way to create the barplot; this seems to work
stats.matrix <-
    matrix(
        rbind(lw.stats, dw.stats, dm.stats),
        ncol = 15,
        dimnames = list(player.names, stats.names)
    )
shooting.matrix <-
    matrix(
        rbind(lw.shooting, dw.shooting, dm.shooting),
        ncol = 4,
        dimnames = list(player.names, shooting.names)
    )
dummy.matrix <- matrix(c(NA, NA, NA))
# before combining stats with shooting, downscale shooting values by 4
m <- cbind(stats.matrix, dummy.matrix, shooting.matrix / 4)
par(mar = c(4.1, 4.1, 4.1, 4.1))
bp <-
    barplot(
        m,
        beside = TRUE,
        col = c('#00B2A9', '#EF426F', '#FF8200'),
        legend = player.names,
        args.legend = list(
            x = 'top',
            bty = 'n',
            x.intersp = 7,
            y.intersp = 3,
            border = NA
        ),
        main = paste0('Spurs First Round Draft Picks\n',
                      'G League Stats Per 36 Minutes ',
                      'In First Season With Austin'),
        border = NA,
        space = c(0, 0.5)
    )

# create the other y-axis
axis(side = 4,
     at = (0:5 * 5),
     labels = (0:5 * 20))

# add the exact values on the plot
actual.m <- cbind(stats.matrix, dummy.matrix, shooting.matrix)
text(
    x = bp,
    y = m,
    labels = actual.m,
    pos = 3,
    cex = 0.7,
    xpd = NA
)

dev.off()
lw <- image_read('https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/1629022.png')
lw <- image_scale(lw, 'x65')
dw <- image_read('https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/1628401.png')
dw <- image_scale(dw, 'x65')
dm <- image_read('https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/1627749.png')
dm <- image_scale(dm, 'x65')
out <- image_composite(fig, lw, offset = '+833+84')
out <- image_composite(out, dw, offset = '+831+157')
out <- image_composite(out, dm, offset = '+834+229')