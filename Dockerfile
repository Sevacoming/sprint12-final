# build stage
FROM golang:1.22-alpine AS builder
WORKDIR /app

# нужен gcc для CGO (sqlite3)
RUN apk add --no-cache build-base

COPY go.mod go.sum ./
RUN go mod download

COPY . .

# CGO включаем (иначе sqlite драйвер может не собраться)
ENV CGO_ENABLED=1 GOOS=linux GOARCH=amd64
RUN go build -o app .

# runtime stage
FROM alpine:3.20
WORKDIR /app
COPY --from=builder /app/app ./app
CMD ["./app"]
