FROM golang:1.8.1

# Fix for expired LE root cert
RUN rm /usr/share/ca-certificates/mozilla/DST_Root_CA_X3.crt
RUN update-ca-certificates

WORKDIR $GOPATH/src/github.com/player-two/openshift-api-group/
COPY glide.yaml glide.lock ./
RUN go get -u github.com/Masterminds/glide && \
    glide install --strip-vendor

COPY . .
RUN go install

EXPOSE 8080
CMD ["openshift-api-group"]
