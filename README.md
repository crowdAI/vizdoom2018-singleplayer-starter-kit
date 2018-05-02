# vizdoom2018-starter-kit


# Local build
Instructions for building and testing the image locally
### Install Dependencies
* **docker** : By following the instructions [here](https://docs.docker.com/install/linux/docker-ce/)
* **nvidia-docker** : By following the instructions [here](https://github.com/nvidia/nvidia-docker/wiki/Installation-(version-2.0))
* **repo2docker**
```
pip install jupyter-repo2docker
```

### Cloning repository
```
git clone git@github.com:crowdAI/vizdoom2018-singleplayer-starter-kit.git
cd vizdoom2018-singleplayer-starter-kit
```

### Build Image
Assuming you have docker setup on your machine. You can now build the image by :
```
repo2docker --no-run \
  --user-id 1001 \
  --user-name crowdai \
  --image-name my_submission_image \
  --debug .
```

### Run Agent Locally
```
nvidia-docker run \
  --name my_local_container \
  -it my_submission_image \
  --net=host \
  --env="DISPLAY" \
  /home/crowdai/run.sh
```
and you should see something along the lines of :
```bash
================================================================================
Beginning execution of mock.py
================================================================================
AL lib: (WW) alc_initconfig: Failed to initialize backend "pulse"
Press 'Q' to abort network game synchronization.
Contacting host: |
```
Now, in a separate tab you need to run a host for your agent to be able to
connect to.

### Start Host for a Mock Evaluation
```bash
docker pull spMohanty/vizdoom2018-singleplayer
docker run \
  --name my_local_container \
  -it spMohanty/vizdoom2018-singleplayer \
  --net=host \
  --env="DISPLAY" \
  /home/crowdai/run.sh
```

and now your agent should be able to connect with the local instance of the grader
and start a mock evaluation.

### Author(s)
* Sharada Mohanty <sharada.mohanty@epfl.ch>   
* Marek@wydmuch.poznan.pl <Marek@wydmuch.poznan.pl>   
* kempka.michal@gmail.com <Marek@wydmuch.poznan.pl>   
