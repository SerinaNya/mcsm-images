FROM ubuntu:22.04

# SETUP APT
RUN sed -i "s@http://archive.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list && \
    sed -i "s@http://security.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list && \
    apt update

# INSTALL ESSENTIAL
RUN apt install -y python3.10 curl wget gnupg2

# SETUP APT - LIBERICA
RUN wget -q -O - https://download.bell-sw.com/pki/GPG-KEY-bellsoft | apt-key add - && \
    echo "deb https://apt.bell-sw.com/ stable main" | tee /etc/apt/sources.list.d/bellsoft.list && \
    apt update

# INSTALL PIP
RUN apt install -y build-essential python3-pip

# SETUP PIP
RUN pip3 config set global.index-url https://repo.huaweicloud.com/repository/pypi/simple

# INSTALL LIBERICA
RUN apt install -y bellsoft-java8

# INSTALL MCDR
RUN pip3 install -U mcdreforged

ENV LANG=zh_CN.UTF-8
ENV LANGUAGE=zh_CN.UTF-8
ENV LC_ALL=zh_CN.UTF-8
ENV TZ=Asia/Shanghai

RUN mkdir -p /workspace
WORKDIR /workspace
