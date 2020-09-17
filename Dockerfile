FROM crystallang/crystal:0.35.1-alpine as builder

# unzip & curl to download pup
RUN apk add -u --no-cache unzip curl

WORKDIR /src

# download pup
RUN curl -sOL https://github.com/ericchiang/pup/releases/download/v0.4.0/pup_v0.4.0_linux_amd64.zip && unzip pup_v0.4.0_linux_amd64.zip && rm pup_v0.4.0_linux_amd64.zip


COPY shard.* ./
RUN shards install

COPY src src
RUN crystal build --release --static src/server.cr -o /src/server

FROM alpine:3.10.1
RUN apk add -u --no-cache curl jq
COPY tools /usr/local/bin/
COPY --from=builder /src/pup /usr/local/bin/pup
WORKDIR /app
COPY --from=builder /src/server /app/
ENTRYPOINT ["./server"]
