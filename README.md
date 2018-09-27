# Streaming video from a raspberry pi

The accompanying docker file builds an image that can be used to stream video from the camera of the raspberry PI, effectively turning it into an IP camera. There is a binary version of this image host at `721466574657.dkr.ecr.us-east-1.amazonaws.com//dockerpi:mjpeg-streamer.latest`. 

### Using and Running the Image

To use the binary image (suggested) folowe these steps: 

1) Ensure [docker is installed](https://medium.freecodecamp.org/the-easy-way-to-set-up-docker-on-a-raspberry-pi-7d24ced073ef) on your Pi. 
2) Run `docker run -p 8080:8080 --device=/dev/video0 721466574657.dkr.ecr.us-east-1.amazonaws.com/dockerpi:mjpeg-streamer.latest`
3) Open a browser on the same network and enter the url `http://raspberrypi.local:8080/?action=stream` replacing `raspberrypi.local` with the host name or IP of your Pi device hosting the camera. 

#### CMD arguments
The command arguments are a little odd due to the mjpg-streamer code. It basically takes two arguments, and in input (specified with `-i`) and and output (specified with `-o`) and then quoted options that apply to that input or output. The docker image uses mostly the defaults for most settings and sets up the video quality at 1280x720 at 30 FPS and a jpg quality of 80. If you need to override these settings, then you will respecify the entire `-i` part of the params in quotes. The output is fixed as part of the entrypoint since that is not likely to need to change (i.e. you can map to different ports using docker's `-p` command). 

For example, to run the camera with a resolution of 640x640 and an FPS of 15, you would use this command: `docker run -p 8080:8080 --device=/dev/video0 721466574657.dkr.ecr.us-east-1.amazonaws.com/dockerpi:mjpeg-streamer.latest "input_uvc.so -n -r 640x640 -f 15 -q 80"`. ***Note the quotes are required as is the `input_uvc.so`!**

### Modifying the docker image
If you wish to build the docker image your self you may do so on the Pi or a Mac using the comand `docker build -t 721466574657.dkr.ecr.us-east-1.amazonaws.com/dockerpi:mjpeg-streamer.latest:latest .` To subsequently publish a new version use `docker push 721466574657.dkr.ecr.us-east-1.amazonaws.com/dockerpi:mjpeg-streamer.latest:latest`

### The following urls were used as reference building this image
  - https://github.com/cncjs/cncjs/wiki/Setup-Guide:-Raspberry-Pi-%7C-MJPEG-Streamer-Install-&-Setup-&-FFMpeg-Recording
  - https://github.com/jacksonliam/mjpg-streamer
