ARG BASE=python:3.9-slim
FROM ${BASE}

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y --no-install-recommends gcc g++ make python3 python3-dev python3-pip python3-venv python3-wheel espeak-ng libsndfile1-dev && rm -rf /var/lib/apt/lists/*
RUN pip3 install llvmlite --ignore-installed

# Install Dependencies:
RUN pip3 install torch torchaudio
RUN rm -rf /root/.cache/pip

# Copy TTS repository contents:
WORKDIR /root
COPY . /root

RUN make install

ENTRYPOINT ["tts"]
CMD ["--help"]
