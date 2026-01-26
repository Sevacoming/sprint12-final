# build stage
FROM golang:1.24.6 AS builder
WORKDIR /app

# на всякий случай для go mod download через VCS
RUN apt-get update && apt-get install -y --no-install-recommends git ca-certificates \
  && rm -rf /var/lib/apt/lists/*

ENV GOPROXY=https://proxy.golang.org,direct
ENV GOSUMDB=sum.golang.org

COPY go.mod go.sum ./
RUN go mod download -x

COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app .

# runtime stage
FROM alpine:3.20
WORKDIR /app
COPY --from=builder /app/app ./app
CMD ["./app"]
