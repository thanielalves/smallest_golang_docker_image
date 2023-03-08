#Step 1 - Create binary go
FROM golang:alpine AS builder

WORKDIR /app

COPY go.mod .
COPY go.sum .
RUN go mod download

COPY *.go ./

#Removing debug informations and compile only for linux target and disabling cross compilation
RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /fullcycle_rocks

#Step 2 - Create small image
FROM scratch

WORKDIR /

# Copy static executable.
COPY --from=builder /fullcycle_rocks /fullcycle_rocks

# Run the binary.
ENTRYPOINT ["/fullcycle_rocks"]

