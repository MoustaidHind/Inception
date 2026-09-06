FROM debian:bookworm

# Install tools to fetch and extract the binary
RUN apt-get update && apt-get install -y wget tar

# Download the pre-compiled Portainer binary and extract it
RUN wget https://github.com/portainer/portainer/releases/download/2.19.4/portainer-2.19.4-linux-amd64.tar.gz -O portainer.tar.gz \
    && tar -xvf portainer.tar.gz \
    && rm portainer.tar.gz

# Execute the binary in the foreground
CMD ["/portainer/portainer"]