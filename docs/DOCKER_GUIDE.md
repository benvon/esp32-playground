# Docker Development Environment

This guide explains how to use Docker for ESP32 and Raspberry Pi Pico development.

## Why Use Docker?

Docker provides:
- Consistent development environment across all platforms
- No need to install toolchains locally
- Isolated dependencies
- Easy cleanup and updates
- Works on Linux, macOS, and Windows

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Quick Start

### Combined Environment (ESP32 + Pico)

```bash
# Build and start the container
docker-compose up -d dev

# Enter the container
docker-compose exec dev bash

# Inside the container, both ESP-IDF and Pico SDK are ready to use
```

### ESP32-Only Environment

```bash
# Build and start ESP32 container
docker-compose up -d esp32

# Enter the container
docker-compose exec esp32 bash

# ESP-IDF is ready to use
```

### Pico-Only Environment

```bash
# Build and start Pico container
docker-compose up -d pico

# Enter the container
docker-compose exec pico bash

# Pico SDK is ready to use
```

## Building Images

### Build all images
```bash
docker-compose build
```

### Build specific image
```bash
docker-compose build esp32
docker-compose build pico
docker-compose build dev
```

## Usage Examples

### ESP32 Project

```bash
# Start container
docker-compose up -d esp32
docker-compose exec esp32 bash

# Inside container
cd esp32/your-project
idf.py build
idf.py -p /dev/ttyUSB0 flash monitor
```

### Pico Project

```bash
# Start container
docker-compose up -d pico
docker-compose exec pico bash

# Inside container
cd pico/your-project
mkdir build && cd build
cmake ..
make -j4
```

## Device Access

### Linux

The docker-compose.yml file includes device mappings. Adjust them based on your setup:

```yaml
devices:
  - /dev/ttyUSB0:/dev/ttyUSB0  # ESP32
  - /dev/ttyACM0:/dev/ttyACM0  # Pico
```

Find your devices:
```bash
ls /dev/tty*
```

### macOS

Docker Desktop on macOS doesn't support direct USB device passthrough. You have two options:

1. Use a Linux VM with USB passthrough
2. Flash from the host machine and use Docker only for building

### Windows

Docker Desktop on Windows with WSL2:

1. Ensure USB passthrough is configured in WSL2
2. Use the Windows device path in docker-compose.yml

## Volume Mounts

The containers mount your project directories:

- Combined: Entire repository → `/workspace`
- ESP32: `./esp32` → `/workspace/esp32`
- Pico: `./pico` → `/workspace/pico`

Changes in the container are reflected on your host and vice versa.

## Persistent Storage

ESP-IDF tools are stored in a named volume `esp-idf-tools` to avoid re-downloading on each build.

## Stopping Containers

```bash
# Stop specific container
docker-compose stop esp32
docker-compose stop pico
docker-compose stop dev

# Stop all containers
docker-compose down

# Stop and remove volumes
docker-compose down -v
```

## Troubleshooting

### Permission Denied for Serial Ports

On Linux, add your user to the `dialout` group:
```bash
sudo usermod -a -G dialout $USER
```

Then restart Docker:
```bash
sudo systemctl restart docker
```

### Container Can't Access Device

1. Check if device is connected: `ls /dev/tty*`
2. Ensure device path in docker-compose.yml matches your system
3. Verify privileged mode is enabled in docker-compose.yml

### Slow Build Times

1. Ensure Docker has enough resources (CPU, RAM)
2. Use BuildKit for faster builds:
   ```bash
   DOCKER_BUILDKIT=1 docker-compose build
   ```

### Image Size

The combined image is large (~4GB) as it includes both ESP-IDF and Pico SDK. Use specific images if space is a concern:
- `esp32-dev`: ~2GB
- `pico-dev`: ~1GB

## Advanced Usage

### Custom Dockerfile Stages

You can build specific stages:

```bash
# Build only ESP32 stage
docker build --target esp32-dev -t esp32-env .

# Build only Pico stage
docker build --target pico-dev -t pico-env .
```

### Running Commands Directly

```bash
# Build ESP32 project without entering container
docker-compose run --rm esp32 bash -c "cd esp32/project && idf.py build"

# Build Pico project without entering container
docker-compose run --rm pico bash -c "cd pico/project && mkdir build && cd build && cmake .. && make"
```

### Using with VS Code

Install the "Remote - Containers" extension and open the folder in a container for full IDE support.

1. Install "Dev Containers" extension
2. Open Command Palette (Ctrl+Shift+P)
3. Select "Dev Containers: Reopen in Container"
4. Choose the appropriate container

## Updating Toolchains

### Update ESP-IDF
```bash
docker-compose exec esp32 bash
cd $IDF_PATH
git pull
git submodule update --init --recursive
./install.sh esp32
```

### Update Pico SDK
```bash
docker-compose exec pico bash
cd $PICO_SDK_PATH
git pull
git submodule update --init
```

Then rebuild the Docker image:
```bash
docker-compose build --no-cache
```
