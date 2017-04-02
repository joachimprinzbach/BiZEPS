FROM alpine:3.4

MAINTAINER Dominik Ebert <doe@zuehlke.com>

ARG user=boxer
ARG app_dir=/var/boxer
ENV target_dir=/var/build

RUN apk add --no-cache \
  make \
  openssl

RUN adduser -D -u 1000 -g '${user}' ${user}
RUN mkdir -p ${app_dir} && \
    mkdir -p ${target_dir}

COPY ./Makefile ${app_dir}

RUN chown -R ${user}:${user} ${app_dir}
RUN chown -R ${user}:${user} ${target_dir}

USER ${user}
WORKDIR ${app_dir}

ENTRYPOINT ["make", "OUT_DIR=${target_dir}"]
CMD ["rebuild"]