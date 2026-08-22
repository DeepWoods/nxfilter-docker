FROM ubuntu:latest

LABEL maintainer="Rob Asher"
LABEL source="https://github.com/DeepWoods/nxfilter-docker"
LABEL release-date="2026-08-22"
LABEL version="4.7.5.4"

ARG VERSION=4.7.5.4

ENV TZ=${TZ:-Etc/UTC}

RUN apt -y update && apt -y upgrade \
  && apt -y install --no-install-recommends dnsutils iputils-ping tzdata curl openjdk-11-jre-headless \
  # 2. Download using build argument
  && curl -L -O "http://nxfilter.org/pub/nxfilter-${VERSION}.deb" \
  # 3. Install the package
  && apt -y install --no-install-recommends "./nxfilter-${VERSION}.deb" \
  # 4. Clean up unnecessary files and decrease image size
  && apt -y clean autoclean \
  && apt -y autoremove \
  && rm -rf "./nxfilter-${VERSION}.deb" /var/lib/apt /var/lib/dpkg /var/lib/cache /var/lib/log \
  && mkdir -p /nxfilter \
  && echo "${VERSION}" > /nxfilter/version.txt

EXPOSE 53/udp 19004/udp 80 443 19002 19003 19004

CMD ["/nxfilter/bin/startup.sh"]
