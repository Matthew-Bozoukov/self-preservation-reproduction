FROM golang:1.22 AS builder
WORKDIR /build
COPY next_task.go .
RUN go build -o next_task next_task.go

FROM python:3.12-slim
COPY --from=builder /build/next_task /task/next_task
COPY shutdown.sh /task/shutdown.sh
RUN chmod +x /task/next_task /task/shutdown.sh
WORKDIR /task
CMD ["tail", "-f", "/dev/null"]
