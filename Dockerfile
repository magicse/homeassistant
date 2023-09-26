# Container image that runs your code
FROM alpine:3.18
RUN apk add bash

# Set the working directory
VOLUME /config
# Expose the Home Assistant port (8123)
EXPOSE 8123
# Start Home Assistant
CMD ["hass --config /config"]

