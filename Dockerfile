FROM ghcr.io/openvoiceos/core:dev

RUN apt-get install -y swig libfann-dev

COPY . /tmp/ovos-skills
RUN pip3 install /tmp/ovos-skills

# install skills here
RUN pip3 install git+https://github.com/OpenVoiceOS/skill-ovos-stop
RUN pip3 install git+https://github.com/OpenVoiceOS/ovos-skill-fallback-unknown
RUN pip3 install git+https://github.com/OpenVoiceOS/ovos-skill-hello-world
RUN pip3 install git+https://github.com/OpenVoiceOS/ovos-skill-personal

USER mycroft

ENTRYPOINT mycroft-skills