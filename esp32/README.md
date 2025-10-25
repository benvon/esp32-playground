# ESP32 Projects

This directory is for ESP32 microcontroller projects using ESP-IDF.

## Setup

See [ESP32 Setup Guide](../docs/ESP32_SETUP.md) for detailed setup instructions.

## Quick Start

1. Ensure ESP-IDF is installed and environment is sourced:
   ```bash
   . ~/esp/esp-idf/export.sh
   ```

2. Create a new project or navigate to an existing one

3. Build and flash:
   ```bash
   idf.py build
   idf.py -p <PORT> flash monitor
   ```

## Project Template

To create a new ESP32 project, you can copy from ESP-IDF examples or use:
```bash
idf.py create-project <project-name>
```

Each project should have:
- `CMakeLists.txt` - Build configuration
- `main/` - Main source directory
- `main/CMakeLists.txt` - Main component build config
- `main/<project-name>.c` - Main source file
- `sdkconfig` - Project configuration (generated)
