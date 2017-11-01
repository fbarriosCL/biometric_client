# BIOMETRIC CLIENT

[Biometric Client](https://biometric-client.herokuapp.com) is a interface that manager users and their authentication.

## Development

### Requirements

#### Versions

- Docker 1.12.2+
- Docker Compose 1.8.1+

#### Proxy

You need to run an instance of nginx-proxy, example:

```
version: '2'
services:
  nginx-proxy:
    image: jwilder/nginx-proxy
    container_name: nginx-proxy
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - /var/run/docker.sock:/tmp/docker.sock:ro
    networks:
      - default
networks:
  default:
    driver: bridge
```

Then add `biometric-client.dockerapp.com` to your `/etc/hosts` file pointing to your
docker host.

### Installation

Run the project with:

    $ docker-compose up --build -d

That's going to create the database and run the migrations automatically.

