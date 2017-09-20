dir.create('~/tools/downloads/R-packages', recursive = TRUE)

install.packages("svglite", dependencies = TRUE, Ncpus=32, destdir="~/tools/downloads/R-packages/")
install.packages("gdtools", dependencies = TRUE, Ncpus=32, destdir="~/tools/downloads/R-packages/")
install.packages("RMySQL", dependencies = TRUE, Ncpus=32, destdir="~/tools/downloads/R-packages/"  , configure.vars = "INCLUDE_DIR=/home/a78khan/tools/local/include LIB_DIR=/home/a78khan/tools/local/lib")
install.packages("RMySQL", dependencies = TRUE, Ncpus=32, destdir="~/tools/downloads/R-packages/"  , configure.vars = "INCLUDE_DIR=/home/a78khan/tools/local/include LIB_DIR=/home/a78khan/tools/local/lib")
install.packages("gpuR", dependencies = TRUE, Ncpus=32, destdir="~/tools/downloads/R-packages/")
install.packages("tm", dependencies = TRUE, Ncpus=32, destdir="~/tools/downloads/R-packages/")
install.packages("wordcloud", dependencies = TRUE, Ncpus=32, destdir="~/tools/downloads/R-packages/")
install.packages("ggplot2", dependencies = TRUE, Ncpus=32, destdir="~/tools/downloads/R-packages/")
install.packages("twitteR", dependencies = TRUE, Ncpus=32, destdir="~/tools/downloads/R-packages/")
install.packages("neuralnet", dependencies = TRUE, Ncpus=32, destdir="~/tools/downloads/R-packages/")
install.packages("topicmodels", dependencies = TRUE, Ncpus=32, destdir="~/tools/downloads/R-packages/")
install.packages("tesseract", dependencies = TRUE, Ncpus=32, destdir="~/tools/downloads/R-packages/")
install.packages("magick", dependencies = TRUE, Ncpus=32, destdir="~/tools/downloads/R-packages/")
install.packages("rgl", dependencies = TRUE, Ncpus=32, destdir="~/tools/downloads/R-packages/")