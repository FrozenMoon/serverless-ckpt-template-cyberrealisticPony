FROM runpod/pytorch:2.0.1-py3.10-cuda11.8.0-devel-ubuntu22.04

# 写死你的模型地址
ENV MODEL_URL=https://huggingface.co/GGMU1878/cyberrealisticPony_v141
ENV DEBIAN_FRONTEND=noninteractive SHELL=/bin/bash

WORKDIR /opt/ckpt

# 安装依赖
COPY requirements.txt /opt/ckpt/requirements.txt
RUN pip3 install --no-cache-dir -r /opt/ckpt/requirements.txt

# 拷贝代码到容器
COPY . /opt/ckpt

# 不再在 build 阶段拉模型，让运行时自己从 HF 下载
# RUN python3 model_fetcher.py --model_url="${MODEL_URL}"

# 启动 serverless 推理
CMD ["python3", "-u", "/opt/ckpt/runpod_infer.py"]
