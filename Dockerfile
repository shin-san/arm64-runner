FROM debian:buster-slim

ARG GITHUB_RUNNER_VERSION="2.280.3"

ENV RUNNER_NAME "runner"
ENV GITHUB_PERSONAL_ACCESS_TOKEN ""
ENV GITHUB_OWNER ""
ENV GITHUB_REPOSITORY ""
ENV RUNNER_WORKDIR "_work"

RUN apt-get update \
    && apt-get install -y \
        curl \
        sudo \
        git \
        jq \
        tar \
        gnupg2 \
        apt-transport-https \
        ca-certificates  \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

#setup docker runner 
RUN curl -sSL https://get.docker.com/ | sh

RUN curl -Ls https://github.com/actions/runner/releases/download/v${GITHUB_RUNNER_VERSION}/actions-runner-linux-arm64-${GITHUB_RUNNER_VERSION}.tar.gz | tar xz \
    && sudo ./bin/installdependencies.sh

COPY entrypoint.sh ./entrypoint.sh
RUN chmod u+x ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
