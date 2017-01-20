FROM java:8

MAINTAINER yukiyan <wakayama0215@gmail.com>

ENV DIGDAG_VERSION=0.9.3

RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
      jruby && \
    curl -o /usr/local/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-${DIGDAG_VERSION}" && \
    chmod +x /usr/local/bin/digdag && \
    curl -o /usr/local/bin/embulk --create-dirs -L "http://dl.embulk.org/embulk-latest.jar" && \
    chmod +x /usr/local/bin/embulk && \
    apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* && \
    adduser --shell /sbin/nologin --disabled-password --gecos "" digdag

USER digdag

WORKDIR /home/digdag

RUN embulk gem install \
      embulk-input-mysql \
      embulk-output-bigquery

COPY tasks tasks
COPY main-digdag.dig .

EXPOSE 65432

CMD ["java", "-jar", "/usr/local/bin/digdag", "scheduler", "-m"]
