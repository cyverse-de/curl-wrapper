FROM alpine

RUN apk add --update \
  curl \
  perl \
  && rm -rf /var/cache/apk/*

ADD curl_wrapper.pl /bin/curl_wrapper.pl

ARG git_commit=unknown
LABEL org.iplantc.de.curl-wrapper.git-ref="$git_commit"

ENTRYPOINT ["curl_wrapper.pl"]

CMD ["-h"]
