# docker-vv-bug

Docker project repository for reproducing bugs in ViaVersion.

## Description

- compose.yml: Startup configuration for proxy server container and PaperMC container.
- command.sh: Command for startup.
- .env: URL of external resources used in compose.yml.
- ./*/: Directory to store Dockerfile & startup scripts for each container and files needed by the server.
- ./*/Dockerfile: Build image for each container. Copy the necessary files, set up the server and plugins, and run the startup scripts .
- ./*/init.sh: Startup script. Process stop signals, reflect Velocity secret strings, and start the server.
- ./pxy/forwarding.secret: File which contains secret string of Velocity, copied in container and used by Velocity.
- ./papermc/eula.txt, ./papermc/paper.yml, ./papermc/server.properties, ./papermc/spigot.yml, ./pxy/velocity.toml: Files used in the container that you want to set up in advance.

## Steps to Reproduce

1. `bash commnad.sh`
