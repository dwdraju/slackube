FROM golang:1.13-alpine as build

ARG APP_ENV
ENV APP_ENV production

WORKDIR /go/src/slackube
COPY . /go/src/slackube/

RUN apk add --no-cache git
RUN go get ./... && go build -o slackube

# Run stage
FROM alpine:3.11
COPY --from=build /go/bin/slackube /usr/local/bin/
CMD ["slackube"]
