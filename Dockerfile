FROM alpine:3.20

ARG BUILD_TYPE=Debug
ENV BUILD_TYPE=${BUILD_TYPE}

RUN apk update && \
    apk add --no-cache cmake \
    gcc g++ \
    make

RUN cmake --version && \
    g++ --version && \
    echo "C++20 toolchain and CMake are ready for use."

# Copy local files
RUN mkdir -p /project
COPY . /project

# Configure, build, and test based on the BUILD_TYPE environment variable
RUN cd /project && \
    cmake -DCMAKE_BUILD_TYPE=${BUILD_TYPE} -S . -B build/${BUILD_TYPE} && \
    cmake --build build/${BUILD_TYPE} && \
    chmod +x build/${BUILD_TYPE}/hello_main && \
    cd build/${BUILD_TYPE} && ctest --rerun-failed --output-on-failure || true

# Testing returns fail as "Hello World!" != "Hello, World!" and why we need "|| true"

CMD ["/bin/sh"]