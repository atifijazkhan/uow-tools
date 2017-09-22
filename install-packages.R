dir.create('~/tools/downloads/R-packages', recursive = TRUE)

mirror <- "http://cran.utstat.utoronto.ca/"
target_dir <- "~/tools/downloads/R-packages/"


install.packages("rappdirs",     dependencies = TRUE, repos=mirror,  Ncpus=32, destdir=target_dir)
install.packages("config",     dependencies = TRUE, repos=mirror,  Ncpus=32, destdir=target_dir)
install.packages("svglite",     dependencies = TRUE, repos=mirror,  Ncpus=32, destdir=target_dir)
install.packages("gdtools",     dependencies = TRUE, repos=mirror,  Ncpus=32, destdir=target_dir)
install.packages("RMySQL",      dependencies = TRUE, repos=mirror,  Ncpus=32, destdir=target_dir  , configure.vars = "INCLUDE_DIR=/home/a78khan/tools/local/include/mysql LIB_DIR=/home/a78khan/tools/local/lib")
install.packages("gpuR",        dependencies = TRUE, repos=mirror,  Ncpus=32, destdir=target_dir)
install.packages("tm",          dependencies = TRUE, repos=mirror,  Ncpus=32, destdir=target_dir)
install.packages("wordcloud",   dependencies = TRUE, repos=mirror,  Ncpus=32, destdir=target_dir)
install.packages("ggplot2",     dependencies = TRUE, repos=mirror,  Ncpus=32, destdir=target_dir)
install.packages("twitteR",     dependencies = TRUE, repos=mirror,  Ncpus=32, destdir=target_dir)
install.packages("neuralnet",   dependencies = TRUE, repos=mirror,  Ncpus=32, destdir=target_dir)
install.packages("topicmodels", dependencies = TRUE, repos=mirror,  Ncpus=32, destdir=target_dir)
install.packages("/home/a78khan/tools/build/tesseract", repos=NULL,  Ncpus=32, destdir=target_dir)
install.packages("magick",      dependencies = TRUE, repos=mirror,  Ncpus=32, destdir=target_dir)
