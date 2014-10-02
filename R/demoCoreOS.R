library("analogsea")

fname <- "user_data.txt"
contents <- readChar(fname, file.info(fname)$size)

droplet_new(region = "ams3", ssh_keys = c(313661),image=6373176,
            user_data=contents)
