# MoJ Websocket Proxy Healthcheck Client

[![CircleCI](https://circleci.com/gh/ministryofjustice/glimr-wsproxy-healthcheck.svg?style=svg)](https://circleci.com/gh/ministryofjustice/glimr-wsproxy-healthcheck)

Sinatra application for checking the status of the websocket proxy used
to access GLiMR instances within secure environments.

## Expected output

When called on

```
http://<host>:<port>/healthcheck.json
```

it will return:

```
Status: 200
{"service_status":"ok","dependencies":{"glimr_status":"ok"}}
```

for success and:

```
Status: 502
{"service_status":"failed","dependencies":{"glimr_status":"failed"}}
```

if GLiMR cannot be reached.

## Setup & Run (locally)

This app uses Docker Compose to run locally, which lets you spin up an app container with minimal effort:

```
# Set up environment variables
cp env.example .env

# Run the containers
docker-compose up
```

### Running the app directly on your machine

You are of course free to run the app directly too, in which case you will need to bring your own Ruby-ready environment.
