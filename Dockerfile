FROM julia:0.5.1

RUN apt-get update && apt-get install -y bash curl git coreutils unzip build-essential cmake lsb-release libx11-dev libxt-dev libxft-dev libgl1-mesa-dev

RUN julia -e 'Pkg.add("DataFrames"); using DataFrames'
RUN julia -e 'Pkg.add("Optim")'
RUN julia -e 'Pkg.add("DifferentialEquations")'
RUN julia -e 'Pkg.add("Calculus")'
RUN julia -e 'Pkg.add("Distributions")'
RUN julia -e 'Pkg.add("HypothesisTests")'
RUN julia -e 'Pkg.add("GLM")'
RUN julia -e 'Pkg.add("WAV")'
RUN julia -e 'Pkg.add("Plots", v"0.11.2")'
RUN julia -e 'Pkg.add("GR")'
RUN julia -e 'Pkg.add("Feather")'

RUN julia -e 'for pkg in keys(Pkg.installed()); try info("Compiling: $pkg"); eval(Expr(:toplevel, Expr(:using, Symbol(pkg)))); catch err warn("Unable to precompile: $pkg"); warn(err); end end'
