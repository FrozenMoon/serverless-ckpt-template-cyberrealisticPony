FROM runpod/pytorch:2.0.1-py3.10-cuda11.8.0-devel-ubuntu22.04

ARG MODEL_URL
ENV MODEL_URL=https://huggingface.co/GGMU1878/cyberrealisticPony_v141

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ENV DEBIAN_FRONTEND noninteractive\
    SHELL=/bin/bash

WORKDIR /opt/ckpt

COPY requirements.txt /opt/ckpt/requirements.txt
RUN pip3 install -r /opt/ckpt/requirements.txt

COPY . /opt/ckpt

RUN python3 model_fetcher.py --model_url=${MODEL_URL}
RUN echo "Model URL: $MODEL_URL"

CMD python3 -u /opt/ckpt/runpod_infer.py --model_url="$MODEL_URL"
