FROM alpine:3.20

ARG BUILD_TYPE=Debug
ENV BUILD_TYPE=${BUILD_TYPE}

RUN apk update && \
    apk add --no-cache cmake gcc g++ make

RUN cmake --version && \
    g++ --version && \
    echo "C++20 toolchain and CMake are ready for use."

RUN adduser -D -u 1000 appuser && \
    mkdir -p /project && \
    chown -R appuser /project

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER appuser
COPY . /project
WORKDIR /project

# Configure, build, and test based on the BUILD_TYPE environment variable
RUN cmake -DCMAKE_BUILD_TYPE=${BUILD_TYPE} -S . -B build/${BUILD_TYPE} && \
    cmake --build build/${BUILD_TYPE} && \
    chmod +x build/${BUILD_TYPE}/hello_main && \
    cd build/${BUILD_TYPE} && \
    ctest --rerun-failed --output-on-failure || true

ENTRYPOINT ["/entrypoint.sh"]