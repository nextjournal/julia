FROM julia:0.5.1

RUN apt-get update && apt-get install -y bash curl git coreutils unzip build-essential cmake lsb-release libx11-dev libxt-dev libxft-dev libgl1-mesa-dev

RUN julia -e 'Pkg.add("DataFrames"); using DataFrames'
RUN julia -e 'Pkg.add("SHA"); using SHA'
RUN julia -e 'Pkg.add("Plots")'
RUN julia -e 'Pkg.add("Optim")'
RUN julia -e 'Pkg.add("DifferentialEquations")'
RUN julia -e 'Pkg.add("Calculus")'
RUN julia -e 'Pkg.add("Distributions")'
RUN julia -e 'Pkg.add("HypothesisTests")'
RUN julia -e 'Pkg.add("GLM")'
RUN julia -e 'Pkg.add("WAV")'
RUN julia -e 'Pkg.add("GR")'

ARG PLOTLYJSJLTAG='a1846adfcf9b3ecf52a1ede7461d698983b808c4'

RUN julia -e 'Pkg.clone("https://github.com/nextjournal/PlotlyJS.jl.git")' && \
  PKG_DIR="$(julia -e 'print(Pkg.dir())')" && \
  cd "${PKG_DIR}/PlotlyJS" && \
  git checkout ${PLOTLYJSJLTAG} && \
  git checkout -b "${PLOTLYJSJLTAG}-branch" && \
  julia -e 'Pkg.checkout("PlotlyJS", ENV["PLOTLYJSJLTAG"] * "-branch", merge=false, pull=false)'

RUN julia -e 'for pkg in keys(Pkg.installed()); try info("Compiling: $pkg"); eval(Expr(:toplevel, Expr(:using, Symbol(pkg)))); catch err warn("Unable to precompile: $pkg"); warn(err); end end'
