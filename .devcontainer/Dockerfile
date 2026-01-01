FROM ghcr.io/naitaku/old-linux-vscode:ubuntu-18.04

ARG USERNAME=USERNAME
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Setup environment
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV SHELL=/bin/bash
ENV ROS_DISTRO=melodic
ENV DEBIAN_FRONTEND=noninteractive

# Set the timezone to Tokyo. Otherwise, it asks to set the geographic area later
ENV TZ=Asia/Tokyo

# Ensure bash is default
SHELL ["/bin/bash", "-c"]

# Delete user if it exists in container (e.g Ubuntu Noble: ubuntu)
RUN if id -u $USER_UID ; then userdel `id -un $USER_UID` ; fi

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update && apt-get install -y sudo \
    && echo "$USERNAME ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    # Explicitly copy skeleton files if they're missing
    && test -f /home/$USERNAME/.bashrc || cp /etc/skel/.bashrc /home/$USERNAME/.bashrc \
    && test -f /home/$USERNAME/.profile || cp /etc/skel/.profile /home/$USERNAME/.profile

# Setup timezone
RUN sudo ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime \
    && echo $CONTAINER_TIMEZONE | sudo tee /etc/timezone > /dev/null

# Install packages
RUN sudo apt-get update && sudo apt-get install -q -y --no-install-recommends \
    dirmngr \
    gnupg2 \
    curl \
    tzdata \
    && sudo rm -rf /var/lib/apt/lists/*

# Setup keys
RUN sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 4B63CF8FDE49746E98FA01DDAD19BAB3CBF125EA

# Setup sources.list
RUN echo "deb http://snapshots.ros.org/melodic/final/ubuntu bionic main" \
| sudo tee /etc/apt/sources.list.d/ros1-snapshots.list

# Install ros packages and dependencies for building packages
RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends \
    ros-melodic-desktop \
    python-rosdep \
    python-rosinstall \
    python-rosinstall-generator \
    python-wstool \
    build-essential \
    && sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/*

# Set the default user
USER $USERNAME
WORKDIR /home/$USERNAME

# Copy entry-point script
COPY ./entrypoint.sh /

CMD ["/bin/bash"]
