FROM debian:buster-slim

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
  apt-get install -y git python3 python3-dev python3-pip curl build-essential && \
  c_rehash && \
  apt-get autoremove -y && \
  apt-get clean && \
  useradd --no-log-init mycroft -m

# the lines above are kept static so that docker layer is shared and cached among all containers
RUN apt-get install -y swig libfann-dev

COPY . /tmp/ovos-skills
RUN pip3 install /tmp/ovos-skills

# install skills here
RUN pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-stop
RUN pip3 install git+https://github.com/OpenVoiceOS/ovos-skill-fallback-unknown
RUN pip3 install git+https://github.com/OpenVoiceOS/ovos-skill-hello-world
RUN pip3 install git+https://github.com/OpenVoiceOS/ovos-skill-personal
RUN pip3 install git+https://github.com/OpenVoiceOS/ovos-skill-weather

USER mycroft
ENTRYPOINT mycroft-skills