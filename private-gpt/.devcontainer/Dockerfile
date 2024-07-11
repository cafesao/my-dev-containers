FROM ollama/ollama:latest

# Change for your username
ARG USERNAME=cafesao
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Bahia

# Update
RUN apt update -y && apt upgrade -y

# Remove existing user with UID 1000 if it exists
RUN if id -u $USER_UID > /dev/null 2>&1; then \
      existing_user=$(getent passwd $USER_UID | cut -d: -f1); \
      userdel -r $existing_user; \
    fi

# Create the group if it doesn't exist
RUN if ! getent group $USER_GID > /dev/null 2>&1; then \
      groupadd --gid $USER_GID $USERNAME; \
    fi

# Create the user
RUN useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Install Deps
RUN apt install gcc httpie wget curl git -y

# Install Deps Pyenv
RUN apt update; apt install make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev -y

USER $USERNAME

WORKDIR /app

ENTRYPOINT ["/bin/sh", "-c"]

CMD ["sleep infinity"]