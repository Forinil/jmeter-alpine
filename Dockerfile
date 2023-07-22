# syntax=docker/dockerfile:1.5
ARG ALPINE_VERSION
FROM alpine:${ALPINE_VERSION} AS base

ARG JMETER_VERSION
ENV JMETER_VERSION=${JMETER_VERSION}
RUN <<EOF
  # Install system dependencies
  apk add --no-cache ca-certificates wget unzip bash openjdk11-jre
 
  # Prepare tools directory
  mkdir -p /opt/tools
  cd /opt/tools

  # Install Apache JMeter
  wget --quiet "https://dlcdn.apache.org/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.zip" -O jmeter.zip
  unzip -qq jmeter.zip
  rm jmeter.zip
  mv "apache-jmeter-${JMETER_VERSION}" jmeter
  ln -s /opt/tools/jmeter/bin/jmeter.sh /usr/bin/jmeter
EOF

SHELL [ "/bin/bash", "-c" ]
ENTRYPOINT [ "/usr/bin/jmeter" ]
CMD [ "--help" ]