# 构建阶段
FROM rust:alpine AS builder
WORKDIR /app
RUN apk add --no-cache gcc musl-dev openssl-dev git
COPY . .
RUN cargo build --release

# 运行阶段（极小体积镜像）
FROM alpine:latest
WORKDIR /app
RUN apk add --no-cache ca-certificates tzdata
COPY --from=builder /app/target/release/easytier-core /app/easytier-core
ENTRYPOINT ["/app/easytier-core"]
