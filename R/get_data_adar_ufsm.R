# dados para as lições do curso adar@ufsm
download.file(url = "https://www.dropbox.com/s/rgswkzrszz1mvrl/data.tar.gz?dl=0"
             ,destfile =  "data/data.tar.gz"
             ,method = "wget")
untar(tarfile = "data/data.tar.gz", exdir = "data")

