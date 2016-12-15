FROM julia:0.5.0

RUN apt-get update && apt-get install -y bash curl git coreutils unzip build-essential cmake

RUN julia -ie 'Pkg.clone("https://github.com/nextjournal/PlotlyJS.jl.git"); using PlotlyJS'
RUN julia -ie 'Pkg.add("Distributions", v"0.11.1"); using Distributions'
RUN julia -ie 'Pkg.add("Requests", v"0.3.11"); using Requests'
RUN julia -ie 'Pkg.add("DataFrames", v"0.8.5"); using DataFrames'
