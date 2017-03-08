FROM julia:0.5.1

RUN apt-get update && apt-get install -y bash curl git coreutils unzip build-essential cmake

RUN julia -e 'Pkg.add("DataFrames", v"0.8.5"); using DataFrames'
ARG PLOTLYJSJLTAG='a1846adfcf9b3ecf52a1ede7461d698983b808c4'

RUN julia -e 'Pkg.clone("https://github.com/nextjournal/PlotlyJS.jl.git")' && \
  PKG_DIR="$(julia -e 'print(Pkg.dir())')" && \
  cd "${PKG_DIR}/PlotlyJS" && \
  git checkout ${PLOTLYJSJLTAG} && \
  git checkout -b "${PLOTLYJSJLTAG}-branch" && \
  julia -e 'Pkg.checkout("PlotlyJS", ENV["PLOTLYJSJLTAG"] * "-branch", merge=false, pull=false)' && \
  julia -e 'using PlotlyJS'
