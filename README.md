# nvidia-docker image for Nicehash's CUDA multiminer Excavator

This image build [Nicehash Excavator] from GitHub.
It requires a CUDA compatible docker implementation so you should probably go
for [nvidia-docker].
It has also been tested successfully on [Mesos] 1.2.1.

## Build images

```
git clone https://github.com/eLvErDe/docker-nicehash-cuda-excavator
cd docker-nicehash-cuda-excavator
docker build -t nicehash-cuda-excavator .
```

Nicehash license doesn't allow me to redistribute Excavator so I won't publish the image to my docker account.

Build it yourself and use it locally or upload it to your own private docker registry.

## Publish it somewhere

```
docker tag nicehash-cuda-excavator docker.domain.com/mining/nicehash-cuda-excavator
docker push docker.domain.com/mining/nicehash-cuda-excavator
```

## Test it (using locally built image)

```
nvidia-docker run -it --rm nicehash-cuda-excavator /usr/bin/excavator-benchmark
```

[Nicehash Excavator]: https://bitcointalk.org/index.php?topic=2021765.0
[nvidia-docker]: https://github.com/NVIDIA/nvidia-docker
[Mesos]: http://mesos.apache.org/documentation/latest/gpu-support/
