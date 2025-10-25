# Raspberry Pi Pico Development Environment Setup

This guide will help you set up your development environment for Raspberry Pi Pico (RP2040) microcontrollers.

## Prerequisites

- CMake (3.13 or higher)
- GCC cross-compiler for ARM (arm-none-eabi)
- Git
- Python 3.6 or higher
- Build tools (make, ninja)

## Installation

### Linux / macOS

1. Install prerequisites:
   ```bash
   # Ubuntu/Debian
   sudo apt-get install cmake gcc-arm-none-eabi libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib build-essential
   
   # macOS
   brew install cmake
   brew tap ArmMbed/homebrew-formulae
   brew install arm-none-eabi-gcc
   ```

2. Install Pico SDK:
   ```bash
   mkdir -p ~/pico
   cd ~/pico
   git clone https://github.com/raspberrypi/pico-sdk.git --branch master
   cd pico-sdk
   git submodule update --init
   ```

3. Set up environment variables:
   ```bash
   export PICO_SDK_PATH=~/pico/pico-sdk
   ```
   
   Add this to your `.bashrc` or `.zshrc`:
   ```bash
   export PICO_SDK_PATH=~/pico/pico-sdk
   ```

4. (Optional) Install picotool for easier device management:
   ```bash
   cd ~/pico
   git clone https://github.com/raspberrypi/picotool.git
   cd picotool
   mkdir build
   cd build
   cmake ..
   make
   sudo cp picotool /usr/local/bin/
   ```

### Windows

1. Install prerequisites:
   - Download and install [CMake](https://cmake.org/download/)
   - Download and install [Build Tools for Visual Studio](https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022)
   - Download and install [ARM GCC Compiler](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads)
   - Download and install [Git](https://git-scm.com/download/win)
   - Download and install [Python](https://www.python.org/downloads/)

2. Clone Pico SDK:
   ```powershell
   mkdir C:\pico
   cd C:\pico
   git clone https://github.com/raspberrypi/pico-sdk.git --branch master
   cd pico-sdk
   git submodule update --init
   ```

3. Set environment variable:
   ```powershell
   setx PICO_SDK_PATH "C:\pico\pico-sdk"
   ```

## Getting Started

1. Navigate to a Pico project directory:
   ```bash
   cd pico/
   ```

2. Create a build directory:
   ```bash
   mkdir build
   cd build
   ```

3. Configure the project:
   ```bash
   cmake ..
   ```

4. Build the project:
   ```bash
   make -j4
   ```

5. Flash to your Pico:
   - Hold BOOTSEL button while connecting Pico to USB
   - Drag and drop the `.uf2` file to the RPI-RP2 drive
   - Or use picotool: `picotool load project.uf2 -f`

## Common Commands

- `cmake ..` - Configure the build (run from build directory)
- `make -j4` - Build using 4 parallel jobs
- `make clean` - Clean build artifacts
- `picotool info` - Show connected Pico device info
- `picotool load project.uf2 -f` - Flash UF2 file to Pico
- `picotool reboot -f` - Reboot connected Pico

## Project Structure

A typical Pico project has this structure:
```
project/
├── CMakeLists.txt       # Build configuration
├── pico_sdk_import.cmake # SDK import script (copy from SDK)
├── src/
│   └── main.c           # Your source code
└── build/               # Build output directory
```

## Debugging

### Serial Output (UART)
- Connect USB-to-serial adapter to UART pins (GP0/TX, GP1/RX)
- Use minicom, screen, or PuTTY to view output
- Default baud rate: 115200

### SWD Debugging
- Use another Pico as a debug probe (Picoprobe)
- Or use a CMSIS-DAP compatible debugger
- Configure in VS Code with Cortex-Debug extension

## Useful Resources

- [Pico Getting Started Guide](https://datasheets.raspberrypi.com/pico/getting-started-with-pico.pdf)
- [Pico C/C++ SDK Documentation](https://raspberrypi.github.io/pico-sdk-doxygen/)
- [Pico Examples](https://github.com/raspberrypi/pico-examples)
- [RP2040 Datasheet](https://datasheets.raspberrypi.com/rp2040/rp2040-datasheet.pdf)
- [Pico Datasheet](https://datasheets.raspberrypi.com/pico/pico-datasheet.pdf)

## Troubleshooting

### Pico not detected
- Ensure USB cable supports data transfer
- Hold BOOTSEL button when connecting to enter bootloader mode
- Check if RPI-RP2 drive appears

### Build errors
- Verify PICO_SDK_PATH is set correctly: `echo $PICO_SDK_PATH`
- Ensure SDK submodules are initialized: `cd $PICO_SDK_PATH && git submodule update --init`
- Check ARM GCC is in PATH: `arm-none-eabi-gcc --version`

### Upload issues
- Ensure Pico is in BOOTSEL mode (hold button while connecting)
- Try a different USB port or cable
- On Linux, check permissions: `sudo chmod 666 /dev/ttyACM0`
