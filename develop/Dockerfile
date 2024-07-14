FROM andy5995/slackware-build-essential:15.0
WORKDIR /
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh \
    && slapt-get --update
ENTRYPOINT ["/entrypoint.sh"]