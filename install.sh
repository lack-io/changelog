#!/usr/bin/env bash

name="changelog"
archi=`arch`
if [ "$archi" == "x86_64" ];then
  archi="amd64"
elif [ "$archi" == "i386" ];then
  archi="arm64"
fi

os=`uname | tr '[A-Z]' '[a-z]'`

gopath=`go env var GOPATH | grep "/"`
if [ "$gopath" == "" ];then
  gopath=`go env var GOROOT | grep "/"`
fi

package=`curl -s https://api.github.com/repos/lack-io/${name}/releases/latest | grep browser_download_url | grep ${os} | cut -d'"' -f4 | grep "${name}-${os}-${archi}"`

echo "install package: ${package}"
wget ${package} -O $gopath/bin/changelog
