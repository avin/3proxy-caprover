FROM alpine:3.5
MAINTAINER Avin Lambrero <avin.github@gmail.com>

# Install base packages
RUN apk update && apk add git build-base linux-headers

# Download 3proxy 0.8.8 
RUN mkdir /usr/src -p
WORKDIR /usr/src
RUN git clone https://github.com/z3APA3A/3proxy.git
WORKDIR /usr/src/3proxy
RUN git checkout tags/3proxy-0.8.8

# Compile and install 3proxy
RUN make -f Makefile.Linux && \
    make -f Makefile.Linux install

# Define default ARG values
ARG LOGIN=${LOGIN}
ARG PASSWORD=${PASSWORD}
ARG PORT=3128

# Install  and setup config file
ADD 3proxy.cfg /usr/local/etc/3proxy/
WORKDIR /usr/local/etc/3proxy/
RUN sed -i 's/_LOGIN_/'"$LOGIN"'/g' 3proxy.cfg && \
    sed -i 's/_PASSWORD_/'"$PASSWORD"'/g' 3proxy.cfg && \
    sed -i 's/_PORT_/'"$PORT"'/g' 3proxy.cfg

EXPOSE $PORT

CMD 3proxy /usr/local/etc/3proxy/3proxy.cfg