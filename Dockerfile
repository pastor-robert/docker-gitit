FROM debian:bullseye-slim
MAINTAINER Rob Adams <rob@rob-adams.us>

# Usage: docker run -e LANG=C.UTF-8 -e GIT_USER_EMAIL=wiki@example.com -e GIT_USER_NAME=wiki -e TZ=America/Chicago -t -p 80:5001 -v $PWD/data:/data -v $PWD/ssmtp:/etc/ssmtp pastorrob/gitit

# Based on https://github.com/bringnow/docker-gitit
# Based on https://github.com/Hyzual/docker-gitit

# Update package list
RUN apt-get update -qq

# Install required packages (git required by gitlab-runner)
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends mime-support gitit libghc-filestore-data ssmtp

VOLUME ["/data"]

VOLUME ["/etc/ssmtp"]

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
WORKDIR /data
EXPOSE 5001

CMD ["gitit", "-f", "/data/gitit.conf"]
