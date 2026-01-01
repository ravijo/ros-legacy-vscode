# ros-legacy-vscode

A VS Code development container setup for working with legacy ROS distributions (ROS Melodic as an example) on older Ubuntu versions within Docker containers.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Demonstration](#demonstration)
- [Environment](#environment)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [References](#references)
- [License](#license)

## Overview

This repository enables seamless VS Code integration with Docker containers running legacy ROS distributions on Ubuntu versions earlier than 20.04.

### Why This Repository?

VS Code Server requires GLIBC 2.28 or higher, which isn't available on Ubuntu 18.04 and earlier. This project provides a pre-configured VS Code Server that works with these older systems, allowing you to:

- Develop ROS projects in legacy environments using modern VS Code features
- Maintain older ROS codebases without sacrificing developer experience
- Leverage VS Code's IntelliSense, debugging, and extensions in containerized ROS environments

## Features

- ✅ Full VS Code Server support for Ubuntu 18.04
- ✅ Pre-configured for ROS Melodic development
- ✅ Docker-based isolated development environment
- ✅ Catkin workspace ready to use
- ✅ Easy project setup with devcontainer configuration

## Installation

### Step 1: Clone the Repository

```bash
git clone https://github.com/ravijo/ros-legacy-vscode
cd ros-legacy-vscode/
```

Alternatively, you can download the repository as a ZIP file from GitHub.

### Step 2: Download and Extract VS Code Server

1. Navigate to the [Releases](https://github.com/ravijo/ros-legacy-vscode/releases) page
2. Download `bin.tar.gz` from the latest release
3. Extract it into the `.vscode-server` folder:

```bash
cd ros-legacy-vscode/
tar -xzvf ~/Downloads/bin.tar.gz -C .vscode-server
```

**Note:** Make sure the extraction path is correct. The `bin` folder should be placed inside `.vscode-server/`.

### Step 3: Verify Folder Structure

Ensure your directory structure matches the following:

```
.
├── .devcontainer
│   ├── devcontainer.json
│   ├── Dockerfile
│   └── entrypoint.sh
├── .gitignore
├── LICENSE
├── README.md
├── .vscode-server
│   ├── bin
│   │   └── 994fd12f8d3a5aa16f17d42c041e5809167e845a
│   │       ├── bin
│   │       ├── extensions
│   │       ├── LICENSE
│   │       ├── node
│   │       ├── node_modules
│   │       ├── out
│   │       ├── package.json
│   │       └── product.json
│   └── .gitkeep
└── ws
    ├── .catkin_workspace
    └── src
        ├── .gitkeep
        ├── package1  # Your first ROS package goes here
        └── package2  # Your second ROS package goes here
```

## Usage

### Opening the Project

1. Open the project folder in VS Code:
   ```bash
   cd ros-legacy-vscode/
   code .
   ```

2. When prompted, click **"Reopen in Container"** (or use the command palette: `Ctrl+Shift+P` → `Remote-Containers: Reopen in Container`)

3. Wait for the container to build and start. This may take a few minutes on first run.

### Working with ROS Packages

Your ROS workspace is located in the `ws` directory. Add your ROS packages to `ws/src/`:

```bash
ws/
├── .catkin_workspace
└── src/
    ├── your_package_1/
    └── your_package_2/
```

### Building Your Workspace

Inside the container terminal:

```bash
cd /workspace/ws
catkin_make
source devel/setup.bash
```

## Project Structure

```
ros-legacy-vscode/
├── .devcontainer/          # Development container configuration
│   ├── devcontainer.json   # VS Code container settings
│   ├── Dockerfile          # Container image definition
│   └── entrypoint.sh       # Container startup script
├── .vscode-server/         # Pre-configured VS Code Server
│   └── bin/                # VS Code Server binaries
├── ws/                     # ROS catkin workspace
│   └── src/                # Your ROS packages go here
└── README.md
```

## Demonstration

<p align="center">
    <img src="files/demo.gif" alt="Gif showing demo of ros-legacy-vscode" />
    </br>
    <sup>Sample video showing demo of ros-legacy-vscode</sup>
</p>


## Environment

### Host PC (Tested Configuration)

| Component | Version                     |
|-----------|-----------------------------|
| OS        | Ubuntu 24.04.3 LTS (64-bit) |
| Kernel    | 6.14.0-37-generic           |
| GLIBC     | 2.39                        |
| Docker    | 29.1.3                      |
| VS Code   | 1.107.1                     |

### Guest PC (Container)

| Component | Version                     |
|-----------|-----------------------------|
| OS        | Ubuntu 18.04.3 LTS (64-bit) |
| ROS       | Melodic                     |

### VS Code Extensions

The following extensions are installed on Host PC in VS Code:
```bash
ms-vscode-remote.remote-containers@0.434.0
ms-vscode-remote.remote-ssh@0.122.0
ms-vscode-remote.remote-ssh-edit@0.87.0
ms-vscode-remote.remote-wsl@0.104.3
ms-vscode-remote.vscode-remote-extensionpack@0.26.0
ms-vscode.remote-explorer@0.5.0
ms-vscode.remote-server@1.5.3
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Issues

If you encounter any problems or have suggestions, please [open an issue](https://github.com/ravijo/ros-legacy-vscode/issues) on GitHub.

## References

- [old-linux-vscode](https://github.com/naitaku/old-linux-vscode) - Inspiration for this project
- [VS Code Remote Development](https://code.visualstudio.com/docs/remote/containers) - Official documentation
- [VS Code Server FAQ](https://code.visualstudio.com/docs/remote/faq#_can-i-run-vs-code-server-on-older-linux-distributions) - Compatibility information
- [ROS Melodic Documentation](http://wiki.ros.org/melodic)

## License

This project is licensed under the terms specified in the [LICENSE](LICENSE) file.

---

**Maintained by:** [ravijo](https://github.com/ravijo)

**Star this repository** ⭐ if you find it helpful!