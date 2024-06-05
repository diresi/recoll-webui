FROM debian:buster-slim
MAINTAINER diresi <diresi@gmx.net>

RUN true \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
      ca-certificates

COPY lesbonscomptes.gpg /usr/share/keyrings/
COPY recoll-buster.list /etc/apt/sources.list.d/
#COPY recoll-bullseye.list /etc/apt/sources.list.d/
#COPY recoll-bookworm.list /etc/apt/sources.list.d/

RUN true \
  && apt-get install -y --no-install-recommends \
      python-recoll python3-recoll \
      python3 python3-pip git \
      poppler-utils unrtf antiword unzip \
  && apt autoremove \
  && apt-get clean \
  && pip3 install waitress

RUN mkdir /docs && mkdir /root/.recoll
COPY recoll.conf /root/.recoll/recoll.conf

RUN cd / && git clone https://framagit.org/medoc92/recollwebui.git

VOLUME /docs
EXPOSE 8080

CMD ["/usr/bin/python3", "/recollwebui/webui-standalone.py", "-a", "0.0.0.0"]
