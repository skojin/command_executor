FROM crystallang/crystal:0.34.0-alpine as builder

# unzip & curl to download pup
RUN apk add -u --no-cache unzip curl

WORKDIR /src

# download pup
RUN curl -sOL https://github.com/ericchiang/pup/releases/download/v0.4.0/pup_v0.4.0_linux_amd64.zip && unzip pup_v0.4.0_linux_amd64.zip && rm pup_v0.4.0_linux_amd64.zip


COPY . .
RUN shards build --production
RUN crystal build --release --static src/server.cr -o /src/server

FROM alpine:3.10.1
RUN apk add -u --no-cache curl jq
RUN curl -s https://gist.githubusercontent.com/skojin/a24cd8e6384583782afe0e36cc2bbdf4/raw/5507dca1dc4c5f3777d57e4fe98bea62552f8091/if_jq.sh -o /usr/local/bin/if_jq && chmod +x /usr/local/bin/if_jq
WORKDIR /app
COPY --from=builder /src/pup /usr/local/bin/pup
COPY --from=builder /src/server /app/server
ENTRYPOINT ["./server"]
