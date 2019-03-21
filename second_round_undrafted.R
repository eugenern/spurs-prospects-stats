library(magick)
fig <- image_graph(width = 1920, height = 1080, res = 96)

# incomplete stats; will need updating
cm.stats <-
    c(18.5, 7.5, 15.4, 0.2, 1.1, 3.3, 5, 2.1, 7.7, 9.8, 2.8, 0.9, 2, 3.9, 3.1)
cm.shooting <- c(48.6, 20, 66.3, 52.5)
jb.stats <-
    c(20.1,
      8.6,
      15.8,
      0.5,
      1.8,
      2.3,
      2.9,
      2.9,
      7.1,
      9.9,
      1.7,
      0.9,
      0.6,
      1.7,
      2.2)
jb.shooting <- c(54.5, 30.1, 78.5, 58.7)
bf.stats <-
    c(23.8,
      8.4,
      16.8,
      3,
      6.5,
      3.9,
      4.5,
      0.4,
      3.2,
      3.5,
      2.7,
      1.3,
      0.1,
      2.5,
      2.3)
bf.shooting <- c(50.2, 45.9, 86.9, 63.2)

player.names <-
    c(
        'Chimezie Metu - F\nAge: 21 GP: 24 MPG: 27.7',
        'Jaron Blossomgame - F\nAge: 24 GP: 50 MPG: 29.6',
        'Bryn Forbes - G\nAge: 23 GP: 19 MPG: 35.5'
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
        rbind(cm.stats, jb.stats, bf.stats),
        ncol = 15,
        dimnames = list(player.names, stats.names)
    )
shooting.matrix <-
    matrix(
        rbind(cm.shooting, jb.shooting, bf.shooting),
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
        ylim = c(0, 25),
        main = paste0('Spurs Second Round Draft Picks/Undrafted Players\n',
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
cm <- image_read('https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/1629002.png')
cm <- image_scale(cm, 'x65')
jb <- image_read('https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/1628417.png')
jb <- image_scale(jb, 'x65')
bf <- image_read('https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/1627854.png')
bf <- image_scale(bf, 'x65')
out <- image_composite(fig, cm, offset = '+833+84')
out <- image_composite(out, jb, offset = '+834+157')
out <- image_composite(out, bf, offset = '+835+229')

image_write(out, path = 'second_round_undrafted.png', format = 'png')