FROM golang:1.9

RUN export GOPATH="/go" && \
    mkdir /go/src/review-app/ && \
    go get gopkg.in/macaron.v1 && \
    go get gopkg.in/mgo.v2

ADD . /go/src/review-app/

EXPOSE 4001

WORKDIR /go/src/review-app/app

RUN go build /go/src/review-app/app/main.go

ENTRYPOINT ["./main"]
