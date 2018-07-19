# VDAIC2018 Singleplayer starter kit
![CrowdAI-Logo](https://github.com/crowdAI/crowdai/raw/master/app/assets/images/misc/crowdai-logo-smile.svg?sanitize=true)

[![gitter-badge](https://badges.gitter.im/crowdAI/vizdoom2018.png)](https://gitter.im/crowdAI/vizdoom2018)



How to start your participation in [Visual Doom AI Competition 2018 - Singleplayer Track (1)](https://www.crowdai.org/challenges/visual-doom-ai-competition-2018-singleplayer-track-1/)!

* [Local build](#local_build)
  * [Dependencies](#deps)
  * [Building](#build)
  * [Running the host](#run_host)
  * [Running the agent](#run_agent)
* [TL;DR Creating a submission](#create_sub_tldr)  
* [Creating a submission](#create_sub)

### <a name="local_build"></a> Local build

Instructions for building and testing the image locally.   

#### <a name="deps"></a> Install Dependencies
* **docker** : By following the instructions [here](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
* **nvidia-docker** : By following the instructions [here](https://github.com/nvidia/nvidia-docker/wiki/Installation-(version-2.0))
* **repo2docker**
```sh
pip install crowdai-repo2docker
```

#### Cloning repository
```sh
git clone git@github.com:crowdAI/vizdoom2018-singleplayer-starter-kit.git
cd vizdoom2018-singleplayer-starter-kit
```

#### <a name="build"></a> Build Image
Assuming you have docker setup on your machine. You can now build the image by :
```sh
export image_tag="my_submission_image"
crowdai-repo2docker --no-run \
  --user-id 1001 \
  --user-name crowdai \
  --image-name ${image_tag} \
  --debug .
```

#### <a name="run_host"></a>  Start Server for a Mock Evaluation
In a dedicated tab (terminal) you need to run a host for your agent to be able to
connect to the game (also in single player!).

```sh
export host_container_name="vizdoom_host_container"
docker rm -f $host_container_name #Ensure an old instance of the container is not present

docker pull spmohanty/vizdoom2018-singleplayer-host #Or build your own
docker run \
  --name $host_container_name \
  --net=host \
  --env="DISPLAY" \
  -it spmohanty/vizdoom2018-singleplayer-host \
  /home/crowdai/run.sh
```

#### <a name="run_agent"></a>  Run Agent Locally
```sh
export container_name="my_submission_container"
docker rm -f $container_name #Ensure an old instance of the container is not present

export image_tag="my_submission_image"
docker run \
  --net=host \
  --name ${container_name} \
  --env="DISPLAY" --privileged \
  -ti --rm \
  ${image_tag} \
  /home/crowdai/run.sh
```
and you should see something along the lines of :
```sh
================================================================================
Beginning execution of mock.py
================================================================================
AL lib: (WW) alc_initconfig: Failed to initialize backend "pulse"
Press 'Q' to abort network game synchronization.
Contacting host: |
```

Now your agent should be able to connect with the local instance of the grader
and start a mock evaluation.


### <a name="create_sub_tldr"></a> TL;DR : Creating a Submission 
**Note**: This section assumes, that you have setup your SSH keys on [https://gitlab.crowdai.org](https://gitlab.crowdai.org) by following the instructions [here](https://docs.gitlab.com/ee/gitlab-basics/create-your-ssh-keys.html).

* **Setting things up the first time**
```bash
# Clone Repository 
git clone git@github.com:crowdAI/vizdoom2018-singleplayer-starter-kit.git
cd vizdoom2018-singleplayer-starter-kit
# Point to new Origin 
git remote rename origin oldorigin
git remote add origin git@gitlab.crowdai.org:<YOUR_CROWDAI_USER_NAME>/vizdoom2018-singleplayer-starter-kit.git
git push origin master
# Update Author
sed -i 's/spMohanty/<YOUR_CROWDAI_USER_NAME>/g' crowdai.json
git commit -am "Update crowdai.json"
```
* **Submitting to crowdAI**
```
git tag -am "version 0.1" v0.1
git push origin v0.1
echo "Check the status of your submission at : 'https://gitlab.crowdai.org/<YOUR_CROWDAI_USER_NAME>/vizdoom2018-singleplayer-starter-kit/issues'
```

### <a name="create_sub"></a>  Creating a Submission
Making your first submission is actually much easier.
* Create a **private** repository on [gitlab.crowdai.org](http://gitlab.crowdai.org/)  (name is arbitrary)
The repository should contain:
  * Dockerfile that installs dependencies, copies any files and setups anything you require (see [a sample Dockerfile](Dockerfile))
  * crowdai.json file which may contain any arbitrary fields that you like (e.g. description of the submission) but **must** contain the following three field:
    * challenge_id - "vizdoom2018_single_player"
    * grader_id - "vizdoom2018_single_player" 
    * author - name of the author (string), for teams, pleas **also** create a field 'authors' containing a list with all authors
Sample crowdai.json:
```javascript
{
  "challenge_id": "vizdoom2018_single_player",
  "track_id": "vizdoom2018_single_player",
  "author": "Johnny the Leader",
  "authors": ["Johnny the Leader", "Steve the Devops", "Goeff the AI guy", "Bill the Intern" ],
  "license": "MIT",
  "version": "alpha of pre beta",
  "algorithm": "A3C on steroids",
  "expected_result": "Total Anihilation"
}

```
    
Lets say you created a repository at:
```
https://gitlab.crowdai.org/<your-crowdAI-user-name>/vizdoom2018-singleplayer
```
* push the contents of this repository into this **new private repository**
```sh
git remote add crowdAI git@gitlab.crowdai.org:<your-crowdAI-user-name>/vizdoom2018-singleplayer.git
git push crowdAI master
```
* remember to modify [crowdai.json](crowdai.json) to use your author information.
* create and push a new tag :
```sh
git tag -a v1.4 -m "my version 1.4"
git push crowdAI master
git push crowdAI v1.4
```

**Every tag you push is counted as a submission**. And a new submission should reflect on the challenge page at : [https://www.crowdai.org/challenges/visual-doom-ai-competition-2018-singleplayer-track-1/submissions](https://www.crowdai.org/challenges/visual-doom-ai-competition-2018-singleplayer-track-1/submissions)
You will be able to see your AI agent actually play the game and see more details about your submission evaluation of your submission on :
```
https://gitlab.crowdai.org/<your-crowdAI-user-name>/vizdoom2018-singleplayer/issues
```
as a new issue (though it's not necessarily an issue) 😉.

<img width="400" src="https://user-images.githubusercontent.com/15749650/42951506-9cb025ba-8b76-11e8-9de8-a92e6a4c1120.PNG">

A video of the game will also be generated and available from the [leaderboard](https://www.crowdai.org/challenges/visual-doom-ai-competition-2018-singleplayer-track-1/leaderboards). How cool is that? ![DOOMGuy](https://static-cdn.jtvnw.net/emoticons/v1/54089/1.0)

### <a name="faq"></a> FAQ
Check out our <a href="FAQ.md">FAQ section</a> for common questions 

### <a name="create_sub"></a> Author(s)
* Sharada Mohanty <sharada.mohanty@epfl.ch>   
* Marek Wydmuch <marek@wydmuch.poznan.pl>  
* Michał Kempka <kempka.michal@gmail.com>   
