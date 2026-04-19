# Quick Reference Guide

This is a quick reference for common commands and workflows.

## Environment Setup

### ESP32
```bash
# Set up ESP-IDF environment (do this in every new terminal)
. ~/esp/esp-idf/export.sh

# Or add an alias to your .bashrc/.zshrc
alias get_idf='. ~/esp/esp-idf/export.sh'
```

### Raspberry Pi Pico
```bash
# Set environment variable (do this in every new terminal)
export PICO_SDK_PATH=~/pico/pico-sdk

# Or add to your .bashrc/.zshrc
echo 'export PICO_SDK_PATH=~/pico/pico-sdk' >> ~/.bashrc
```

## Common Commands

### ESP32 (ESP-IDF)

```bash
# Build project
idf.py build

# Flash to device
idf.py -p /dev/ttyUSB0 flash

# Monitor serial output
idf.py -p /dev/ttyUSB0 monitor

# Flash and monitor (most common)
idf.py -p /dev/ttyUSB0 flash monitor

# Configure project
idf.py menuconfig

# Clean build
idf.py fullclean

# Set target (for different ESP32 variants)
idf.py set-target esp32    # ESP32
idf.py set-target esp32s2  # ESP32-S2
idf.py set-target esp32s3  # ESP32-S3
idf.py set-target esp32c3  # ESP32-C3
```

### Raspberry Pi Pico

```bash
# Configure project (first time or after changes to CMakeLists.txt)
mkdir build
cd build
cmake ..

# Build project
make -j4

# Clean build
rm -rf build

# Flash to Pico (manual method)
# 1. Hold BOOTSEL button while connecting Pico to USB
# 2. Drag and drop the .uf2 file from build/ to RPI-RP2 drive

# Flash using picotool (if installed)
picotool load project.uf2 -f

# Get device info
picotool info

# Reboot device
picotool reboot -f
```

## Finding Your Device Port

### Linux
```bash
# List all serial devices
ls /dev/tty*

# Common ESP32 ports
/dev/ttyUSB0
/dev/ttyUSB1

# Common Pico ports
/dev/ttyACM0
/dev/ttyACM1

# Monitor device connections in real-time
watch -n 0.5 'ls /dev/tty*'
```

### macOS
```bash
# List all serial devices
ls /dev/cu.*

# Common ports
/dev/cu.usbserial-*
/dev/cu.usbmodem*
```

### Windows
```powershell
# Use Device Manager to find COM port
# Or in PowerShell:
Get-WmiObject Win32_SerialPort | Select-Object Name, DeviceID
```

## VS Code Integration

### Keyboard Shortcuts
- `Ctrl+Shift+B` - Run build task
- `F5` - Start debugging
- `Ctrl+Shift+P` - Command palette

### Useful VS Code Commands
- `ESP-IDF: Build project` - Build ESP32 project
- `ESP-IDF: Flash device` - Flash ESP32
- `ESP-IDF: Monitor device` - Open serial monitor
- `CMake: Configure` - Configure Pico project
- `CMake: Build` - Build Pico project

## Troubleshooting

### Permission Denied on Linux
```bash
# Add user to dialout group for serial port access
sudo usermod -a -G dialout $USER
# Log out and back in for changes to take effect
```

### ESP-IDF Not Found
```bash
# Ensure you've sourced the export script
. ~/esp/esp-idf/export.sh

# Check if IDF_PATH is set
echo $IDF_PATH
```

### Pico SDK Not Found
```bash
# Ensure PICO_SDK_PATH is set
export PICO_SDK_PATH=~/pico/pico-sdk

# Verify the path exists
ls $PICO_SDK_PATH
```

### Build Failures

#### ESP32
```bash
# Update submodules
cd ~/esp/esp-idf
git submodule update --init --recursive

# Clean and rebuild
idf.py fullclean
idf.py build
```

#### Pico
```bash
# Update SDK submodules
cd $PICO_SDK_PATH
git submodule update --init

# Clean and rebuild
rm -rf build
mkdir build && cd build
cmake ..
make -j4
```

## Serial Monitor Tools

### Built-in Tools
```bash
# ESP-IDF monitor (Ctrl+] to exit)
idf.py -p /dev/ttyUSB0 monitor

# Screen (Ctrl+A then K to exit)
screen /dev/ttyUSB0 115200

# Minicom
minicom -D /dev/ttyUSB0 -b 115200
```

### Installing Additional Tools
```bash
# Install screen
sudo apt-get install screen  # Ubuntu/Debian
brew install screen           # macOS

# Install minicom
sudo apt-get install minicom  # Ubuntu/Debian
brew install minicom          # macOS
```

## Useful Environment Variables

### ESP32
- `IDF_PATH` - Path to ESP-IDF directory
- `IDF_TOOLS_PATH` - Path to ESP-IDF tools (default: ~/.espressif)

### Pico
- `PICO_SDK_PATH` - Path to Pico SDK
- `PICO_TOOLCHAIN_PATH` - Optional: Custom toolchain path

## Hardware Information

### ESP32 Pin Mapping
Common ESP32 DevKit v1 pins:
- GPIO 0-39: General purpose I/O
- GPIO 34-39: Input only
- GPIO 6-11: Connected to flash (don't use)
- GPIO 1, 3: UART TX/RX (used for programming)

### Pico Pin Mapping
Raspberry Pi Pico pins:
- GPIO 0-28: General purpose I/O
- GPIO 0-1: Default UART TX/RX
- GPIO 25: Onboard LED
- ADC 0-2: Analog input pins (GPIO 26-28)

## Additional Resources

- ESP32: https://docs.espressif.com/
- Pico: https://www.raspberrypi.com/documentation/microcontrollers/
