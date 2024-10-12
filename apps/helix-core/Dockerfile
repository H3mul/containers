FROM ubuntu:24.04@sha256:ee6860ab126bb8291052401af00acad20d69c16e46579a47dac1c57cd4688446

LABEL version="1.0"
# LABEL maintainer="benjamin.hoffman.dev@gmail.com"
LABEL maintainer="phil.d324@gmail.com"

# Environement variables should be set in the docker-compose.yml or in a .env file
# via docker compose
#ENV P4ROOT="/opt/perforce/servers/master"
#ENV P4PORT=1666
#ENV P4USER="admin"
#ENV P4PASSWD="changeme123"

# Install p4d on ubuntu based on the official install docs: https://www.perforce.com/manuals/p4sag/Content/P4SAG/install.linux.packages.install.html
RUN  apt-get update \
    && apt-get upgrade -y --no-install-recommends --no-install-suggests \
    && apt-get install -y wget gnupg2\
    && rm -rf /var/lib/apt/lists/* \
    && wget -qO - https://package.perforce.com/perforce.pubkey | apt-key add - \
    && echo "deb http://package.perforce.com/apt/ubuntu jammy release" > /etc/apt/sources.list.d/perforce.list \
    && apt-get update && apt-get install helix-p4d -y --no-install-recommends --no-install-suggests

# Copy the run script over to a 'scripts' folder on the server
COPY ./entrypoint.sh /scripts/entrypoint.sh
RUN chmod 755 /scripts/entrypoint.sh

# Set the entry command of the container to the run script
CMD ["/bin/bash", "-c", "/scripts/entrypoint.sh && tail -f /dev/null"]

# Expose the p4 port that we want
EXPOSE ${P4PORT}