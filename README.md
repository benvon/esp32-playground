# ESP32 and Raspberry Pi Pico Development Environment

A comprehensive development environment for working with ESP32 and Raspberry Pi Pico microcontroller boards.

## Overview

This repository provides a pre-configured development environment for:
- **ESP32** - Using ESP-IDF framework
- **Raspberry Pi Pico (RP2040)** - Using Pico SDK

## Quick Start

### Prerequisites

Before you begin, ensure you have:
- Git
- CMake (3.13+)
- Python 3.8+
- A C/C++ compiler toolchain
- VS Code (recommended)

### Setup Instructions

**📋 New to this project? Start with the [Getting Started Checklist](GETTING_STARTED.md)!**

1. **Clone this repository:**
   ```bash
   git clone https://github.com/benvon/esp32-playground.git
   cd esp32-playground
   ```

2. **Choose your platform and follow the setup guide:**
   - [ESP32 Setup Guide](docs/ESP32_SETUP.md) - Complete ESP-IDF installation
   - [Pico Setup Guide](docs/PICO_SETUP.md) - Complete Pico SDK installation
   - [Docker Guide](docs/DOCKER_GUIDE.md) - Containerized development environment

3. **Open in VS Code:**
   ```bash
   code .
   ```
   
   VS Code will recommend installing helpful extensions. Accept the recommendations for the best development experience.

## Project Structure

```
esp32-playground/
├── esp32/              # ESP32 projects directory
│   └── README.md       # ESP32-specific guide
├── pico/               # Raspberry Pi Pico projects directory
│   └── README.md       # Pico-specific guide
├── docs/               # Documentation
│   ├── ESP32_SETUP.md  # Detailed ESP32 setup
│   └── PICO_SETUP.md   # Detailed Pico setup
└── .vscode/            # VS Code configuration
    ├── settings.json   # Editor settings
    ├── tasks.json      # Build tasks
    ├── launch.json     # Debug configurations
    └── extensions.json # Recommended extensions
```

## Development Workflow

### For ESP32 Projects

1. Source the ESP-IDF environment:
   ```bash
   . ~/esp/esp-idf/export.sh
   ```

2. Navigate to your project:
   ```bash
   cd esp32/your-project
   ```

3. Build, flash, and monitor:
   ```bash
   idf.py build
   idf.py -p /dev/ttyUSB0 flash monitor
   ```

### For Pico Projects

1. Ensure PICO_SDK_PATH is set:
   ```bash
   export PICO_SDK_PATH=~/pico/pico-sdk
   ```

2. Navigate to your project:
   ```bash
   cd pico/your-project
   ```

3. Build and flash:
   ```bash
   mkdir build && cd build
   cmake ..
   make -j4
   # Hold BOOTSEL and copy .uf2 to RPI-RP2 drive
   ```

## VS Code Features

This environment includes:
- **IntelliSense** - Code completion for ESP-IDF and Pico SDK
- **Build Tasks** - Quick build commands (Ctrl+Shift+B)
- **Debug Configurations** - Hardware debugging support
- **Extensions** - Recommended tools for embedded development

## Documentation

- **[Getting Started Checklist](GETTING_STARTED.md)** - Step-by-step setup checklist
- **[Quick Reference Guide](docs/QUICK_REFERENCE.md)** - Common commands and workflows
- [ESP32 Setup Guide](docs/ESP32_SETUP.md) - ESP-IDF installation and usage
- [Pico Setup Guide](docs/PICO_SETUP.md) - Pico SDK installation and usage
- [Docker Guide](docs/DOCKER_GUIDE.md) - Containerized development environment
- [ESP32 Projects README](esp32/README.md) - ESP32 project guidelines
- [Pico Projects README](pico/README.md) - Pico project guidelines
- [Contributing Guide](CONTRIBUTING.md) - How to contribute to this project

## Resources

### ESP32
- [ESP-IDF Programming Guide](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/)
- [ESP32 Examples](https://github.com/espressif/esp-idf/tree/master/examples)
- [ESP32 Technical Reference](https://www.espressif.com/sites/default/files/documentation/esp32_technical_reference_manual_en.pdf)

### Raspberry Pi Pico
- [Pico Getting Started](https://datasheets.raspberrypi.com/pico/getting-started-with-pico.pdf)
- [Pico SDK Documentation](https://raspberrypi.github.io/pico-sdk-doxygen/)
- [Pico Examples](https://github.com/raspberrypi/pico-examples)

## Contributing

Feel free to add your own projects to the `esp32/` or `pico/` directories!

## License

See [LICENSE](LICENSE) file for details.
