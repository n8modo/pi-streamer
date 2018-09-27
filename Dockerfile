# This image is designed to be run on a RaspberryPi and provides video steaming (via mjpg) from the PI camera. 
# To invoke it on the PI, you must share the camera device with the docker image, you should launch it like this: 
# docker run -p 8080:8080 --device=/dev/video0 721466574657.dkr.ecr.us-east-1.amazonaws.com/pi-streamer


# To build a new version of this image: `docker build -t 721466574657.dkr.ecr.us-east-1.amazonaws.com/pi-streamer:latest .`
# To publish it" `docker push 721466574657.dkr.ecr.us-east-1.amazonaws.com/pi-streamer:latest`

# Reference the following urls for running mjpg streams on a raspberry-pi
# https://github.com/cncjs/cncjs/wiki/Setup-Guide:-Raspberry-Pi-%7C-MJPEG-Streamer-Install-&-Setup-&-FFMpeg-Recording
# https://github.com/jacksonliam/mjpg-streamer

FROM schachr/raspbian-stretch
MAINTAINER Edmodo

RUN apt-get update && apt-get install git build-essential libjpeg8-dev imagemagick libv4l-dev cmake -y && rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/jacksonliam/mjpg-streamer.git
RUN cd mjpg-streamer/mjpg-streamer-experimental && make && make install

ENTRYPOINT ["/usr/local/bin/mjpg_streamer", "-o", "output_http.so","-i"]
CMD ["input_uvc.so -n -r 1280x720 -f 30 -q 80"]
EXPOSE 8080
