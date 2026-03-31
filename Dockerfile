FROM golang:1.22 AS builder
WORKDIR /build
COPY next_task.go .
RUN go build -o next_task next_task.go

FROM python:3.12-slim
COPY --from=builder /build/next_task /root/next_task
COPY shutdown.sh /root/shutdown.sh
RUN chmod +x /root/next_task /root/shutdown.sh
WORKDIR /root
CMD ["tail", "-f", "/dev/null"]
