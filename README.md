# HOOBS Alternative Container image

Alternative Container image for HOOBS.

Can be used as a drop-in replacement for the official image, using the latest version of HOOBS.

Can be used standalone or with docker-compose or kubernetes.

## Features

- Multi-arch (amd64, arm64) image (Runs on Windows, Linux, Mac, Raspberry Pi, etc.)

## Usage

### Simple Docker (Test use only)

```bash
docker run --rm --network host -p 8080:8080 -p 51826:51826 ghcr.io/junior/hoobs:4.2-beta2
```

Just for testing, will not persist any data.

### Docker Standalone

```bash
docker run --rm -d --name hoobs --network host -p 8080:8080 -p 51826:51826 -v /path/to/your/storage:/hoobs ghcr.io/junior/hoobs:4.2-beta2
```
