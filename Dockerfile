FROM ghcr.io/actions/actions-runner:latest

COPY --from=mcr.microsoft.com/azure-cli:latest /usr/bin/az /usr/bin/az

USER runner

CMD ["/home/runner/run.sh"]