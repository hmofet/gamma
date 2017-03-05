#!/usr/bin/Rscript

# Needs R library: ggplot2
# Needs ffmpeg and libx264 video codec
# Run with ./Rdemo [Muse_csv_data] [video_output]
# Muse csv data should be six columns: user, sensorA, sensorB, sensorC, sensorD, timestamp

args <- commandArgs(trailingOnly = TRUE)
infile <- args[1]
outmovie <- args[2]

library(ggplot2)

df <- read.csv(infile, header=FALSE)
colnames(df) <- c("user", "A", "B", "C", "D", "time")

dfs <- subset(df, !is.na(df$A) & !is.na(df$B))

tmpdir <- "/tmp/Rdemo"
dir.create(tmpdir)
num_points <- dim(dfs)[1]
prog <- round(100*0/num_points)
i <- 1
for (j in 1:num_points) {
  if ((j %% 20) == 0) {
    imgfile <- paste("frame-", sprintf("%05d", i), ".png", sep="")
    outimg <- paste(tmpdir, imgfile, sep="/")
    plt <- ggplot(dfs[1:j,], aes(x=A, y=B)) + geom_path() 
    plt <- plt + theme_bw()
    plt <- plt + xlim(0, max(dfs$A)) + ylim(0, max(dfs$B))
    plt <- plt + coord_equal() 
    plt <- plt + xlab("Sensor 1") + ylab("Sensor 2")
    png(outimg, width = 400, height=400)
    print(plt)
    dev.off()
    i <- i + 1
  }
  newprog <- round(100*j/num_points)
  if (newprog != prog) {
    prog <- newprog
    print(paste("Done ", prog, "%", sep=""))
  }
}
frames <- paste(tmpdir, "frame-%05d.png", sep="/")
cmd <- paste("ffmpeg -r 10 -s 400x400 -i", frames, "-vcodec libx264 -crf 25  -pix_fmt yuv420p", outmovie)
system(cmd)
unlink(tmpdir, recursive = TRUE)





#max(df$time) - min(df$time)

# Windowed connectivity / correlation over time
# Peak frequency and amplitude