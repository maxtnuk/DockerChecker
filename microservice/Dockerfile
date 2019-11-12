FROM  maxtnt/docker_elixir_alpine:v1

# Install dep

# Now copy all the source
ADD solvit /app

# Build assets
WORKDIR /app
ENV PORT 8080
RUN set -ex ; \
    mix deps.get; \
    mix phx.digest; 

# Rock'n'roll
ENV PORT 8080
CMD ["mix", "phx.server"]