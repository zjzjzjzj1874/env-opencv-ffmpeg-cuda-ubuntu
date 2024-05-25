OPENCV_VERSION := $(shell grep OPENCV_VERSION .version | cut -d '=' -f '2')
CUDA_VERSION := $(shell grep CUDA_VERSION .version | cut -d '=' -f 2)
GOLANG_VERSION := $(shell grep GOLANG_VERSION .version | cut -d '=' -f 2)
GOCV_VERSION := $(shell grep GOCV_VERSION .version | cut -d '=' -f 2)
FFMPEG_VERSION := $(shell grep FFMPEG_VERSION .version | cut -d '=' -f 2)
PLATFORM := linux/amd64,linux/arm64

opencv-cuda-runtime:
	docker buildx build --push --progress plain --platform=${PLATFORM}	\
		--file=opencv-cuda_runtime-ubuntu.Dockerfile \
		--tag=ghcr.io/khlipeng/opencv-cuda-runtime:${OPENCV_VERSION}-${CUDA_VERSION}-${FFMPEG_VERSION} \
		--build-arg=OPENCV_VERSION=${OPENCV_VERSION}	\
		--build-arg=CUDA_VERSION=${CUDA_VERSION}	\
		--build-arg=FFMPEG_VERSION=${FFMPEG_VERSION}	\
		.

opencv-cuda-devel:
	docker buildx build --push --progress plain --platform=${PLATFORM}	\
		--file=opencv-cuda_devel-ubuntu.Dockerfile \
		--tag=ghcr.io/khlipeng/opencv-cuda-devel:${OPENCV_VERSION}-${CUDA_VERSION}-${FFMPEG_VERSION}	\
		--build-arg=OPENCV_VERSION=${OPENCV_VERSION}	\
		--build-arg=CUDA_VERSION=${CUDA_VERSION}	\
		--build-arg=FFMPEG_VERSION=${FFMPEG_VERSION}	\
		.

go-cuda-devel:		.
	docker buildx build --push --progress plain \
		--platform=${PLATFORM} \
		--file=go-cuda_devel-ubuntu.Dockerfile \
		--tag=zjzjzjzj1874/go-cuda-devel:${GOLANG_VERSION}-${OPENCV_VERSION}-${CUDA_VERSION}-${FFMPEG_VERSION} \
		--build-arg=GOLANG_VERSION=${GOLANG_VERSION}	\
		--build-arg=OPENCV_VERSION=${OPENCV_VERSION}	\
		--build-arg=CUDA_VERSION=${CUDA_VERSION}	\
		--build-arg=GOCV_VERSION=${GOCV_VERSION}	\
		--build-arg=FFMPEG_VERSION=${FFMPEG_VERSION}	\
		.
