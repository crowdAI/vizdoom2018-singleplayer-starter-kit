# FAQ

This file contains a list of questions that users might ask at some point.

### How do you enable screen forwarding to see the visual output of the game?

Add the following commands to random_agent.py and be sure that they are not get overwritten by corresponding entries in  _vizdoom.cfg 
```
    game.set_window_visible(True)
    game.set_screen_format(vzd.ScreenFormat.RGB24)
    game.set_screen_resolution(vzd.RES_800X450)
    game.add_game_args("+vid_forcesurface 1")

```
### How do i enable OpenCV support to display the screen buffer on the host?

If you want imshow from OpenCV to work start the docker container with "--ipc host"
```
docker run \
  --net=host \
  --name ${container_name} \
  --env="DISPLAY" --privileged --ipc host \
  -ti --rm \
  ${image_tag} \
  /home/crowdai/run.sh
```

and code like this in your agent code
```
import cv2
frame = cv2.cvtColor( s.screen_buffer, cv2.COLOR_RGB2BGR)
cv2.imshow('debug', frame)
cv2.waitKey(1)
```        

This seems to be a required workaround due to the MIT-SHM extension: https://github.com/osrf/docker_images/issues/21

Try disabling "SHM" support in /etc/pulse/client.conf if pulseaudio on the host crashes when using this workaround.
You can also use "pulseaudio -k" on the host to kill the service instead to get host audio back. 
