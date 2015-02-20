# Hubot EpicHAL

Turn hubot into a conversational partner with EpicHAL.

[![Build Status](https://travis-ci.org/rcs/hubot-epichal.png)](https://travis-ci.org/rcs/hubot-epichal)

## Installation

1. `npm install --save hubot-epichal`

2. Add `'hubot-epichal'` to your `external-scripts.json`.

3. Add the required environment variables for redis storage (same as
redis-brain)


## Configuration
One of `REDISTOGO_URL`, `REDISCLOUD_URL`, or `BOXEN_REDIS_URL` should be
set to define the Redis server to connect to. Otherwise, we'll try to
connect to a server on localhost.


## Usage

Your Hubot will now learn how to talk from everything it sees. Direct
any questions or comments to it to get a response.

