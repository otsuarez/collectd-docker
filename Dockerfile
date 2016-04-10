FROM golang:1.6

COPY . /go/src/github.com/bobrik/collectd-docker

RUN /go/src/github.com/bobrik/collectd-docker/docker/build.sh

CMD ["/run.sh"]
