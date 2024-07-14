FROM andy5995/slackware-build-essential:15.0
WORKDIR /
ENTRYPOINT ["/source/mkpkg"]