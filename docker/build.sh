#!/bin/sh -e

echo "APT::Install-Recommends              false;" >> /etc/apt/apt.conf.d/recommends.conf
echo "APT::Install-Suggests                false;" >> /etc/apt/apt.conf.d/recommends.conf
echo "APT::AutoRemove::RecommendsImportant false;" >> /etc/apt/apt.conf.d/recommends.conf
echo "APT::AutoRemove::SuggestsImportant   false;" >> /etc/apt/apt.conf.d/recommends.conf

apt-get update
apt-get install -y collectd git curl ca-certificates

go get github.com/docker-infra/reefer
go get github.com/tools/godep

cd /go/src/github.com/bobrik/collectd-docker
godep restore
go build -o /usr/bin/collectd-docker-collector

cp /go/bin/reefer /usr/bin/reefer
cp /go/src/github.com/bobrik/collectd-docker/docker/collectd.conf.tpl /etc/collectd/collectd.conf.tpl
cp /go/src/github.com/bobrik/collectd-docker/docker/run.sh /run.sh

apt-get remove -y git curl ca-certificates
apt-get autoremove -y

rm -rf /go /usr/local/go /var/lib/apt/lists /var/cache/apt
