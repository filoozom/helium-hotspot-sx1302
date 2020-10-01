FROM alpine as builder

RUN apk add --no-cache git gcc make musl-dev linux-headers \
	&& git clone --single-branch --branch helium/hotspot https://github.com/filoozom/sx1302_hal.git \
	&& cd sx1302_hal \
	&& make all -e -C libtools \
	&& make all -e -C libloragw \
	&& make all -e -C packet_forwarder \
	&& chmod +x packet_forwarder/lora_pkt_fwd

FROM busybox
WORKDIR /app

COPY --from=builder /sx1302_hal/packet_forwarder/lora_pkt_fwd ./forwarder
COPY entrypoint.sh tools/reset_lgw.sh ./
COPY config/* ./config/

RUN chmod +x entrypoint.sh reset_lgw.sh

ENTRYPOINT ["./entrypoint.sh"]
