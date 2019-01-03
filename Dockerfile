FROM python:3.6-alpine
MAINTAINER evi1 <toddlerya@gmail.com>

RUN addgroup -S -g 9898 pypiserver && \
adduser -S -u 9898 -G pypiserver pypiserver && \
apk add py-bcrypt curl && \
pip install --upgrade pip && \
pip install -U passlib pypiserver[cache]==1.2.5 && \
mkdir -p /data/packages && \
chown -R pypiserver:pypiserver /data/packages && \
# Set the setgid bit so anything added here gets associated with the
# pypiserver group
chmod g+s /data/packages

VOLUME /data/packages
USER pypiserver
WORKDIR /data
EXPOSE 8080

# ENTRYPOINT ["pypi-server", "-p", "8080"]
# CMD ["packages"]

ADD entrypoint.sh /
CMD ["/entrypoint.sh"]
