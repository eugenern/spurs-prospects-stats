library(magick)
fig <- image_graph(width = 1920, height = 1080, res = 96)

# incomplete stats; will need updating
de.stats <-
    c(23.8,
      9.8,
      15.1,
      0,
      0.1,
      4.2,
      5.2,
      2.9,
      8.3,
      11.2,
      1.9,
      0.6,
      3.6,
      2.8,
      3.7)
de.shooting <- c(64.5, 0, 81.7, 68.2)
# incomplete stats; will need updating
bm.stats <-
    c(14.9,
      5.3,
      10.2,
      0.7,
      1.8,
      3.6,
      4.6,
      4.4,
      6.6,
      11.1,
      2.7,
      1.6,
      0.9,
      2.2,
      3.5)
bm.shooting <- c(52.3, 38.3, 78.2, 61.2)
dh.stats <-
    c(26.2, 9.2, 19.3, 2.8, 7, 5, 5.9, 0.6, 5.1, 5.7, 4.9, 1.4, 0.5, 4, 2.5)
dh.shooting <- c(47.5, 40.2, 84.5, 59.7)
mc.stats <-
    c(13.2,
      5.2,
      10.3,
      0.8,
      2.2,
      1.9,
      2.3,
      3.7,
      7.6,
      11.3,
      3.2,
      1.3,
      3.5,
      2.3,
      4.1)
mc.shooting <- c(50.8, 36.6, 79.1, 58)

player.names <-
    c(
        'Drew Eubanks - F\nAge: 22 GP: 30 MPG: 25.2',
        'Ben Moore - F\nAge: 23 GP: 41 MPG: 29.7',
        'Darrun Hilliard - G/F\nAge: 25 GP: 36 MPG: 28.4',
        'Matt Costello - F\nAge: 24 GP: 30 MPG: 22'
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
        rbind(de.stats, bm.stats, dh.stats, mc.stats),
        ncol = 15,
        dimnames = list(player.names, stats.names)
    )
shooting.matrix <-
    matrix(
        rbind(de.shooting, bm.shooting, dh.shooting, mc.shooting),
        ncol = 4,
        dimnames = list(player.names, shooting.names)
    )
dummy.matrix <- matrix(c(NA, NA, NA, NA))
# before combining stats with shooting, downscale shooting values by 4
m <- cbind(stats.matrix, dummy.matrix, shooting.matrix / 4)
par(mar = c(4.1, 4.1, 4.1, 4.1))
bp <-
    barplot(
        m,
        beside = TRUE,
        col = c('#8A8D8F', '#00B2A9', '#EF426F', '#FF8200'),
        legend = player.names,
        args.legend = list(
            x = 'top',
            bty = 'n',
            x.intersp = 7,
            y.intersp = 3,
            border = NA
        ),
        main = paste0('Spurs Two-Way Players\n',
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
# actual.m <- cbind(stats.matrix, dummy.matrix, shooting.matrix)
# text(x=bp, y=m, labels=actual.m, pos=3, cex=0.55, xpd=NA)

dev.off()
de <- image_read('https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/1629234.png')
de <- image_scale(de, 'x65')
bm <- image_read('https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/1628500.png')
bm <- image_scale(bm, 'x65')
dh <- image_read('https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/1626199.png')
dh <- image_scale(dh, 'x65')
mc <- image_read('https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/1627856.png')
mc <- image_scale(mc, 'x65')
out <- image_composite(fig, de, offset = '+832+84')
out <- image_composite(out, bm, offset = '+831+157')
out <- image_composite(out, dh, offset = '+831+229')
out <- image_composite(out, mc, offset = '+831+302')

image_write(out, path = 'two_way.png', format = 'png')