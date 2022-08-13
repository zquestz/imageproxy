# Start from a Debian image with the latest version of Go installed
# and a workspace (GOPATH) configured at /go.
FROM golang:1.19
LABEL maintainer="Josh Ellithorpe <quest@mac.com>"

# Install webp dev libs.
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y libwebp-dev

# Copy the local package files to the container's workspace.
ADD . /go/src/github.com/zquestz/imageproxy

# Switch to the correct working directory.
WORKDIR /go/src/github.com/zquestz/imageproxy

# Build the code.
RUN go install -v ./cmd/imageproxy

# Set the start command.
CMD ["-addr", "0.0.0.0:8080"]
ENTRYPOINT ["/go/bin/imageproxy"]

EXPOSE 8080
