# build stage
FROM golang:1.22 AS builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN go build -o app cmd/api/main.go

# run stage
FROM alpine:3.19

WORKDIR /app
COPY --from=builder /app/app .

CMD ["./app"]