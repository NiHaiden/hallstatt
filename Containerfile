FROM scratch AS ctx

COPY build.sh /build.sh

FROM quay.io/centos-bootc/centos-bootc:2457f0c168047cbc96b2eabd6876cebaedd3930a41fb36d653837341745ca725

RUN --mount=type=tmpfs,dst=/var \
    --mount=type=tmpfs,dst=/tmp \
    --mount=type=tmpfs,dst=/boot \
    --mount=type=tmpfs,dst=/run \
    --mount=type=bind,from=ctx,source=/,dst=/tmp/build-scripts \
    /tmp/build-scripts/build.sh

RUN bootc container lint --fatal-warnings
