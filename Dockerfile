FROM crystallang/crystal:latest

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y curl unzip

RUN curl -sOL https://github.com/ericchiang/pup/releases/download/v0.4.0/pup_v0.4.0_linux_amd64.zip && unzip pup_v0.4.0_linux_amd64.zip && rm pup_v0.4.0_linux_amd64.zip && mv pup /usr/local/bin

ADD . /app
WORKDIR /app

RUN shards build --production

RUN crystal build --release src/server.cr

CMD ./server