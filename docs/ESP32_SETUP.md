# ESP32 Development Environment Setup

This guide will help you set up your development environment for ESP32 microcontrollers.

## Prerequisites

- Python 3.8 or higher
- Git
- CMake (3.16 or higher)
- Ninja build system
- A C/C++ compiler (GCC on Linux/macOS, MSVC on Windows)

## Installation

### Linux / macOS

1. Install prerequisites:
   ```bash
   # Ubuntu/Debian
   sudo apt-get install git wget flex bison gperf python3 python3-pip python3-venv cmake ninja-build ccache libffi-dev libssl-dev dfu-util libusb-1.0-0
   
   # macOS
   brew install cmake ninja dfu-util
   ```

2. Install ESP-IDF:
   ```bash
   mkdir -p ~/esp
   cd ~/esp
   git clone --recursive https://github.com/espressif/esp-idf.git
   cd esp-idf
   git checkout v5.1.2  # or latest stable version
   ./install.sh esp32
   ```

3. Set up environment variables:
   ```bash
   . ~/esp/esp-idf/export.sh
   ```
   
   Add this to your `.bashrc` or `.zshrc` for automatic setup:
   ```bash
   alias get_idf='. ~/esp/esp-idf/export.sh'
   ```

### Windows

1. Download and run the ESP-IDF Windows Installer:
   - https://docs.espressif.com/projects/esp-idf/en/latest/esp32/get-started/windows-setup.html

2. The installer will set up everything including:
   - ESP-IDF
   - Required tools
   - Python
   - Git

## Getting Started

1. Source the ESP-IDF environment:
   ```bash
   . ~/esp/esp-idf/export.sh  # Linux/macOS
   ```

2. Navigate to an ESP32 project directory:
   ```bash
   cd esp32/
   ```

3. Configure the project:
   ```bash
   idf.py menuconfig
   ```

4. Build the project:
   ```bash
   idf.py build
   ```

5. Flash to your ESP32:
   ```bash
   idf.py -p /dev/ttyUSB0 flash  # Replace with your port
   ```

6. Monitor serial output:
   ```bash
   idf.py -p /dev/ttyUSB0 monitor
   ```

## Common Commands

- `idf.py build` - Build the project
- `idf.py flash` - Flash the project to device
- `idf.py monitor` - Start serial monitor
- `idf.py flash monitor` - Flash and start monitor
- `idf.py menuconfig` - Open configuration menu
- `idf.py fullclean` - Clean all build artifacts
- `idf.py app-flash` - Flash only the app (faster)

## Useful Resources

- [ESP-IDF Programming Guide](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/)
- [ESP32 API Reference](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-reference/index.html)
- [ESP32 Technical Reference Manual](https://www.espressif.com/sites/default/files/documentation/esp32_technical_reference_manual_en.pdf)
- [ESP32 Examples](https://github.com/espressif/esp-idf/tree/master/examples)

## Troubleshooting

### Port not found
- Linux: Check user is in `dialout` group: `sudo usermod -a -G dialout $USER`
- Ensure USB cable supports data transfer (not just charging)
- Check device with `ls /dev/tty*` (Linux/macOS) or Device Manager (Windows)

### Build errors
- Ensure all submodules are updated: `git submodule update --init --recursive`
- Clean and rebuild: `idf.py fullclean && idf.py build`
- Verify ESP-IDF environment is sourced: `echo $IDF_PATH`
