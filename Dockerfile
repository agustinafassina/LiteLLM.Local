FROM ghcr.io/berriai/litellm-database:main-latest

WORKDIR /app

COPY config.yaml /app/config.yaml

EXPOSE 4000

CMD ["--config", "/app/config.yaml", "--port", "4000", "--detailed_debug"]