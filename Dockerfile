FROM golang:1.13-alpine as build

ARG APP_ENV
ENV APP_ENV production

WORKDIR /go/src/slackube
COPY app.go /go/src/slackube/

RUN apk add git
RUN go get ./... && go build -o slackube

CMD if [ ${APP_ENV} != production ]; \
	then \
	go get github.com/pilu/fresh && \
	fresh; \
	fi

FROM golang:1.13-alpine 
COPY --from=build /go/src/slackube/slackube /usr/local/bin/
CMD ["slackube"]
