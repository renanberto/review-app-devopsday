FROM golang:1.9

RUN export GOPATH="/go" && \
    mkdir /go/src/review-app/ && \
    go get gopkg.in/macaron.v1

ADD . /go/src/review-app/

EXPOSE 4000

WORKDIR /go/src/review-app/app

ENTRYPOINT ["./main"]
