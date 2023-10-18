FROM ubuntu:latest

LABEL maintainer="Rob Asher"
LABEL version="4.6.7.9"
LABEL release-date="2023-10-17"
LABEL source="https://github.com/DeepWoods/nxfilter-docker"

ENV TZ=${TZ:-Etc/UTC}

RUN apt -y update && apt -y upgrade \
  && apt -y install --no-install-recommends dnsutils iputils-ping tzdata curl openjdk-11-jre-headless \
  && curl $(printf ' -O http://pub.nxfilter.org/nxfilter-%s.deb' $(curl https://nxfilter.org/curver.php)) \
  && apt -y install --no-install-recommends ./$(printf 'nxfilter-%s.deb' $(curl https://nxfilter.org/curver.php)) \
  && apt -y clean autoclean \
  && apt -y autoremove \
  && rm -rf ./$(printf 'nxfilter-%s.deb' $(curl https://nxfilter.org/curver.php)) \
  && rm -rf /var/lib/apt && rm -rf /var/lib/dpkg && rm -rf /var/lib/cache && rm -rf /var/lib/log \
  && echo "$(curl https://nxfilter.org/curver.php)" > /nxfilter/version.txt

EXPOSE 53/udp 19004/udp 80 443 19002 19003 19004

CMD ["/nxfilter/bin/startup.sh"]
