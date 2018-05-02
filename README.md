# vizdoom2018-starter-kit


# Local build
Instructions for building and testing the image locally
### Install Dependencies
* docker : By following the instructions [here](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
* repo2docker
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

### Author(s)
* Sharada Mohanty <sharada.mohanty@epfl.ch>   
* Marek@wydmuch.poznan.pl <Marek@wydmuch.poznan.pl>   
* kempka.michal@gmail.com <Marek@wydmuch.poznan.pl>   
