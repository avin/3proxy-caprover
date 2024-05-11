FROM alpine:3.5

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

ENV LOGIN=$LOGIN
ENV PASSWORD=$PASSWORD
ENV PORT=$PORT

# Install  and setup config file
ADD 3proxy.cfg /usr/local/etc/3proxy/
ADD entrypoint.sh /entrypoint.sh

WORKDIR /usr/local/etc/3proxy/

CMD ["/entrypoint.sh"]