FROM alpine:3.4

MAINTAINER Dominik Ebert <doe@zuehlke.com>

ARG user=boxer
ARG app_dir=/var/boxer
ENV out_dir=/var/build

RUN apk add --no-cache \
  make \
  openssl

RUN adduser -D -u 1000 -g '${user}' ${user}
RUN mkdir -p ${app_dir} && \
    mkdir -p ${out_dir}

COPY ./Makefile ${app_dir}

RUN chown -R ${user}:${user} ${app_dir}
RUN chown -R ${user}:${user} ${out_dir}

VOLUME ${out_dir}

USER ${user}
WORKDIR ${app_dir}

CMD ["make", "all", "OUT_DIR=${out_dir}"]