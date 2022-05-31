FROM bash:4.4 
RUN apk update && apk add docker openrc && rc-update add docker boot
