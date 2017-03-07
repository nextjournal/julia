FROM julia:0.5.1

RUN apt-get update && apt-get install -y bash curl git coreutils unzip build-essential cmake

RUN julia -ie 'Pkg.clone("https://github.com/nextjournal/PlotlyJS.jl.git");  Pkg.checkout("PlotlyJS", "nj0.5.2");  using PlotlyJS'
RUN julia -ie 'Pkg.add("DataFrames", v"0.8.5"); using DataFrames'
