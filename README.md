# vizdoom2018-starter-kit


### Local build

Instructions for building and testing the image locally.   

#### Install Dependencies
* **docker** : By following the instructions [here](https://docs.docker.com/install/linux/docker-ce/)
* **nvidia-docker** : By following the instructions [here](https://github.com/nvidia/nvidia-docker/wiki/Installation-(version-2.0))
* **repo2docker**
```
pip install jupyter-repo2docker
```

#### Cloning repository
```
git clone git@github.com:crowdAI/vizdoom2018-singleplayer-starter-kit.git
cd vizdoom2018-singleplayer-starter-kit
```

#### Build Image
Assuming you have docker setup on your machine. You can now build the image by :
```
repo2docker --no-run \
  --user-id 1001 \
  --user-name crowdai \
  --image-name my_submission_image \
  --debug .
```

#### Run Agent Locally
```
docker run \
  --user root \
  --name my_local_container \
  -it my_submission_image \
  --net=host \
  --env="DISPLAY" \
  --privileged \  
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
connect to a game.

#### Start Server for a Mock Evaluation
```bash
docker pull spMohanty/vizdoom2018-singleplayer-host
docker run \
  --name my_local_container \
  -it spMohanty/vizdoom2018-singleplayer-host \
  --net=host \
  --env="DISPLAY" \
  /home/crowdai/run.sh
```

and now your agent should be able to connect with the local instance of the grader
and start a mock evaluation.

### Making a Submission
Making your first submission is actually much easier.
* Create a **private** repository on [gitlab.crowdai.org](http://gitlab.crowdai.org/)   
Lets say you created a repository at :
```
https://gitlab.crowdai.org/<your-crowdAI-user-name>/vizdoom2018-singleplayer
```
* push the contents of this repository into this **new private repository**
```
git remote add crowdAI https://gitlab.crowdai.org/<your-crowdAI-user-name>/vizdoom2018-singleplayer
git push origin master
```
* remember to modify [crowdai.json](crowdai.json) to use your author information.
* create and push a new tag :
```
git tag -a v1.4 -m "my version 1.4"
git push crowdAI master
```

**Every tag you push is counted as a submission**. And a new submission should reflect on the challenge page at : [https://www.crowdai.org/challenges/visual-doom-ai-competition-2018/submissions](https://www.crowdai.org/challenges/visual-doom-ai-competition-2018/submissions)
and more details about the evaluation of your submission will be available at :
```
https://gitlab.crowdai.org/<your-crowdAI-user-name>/vizdoom2018-singleplayer/issues
```
as a new issue.

### Author(s)
* Sharada Mohanty <sharada.mohanty@epfl.ch>   
* Marek@wydmuch.poznan.pl   
* kempka.michal@gmail.com   
