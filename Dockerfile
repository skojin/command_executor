FROM alpine:latest as builder
RUN apk add -u crystal shards libc-dev zlib-dev openssl-dev libressl2.7-libcrypto
RUN apk add -u unzip curl
WORKDIR /src

# download pup
RUN curl -sOL https://github.com/ericchiang/pup/releases/download/v0.4.0/pup_v0.4.0_linux_amd64.zip && unzip pup_v0.4.0_linux_amd64.zip && rm pup_v0.4.0_linux_amd64.zip

COPY . .
RUN shards build --production
RUN crystal build --release --static src/server.cr -o /src/server

FROM alpine:latest
RUN apk add -u --no-cache curl
WORKDIR /app
COPY --from=builder /src/server /app/server
COPY --from=builder /src/pup /usr/local/bin/pup
ENTRYPOINT ["/app/server"]
