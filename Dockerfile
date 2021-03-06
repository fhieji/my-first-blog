FROM ubuntu:16.04

ENV PYTHONUNBUFFERD 1
ENV PYTHONIOENCODING utf-8

ENV HOME /root
ENV DEPLOY_DIR ${HOME}/djangogirls

RUN apt-get update

# Set locale
RUN apt-get install -y locales
RUN sed -i -e "s/# en_US.UTF-8 UTF-8/en.USUTF-8 UTF-8/" /etc/locale.gen \
    && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

#Install the latest python
RUN apt-get install -y wget\
    build-essential \
    zlib1g-dev \
    libssl-dev \
    libsqlite3-dev
WORKDIR ${HOME}
RUN wget https://www.python.org/ftp/python/3.6.6/Python-3.6.6.tgz\
    && tar zxf Python-3.6.6.tgz \
    && cd Python-3.6.6 \
    && ./configure --enable-iptimizations \
    && make altinstall

#Set alias
RUN update-alternatives --install \
    /usr/local/bin/python3 python3 /usr/local/bin/python3.6 1
RUN update-alternatives --install /usr/local/bin/pip3 pip3 /usr/local/bin/pip3.6 1
RUN pip3 install -U pip
WORKDIR ${DEPLOY_DIR}
CMD ["/bin/bash"]
