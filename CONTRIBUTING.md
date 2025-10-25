# Contributing Guide

Thank you for your interest in contributing to this project! This guide will help you set up your environment and understand the project structure.

## Project Structure

```
esp32-playground/
├── esp32/              # ESP32 projects (ESP-IDF)
├── pico/               # Raspberry Pi Pico projects (Pico SDK)
├── docs/               # Documentation
├── .vscode/            # VS Code configuration
├── .devcontainer/      # Docker dev container config
└── .editorconfig       # Editor configuration
```

## Getting Started

1. **Choose your setup method:**
   - Local installation (see [ESP32_SETUP.md](docs/ESP32_SETUP.md) or [PICO_SETUP.md](docs/PICO_SETUP.md))
   - Docker (see [DOCKER_GUIDE.md](docs/DOCKER_GUIDE.md))
   - VS Code Dev Container (automatic with Docker)

2. **Fork and clone the repository:**
   ```bash
   git clone https://github.com/YOUR_USERNAME/esp32-playground.git
   cd esp32-playground
   ```

3. **Create a feature branch:**
   ```bash
   git checkout -b feature/your-feature-name
   ```

## Adding New Projects

### ESP32 Projects

1. Create a new directory under `esp32/`:
   ```bash
   mkdir esp32/my-project
   ```

2. Add required files:
   - `CMakeLists.txt` - Project build configuration
   - `main/CMakeLists.txt` - Main component configuration
   - `main/my-project.c` - Your source code
   - `README.md` - Project documentation

3. Follow ESP-IDF conventions:
   - Use `idf.py` for building and flashing
   - Include descriptive comments
   - Document hardware requirements

### Pico Projects

1. Create a new directory under `pico/`:
   ```bash
   mkdir pico/my-project
   ```

2. Add required files:
   - `CMakeLists.txt` - Project build configuration
   - `pico_sdk_import.cmake` - Copy from SDK
   - `main.c` - Your source code
   - `README.md` - Project documentation

3. Follow Pico SDK conventions:
   - Use CMake for building
   - Include hardware wiring diagrams if needed
   - Document GPIO pin usage

## Code Style

This project uses EditorConfig for consistent formatting:

- **C/C++ files:** 4 spaces, UTF-8, LF line endings
- **CMake files:** 2 spaces
- Always include final newline
- Trim trailing whitespace

Follow these additional guidelines:

### C/C++ Code Style

```c
// Use descriptive names
int sensor_value = 0;

// Comment complex logic
// Calculate average over 10 samples
for (int i = 0; i < 10; i++) {
    sensor_value += read_sensor();
}
sensor_value /= 10;

// Keep functions focused and small
void initialize_hardware(void) {
    setup_gpio();
    setup_uart();
    setup_i2c();
}
```

### CMake Style

```cmake
# Use lowercase commands
cmake_minimum_required(VERSION 3.13)

# Group related settings
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

# Comment non-obvious configurations
# Enable USB output for debugging
pico_enable_stdio_usb(${PROJECT_NAME} 1)
```

## Documentation

### Project README Template

Each project should have a README with:

```markdown
# Project Name

Brief description of what the project does.

## Hardware

- Microcontroller: ESP32 / Raspberry Pi Pico
- Additional components: List sensors, displays, etc.

## Wiring

Describe GPIO connections or include a diagram.

## Building

Instructions for building the project.

## Usage

How to use the project after flashing.

## Notes

Any additional information or limitations.
```

## Testing

### ESP32 Testing

```bash
cd esp32/my-project
idf.py build
# Test on actual hardware
idf.py -p /dev/ttyUSB0 flash monitor
```

### Pico Testing

```bash
cd pico/my-project
mkdir build && cd build
cmake ..
make -j4
# Test on actual hardware
```

## Committing Changes

1. **Write clear commit messages:**
   ```
   Add blink example for ESP32
   
   - Implements basic LED blink using ESP-IDF
   - Configurable blink rate via menuconfig
   - Includes documentation
   ```

2. **Keep commits focused:**
   - One feature or fix per commit
   - Don't mix refactoring with new features

3. **Before committing:**
   - Test your code on actual hardware
   - Verify documentation is updated
   - Check that build succeeds

## Pull Requests

1. **Update your fork:**
   ```bash
   git fetch upstream
   git rebase upstream/main
   ```

2. **Push your changes:**
   ```bash
   git push origin feature/your-feature-name
   ```

3. **Create pull request:**
   - Provide clear description
   - Reference any related issues
   - Include photos/videos if applicable
   - List hardware requirements

4. **Pull request checklist:**
   - [ ] Code builds successfully
   - [ ] Tested on actual hardware
   - [ ] Documentation updated
   - [ ] Follows code style guidelines
   - [ ] Includes README for new projects

## Getting Help

- Check the documentation in `docs/`
- Review existing projects for examples
- Open an issue for questions
- Join discussions in pull requests

## Code Review

Pull requests require:
- Successful build
- Clear documentation
- Reasonable code quality

Reviews focus on:
- Functionality and correctness
- Code clarity and maintainability
- Documentation completeness
- Hardware safety considerations

## License

By contributing, you agree that your contributions will be licensed under the same license as the project (see [LICENSE](LICENSE)).

## Thank You!

Your contributions help make this a better resource for the embedded development community!
