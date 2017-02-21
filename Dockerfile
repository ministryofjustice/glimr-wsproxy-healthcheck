FROM ruby:2.4.0-onbuild

ENV PUMA_PORT 9292

RUN touch /etc/inittab

EXPOSE $PUMA_PORT

ENTRYPOINT ["./run.sh"]
