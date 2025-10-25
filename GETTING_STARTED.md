# Getting Started Checklist

Use this checklist to set up your ESP32 and Raspberry Pi Pico development environment.

## Choose Your Setup Method

Pick one of the following approaches:

- [ ] **Option A: Local Installation** - Install toolchains directly on your system
- [ ] **Option B: Docker** - Use containerized development environment
- [ ] **Option C: VS Code Dev Container** - Automatic Docker setup with VS Code

---

## Option A: Local Installation

### For ESP32 Development

- [ ] Install prerequisites (Python 3.8+, Git, CMake, etc.)
  - Ubuntu/Debian: `sudo apt-get install git wget flex bison gperf python3 python3-pip python3-venv cmake ninja-build ccache libffi-dev libssl-dev dfu-util libusb-1.0-0`
  - macOS: `brew install cmake ninja dfu-util`
- [ ] Clone ESP-IDF: `git clone --recursive https://github.com/espressif/esp-idf.git ~/esp/esp-idf`
- [ ] Checkout stable version: `cd ~/esp/esp-idf && git checkout v5.1.2`
- [ ] Install ESP-IDF tools: `./install.sh esp32`
- [ ] Source environment: `. ~/esp/esp-idf/export.sh`
- [ ] Add alias to shell config: `alias get_idf='. ~/esp/esp-idf/export.sh'`
- [ ] Test installation: `idf.py --version`

See [docs/ESP32_SETUP.md](docs/ESP32_SETUP.md) for detailed instructions.

### For Raspberry Pi Pico Development

- [ ] Install prerequisites (CMake 3.13+, ARM GCC toolchain)
  - Ubuntu/Debian: `sudo apt-get install cmake gcc-arm-none-eabi libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib build-essential`
  - macOS: `brew install cmake && brew tap ArmMbed/homebrew-formulae && brew install arm-none-eabi-gcc`
- [ ] Clone Pico SDK: `git clone https://github.com/raspberrypi/pico-sdk.git ~/pico/pico-sdk`
- [ ] Initialize submodules: `cd ~/pico/pico-sdk && git submodule update --init`
- [ ] Set environment variable: `export PICO_SDK_PATH=~/pico/pico-sdk`
- [ ] Add to shell config: `echo 'export PICO_SDK_PATH=~/pico/pico-sdk' >> ~/.bashrc`
- [ ] Test installation: `echo $PICO_SDK_PATH`

See [docs/PICO_SETUP.md](docs/PICO_SETUP.md) for detailed instructions.

### Linux Permissions (if needed)

- [ ] Add user to dialout group: `sudo usermod -a -G dialout $USER`
- [ ] Log out and back in for changes to take effect

---

## Option B: Docker

- [ ] Install Docker: https://docs.docker.com/get-docker/
- [ ] Install Docker Compose: https://docs.docker.com/compose/install/
- [ ] Build container: `docker-compose build dev`
- [ ] Start container: `docker-compose up -d dev`
- [ ] Enter container: `docker-compose exec dev bash`
- [ ] Verify ESP-IDF: `idf.py --version` (inside container)
- [ ] Verify Pico SDK: `echo $PICO_SDK_PATH` (inside container)

See [docs/DOCKER_GUIDE.md](docs/DOCKER_GUIDE.md) for detailed instructions.

---

## Option C: VS Code Dev Container

- [ ] Install Docker and Docker Compose
- [ ] Install VS Code: https://code.visualstudio.com/
- [ ] Install "Dev Containers" extension
- [ ] Open this repository in VS Code
- [ ] Press Ctrl+Shift+P and select "Dev Containers: Reopen in Container"
- [ ] Wait for container to build and start
- [ ] VS Code will automatically install recommended extensions
- [ ] Open integrated terminal - environment is ready!

---

## VS Code Setup (All Options)

- [ ] Open this repository in VS Code: `code .`
- [ ] Install recommended extensions when prompted
- [ ] Review [.vscode/settings.json](.vscode/settings.json)
- [ ] Adjust serial port settings if needed (edit `.vscode/settings.json`)
- [ ] Familiarize yourself with build tasks (Ctrl+Shift+B)

---

## Test Your Setup

### Test ESP32

- [ ] Navigate to ESP32 directory: `cd esp32/`
- [ ] Create a test project or use ESP-IDF example
- [ ] Example: `cp -r ~/esp/esp-idf/examples/get-started/hello_world ./test-esp32`
- [ ] Build: `cd test-esp32 && idf.py build`
- [ ] Connect ESP32 board via USB
- [ ] Find port: `ls /dev/tty*` (Linux/macOS) or check Device Manager (Windows)
- [ ] Flash: `idf.py -p /dev/ttyUSB0 flash`
- [ ] Monitor: `idf.py -p /dev/ttyUSB0 monitor`
- [ ] Verify "Hello world!" message appears
- [ ] Press Ctrl+] to exit monitor

### Test Pico

- [ ] Navigate to Pico directory: `cd pico/`
- [ ] Create a simple test project or clone Pico examples repository:
  ```bash
  # Option 1: Clone Pico examples (recommended)
  git clone https://github.com/raspberrypi/pico-examples.git
  cd pico-examples/blink
  
  # Option 2: If you already have pico-examples installed
  cp -r ~/pico/pico-examples/blink ./test-pico
  cd test-pico
  ```
- [ ] Build: `mkdir build && cd build && cmake .. && make -j4`
- [ ] Connect Pico with BOOTSEL button held
- [ ] Verify RPI-RP2 drive appears
- [ ] Copy .uf2 file to Pico (adjust path as needed):
  - Linux: `cp blink.uf2 /media/$USER/RPI-RP2/`
  - macOS: `cp blink.uf2 /Volumes/RPI-RP2/`
  - Windows: Drag and drop `blink.uf2` to RPI-RP2 drive
- [ ] Pico will reboot and run the program
- [ ] Verify onboard LED is blinking

---

## Learn More

- [ ] Read [README.md](README.md) for project overview
- [ ] Review [QUICK_REFERENCE.md](docs/QUICK_REFERENCE.md) for common commands
- [ ] Read [CONTRIBUTING.md](CONTRIBUTING.md) if you plan to add projects
- [ ] Bookmark official documentation:
  - ESP-IDF: https://docs.espressif.com/projects/esp-idf/
  - Pico SDK: https://raspberrypi.github.io/pico-sdk-doxygen/

---

## Troubleshooting

If you encounter issues:

1. Check the troubleshooting sections in:
   - [docs/ESP32_SETUP.md](docs/ESP32_SETUP.md#troubleshooting)
   - [docs/PICO_SETUP.md](docs/PICO_SETUP.md#troubleshooting)
   - [docs/DOCKER_GUIDE.md](docs/DOCKER_GUIDE.md#troubleshooting)

2. Common issues:
   - **Port not found**: Check USB cable, verify device permissions
   - **Build errors**: Ensure toolchains are installed and environment is sourced
   - **Permission denied**: Add user to dialout group (Linux)
   - **SDK not found**: Verify environment variables are set correctly

3. Still stuck? Open an issue on GitHub with:
   - Your operating system and version
   - Installation method used (local/Docker)
   - Complete error message
   - Steps you've already tried

---

## Next Steps

Once your environment is set up:

- [ ] Explore example projects in ESP-IDF and Pico SDK
- [ ] Create your first project in `esp32/` or `pico/` directory
- [ ] Review [docs/QUICK_REFERENCE.md](docs/QUICK_REFERENCE.md) for daily workflow
- [ ] Join the embedded development community!

Happy coding! 🚀
