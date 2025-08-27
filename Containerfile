FROM scratch AS ctx

COPY build.sh /build.sh

FROM quay.io/centos-bootc/centos-bootc:sha256:bc9fa7879f65ef6c607f807128050e7cd6b5bebab528a8ee59d06c6d2b6dac0b

RUN --mount=type=tmpfs,dst=/var \
    --mount=type=tmpfs,dst=/tmp \
    --mount=type=tmpfs,dst=/boot \
    --mount=type=tmpfs,dst=/run \
    --mount=type=bind,from=ctx,source=/,dst=/tmp/build-scripts \
    /tmp/build-scripts/build.sh

RUN bootc container lint --fatal-warnings
