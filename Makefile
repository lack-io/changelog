NAME=$(shell echo "changelog")
GIT_COMMIT=$(shell git rev-parse --short HEAD)
GIT_TAG=$(shell git describe --abbrev=0 --tags --always --match "v*")
CGO_ENABLED=0
BUILD_DATE=$(shell date +%s)

all: build-linux-amd64

vendor:
	go mod vendor

lint:
	golint -set_exit_status ./..

changelog:
	mkdir -p _output
	changelog --last --output _output/CHANGELOG.md

build-windows:
	mkdir -p _output
	GOOS=windows GOARCH=amd64 go build -a -installsuffix cgo -ldflags "-s -w" -o _output/$(NAME)-windows-amd64-$(GIT_TAG).exe

build-linux-amd64:
	mkdir -p _output
	GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -ldflags "-s -w" -o _output/$(NAME)-linux-amd64-$(GIT_TAG)

build-linux-arm64:
	mkdir -p _output
	GOOS=linux GOARCH=arm64 go build -a -installsuffix cgo -ldflags "-s -w" -o _output/$(NAME)-linux-arm64-$(GIT_TAG)

build-darwin-amd64:
	mkdir -p _output
	GOOS=darwin GOARCH=amd64 go build -a -installsuffix cgo -ldflags "-s -w" -o _output/$(NAME)-darwin-amd64-$(GIT_TAG)

build-darwin-arm64:
	mkdir -p _output
	GOOS=darwin GOARCH=arm64 go build -a -installsuffix cgo -ldflags "-s -w" -o _output/$(NAME)-darwin-arm64-$(GIT_TAG)

release: changelog build-windows build-linux-amd64 build-linux-arm64 build-darwin-amd64 build-darwin-arm64

clean:
	rm -rf ./vine
	rm -fr ./_output

.PHONY: changelog build-windows build-linux-amd64 build-linux-arm64 build-darwin-amd64 build-darwin-arm64 release clean
