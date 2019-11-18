FROM maxtnt/docker_elixir_alpine:v1

# Install dep

# Now copy all the source
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez --force

# Now copy all the source
ADD solvit /app
    
WORKDIR /app
RUN mix deps.get
# ENV PORT 8080
# RUN mix phx.digest

# Rock'n'roll
ENV PORT 8080
CMD ["mix", "phx.server"]
#CMD [ "/bin/bash" ]