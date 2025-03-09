# https://medium.com/@chemidy/create-the-smallest-and-secured-golang-docker-image-based-on-scratch-4752223b7324

# IMAGE 1: Builder
FROM golang:1.24.1-alpine3.21 as builder

# pre-reqs
RUN apk add --no-cache git

# copy in src
WORKDIR $GOPATH/src/tf-discord-webhook-proxy/
COPY * ./

# install dependencies
RUN go mod tidy

# build
RUN go build -o /proxy

# IMAGE 2: Runner
FROM alpine:latest

# copy binary
WORKDIR /app
COPY --from=builder /proxy .

# run
EXPOSE 8080
CMD /app/proxy
