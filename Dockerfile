FROM golang:1.13-alpine as build

ARG APP_ENV
ENV APP_ENV production

WORKDIR /go
COPY app.go .

RUN apk add git && go build -o slackube

CMD if [ ${APP_ENV} != production ]; \
	then \
	go get github.com/pilu/fresh && \
	fresh; \
	fi

FROM golang:1.13-alpine 
COPY --from=build /go/slackube /usr/local/bin/
CMD ["slackube"]
