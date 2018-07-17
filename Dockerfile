FROM vizdoom/vizdoom:1.1.6-ubuntu16.04-cuda9.0


# Unicode support:
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Enables X11 sharing and creates user home directory
ENV USER_NAME crowdai
ENV HOME_DIR /home/$USER_NAME
#
# Replace HOST_UID/HOST_GUID with your user / group id (needed for X11)
ENV HOST_UID 1000
ENV HOST_GID 1000

RUN export uid=${HOST_UID} gid=${HOST_GID} && \
    mkdir -p ${HOME_DIR} && \
    echo "$USER_NAME:x:${uid}:${gid}:$USER_NAME,,,:$HOME_DIR:/bin/bash" >> /etc/passwd && \
    echo "$USER_NAME:x:${uid}:" >> /etc/group && \
    echo "$USER_NAME ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER_NAME && \
    chmod 0440 /etc/sudoers.d/$USER_NAME && \
    chown ${uid}:${gid} -R ${HOME_DIR}

USER ${USER_NAME}
WORKDIR ${HOME_DIR}

COPY config config
COPY random_agent.py .
COPY mock.wad .
COPY run.sh .
RUN sudo chown ${HOST_UID}:${HOST_GID} -R *
RUN sudo chmod 775 -R *

# Uncomment to use doom2.wad:
#COPY doom2.wad /usr/local/lib/python3.5/dist-packages/vizdoom

ENTRYPOINT ["./run.sh"]
