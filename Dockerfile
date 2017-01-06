FROM alpine:3.5

# add testing repository containing julia apk
RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

# install julia
RUN apk update \
		&& apk add julia@testing=0.4.6-r3 \
	  && rm -rf /var/cache/apk/*
# install requirements to compile plotly
RUN apk --update add bash curl git coreutils unzip build-base cmake \
		&& rm -rf /var/cache/apk/*

RUN julia -ie 'Pkg.clone("https://github.com/nextjournal/PlotlyJS.jl.git"); using PlotlyJS'
RUN julia -ie 'Pkg.add("Distributions", v"0.11.1"); using Distributions'
RUN julia -ie 'Pkg.add("Requests", v"0.3.11"); using Requests'
RUN julia -ie 'Pkg.add("DataFrames", v"0.8.5"); using DataFrames'
