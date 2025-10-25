# Raspberry Pi Pico Projects

This directory is for Raspberry Pi Pico (RP2040) microcontroller projects using the Pico SDK.

## Setup

See [Pico Setup Guide](../docs/PICO_SETUP.md) for detailed setup instructions.

## Quick Start

1. Ensure PICO_SDK_PATH is set:
   ```bash
   export PICO_SDK_PATH=~/pico/pico-sdk
   ```

2. Create a new project or navigate to an existing one

3. Build and flash:
   ```bash
   mkdir build
   cd build
   cmake ..
   make -j4
   # Hold BOOTSEL and drag .uf2 file to RPI-RP2 drive
   ```

## Project Template

Each Pico project should have:
- `CMakeLists.txt` - Build configuration
- `pico_sdk_import.cmake` - SDK import (copy from `$PICO_SDK_PATH/external/pico_sdk_import.cmake`)
- Source files (`.c` or `.cpp`)
- Optional: `config/` for custom configurations

### Minimal CMakeLists.txt Example

```cmake
cmake_minimum_required(VERSION 3.13)

include(pico_sdk_import.cmake)

project(my_project C CXX ASM)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

pico_sdk_init()

add_executable(my_project
    main.c
)

target_link_libraries(my_project pico_stdlib)

pico_add_extra_outputs(my_project)
```
