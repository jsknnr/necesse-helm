# necesse-helm
[![DockerHub](https://img.shields.io/badge/Docker_Hub-blue)](https://hub.docker.com/r/sknnr/necesse-dedicated-server)<br>

Dedicated containerized server for running Necesse. Optionally includes helm chart for running in Kubernetes.

**Disclaimer:** This is not an official image. No support, implied or otherwise is offered to any end user by the author or anyone else. Feel free to do what you please with the contents of this repo. Do good.

## Usage

The processes within the container do **NOT** run as root. Everything runs as the user steam (gid:1000/uid:1000). If you exec into the container, you will drop into `/home/steam` as the steam user. Necesse will be installed to `/home/steam/necesse`. Any persistent volumes should be mounted to `/home/steam/.config`.

### Ports

| Port | Protocol | Default |
| ---- | -------- | ------- |
| Game Port | UDP | 14159 |

### Environment Variables

| Name | Description | Default | Required |
| ---- | ----------- | ------- | -------- |
| WORLD_NAME | Name for the world save | None | True |
| GAME_PORT | The port the server will listen on | 14159 | True |
| SERVER_SLOTS | Max number of players | 10 | False |
| SERVER_PASSWORD | The password for joining the server. Leave empty for no password | None | False |
| PAUSE_EMPTY | Pause the server when no one is connected | True | False |
| MAX_LATENCY | Maximum amount of latency for connected player in seconds | 30 | False |
| CLIENT_POWER |  If true, clients will have much more power over what hits them, their position etc | True | False |
| LANGUAGE | Langauge for server | en | False |
| MOTD | Server message of the day | None | False |

### Docker

To run the container in Docker, run the following command:

```bash
mkdir necesse-persistent-data
docker run \
  --detach \
  --name necesse-server \
  --mount type=bind,source=$(pwd)/necesse-persistent-data,target=/home/steam/.config \
  --publish 14159:14159/udp \
  --env=WORLD_NAME=Super-Cool-World \
  --env=SERVER_SLOTS=10 \
  --env=SERVER_PASSWORD="ChangeThisPlease" \
  --env=PAUSE_EMPTY=true \
  --env=MAX_LATENCY=30 \
  --env=CLIENT_POWER=true \
  --env=LANGUAGE=en \
  --env=GAME_PORT=14159 \
  --env=MOTD="Welcome to my Necesse Server" \
  sknnr/necesse-dedicated-server:latest
```

Where ever you create the `necesse-persistent-data` directory is where the world save is going to go. If you delete that directory you will lose your save. That directory will be mounted into the container.

### Kubernetes

I've built a Helm chart and have included it in the `helm` directory within this repo. Modify the `values.yaml` file to your liking and install the chart into your cluster. Be sure to create and specify a namespace as I did not include a template for provisioning a namespace.
