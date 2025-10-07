FROM ghcr.io/actions/actions-runner:latest
USER root
# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Azure CLI
RUN mkdir -p /etc/apt/keyrings && \
    curl -sLS https://packages.microsoft.com/keys/microsoft.asc | \
    gpg --dearmor | tee /etc/apt/keyrings/microsoft.gpg > /dev/null && \
    chmod go+r /etc/apt/keyrings/microsoft.gpg && \
    cat << EOF > /etc/apt/sources.list.d/azure-cli.sources
Types: deb
URIs: https://packages.microsoft.com/repos/azure-cli/
Suites: $(lsb_release -cs)
Components: main
Architectures: $(dpkg --print-architecture)
Signed-by: /etc/apt/keyrings/microsoft.gpg
EOF

RUN apt-get update && \
    apt-get install -y azure-cli --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
USER runner
CMD ["/home/runner/run.sh"]
