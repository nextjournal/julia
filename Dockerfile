FROM gliderlabs/alpine:edge

# add testing repository containing julia apk
RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

# install julia
RUN apk add --update julia@testing=0.4.6-r3 && \
    rm -rf /var/cache/apk/*

# install requirements to compile plotly
RUN apk add --update --virtual build-dependencies bash curl git coreutils unzip build-base cmake && \
    julia -ie 'Pkg.clone("https://github.com/nextjournal/PlotlyJS.jl.git"); using PlotlyJS' && \
    julia -ie 'Pkg.add("Distributions", v"0.11.1"); using Distributions' && \
    julia -ie 'Pkg.add("Requests", v"0.3.11"); using Requests' && \
    julia -ie 'Pkg.add("DataFrames", v"0.8.5"); using DataFrames' && \
    apk del build-dependencies && \
    rm -rf /var/cache/apk/*
