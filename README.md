# command_executor

Server that execute shell command passed in request

## Installation

```
git clone git@github.com:skojin/command_executor.git

docker build -t command_executor . && docker run --name command_executor --rm -p 5100:5000 -e SECRET=XXX -it command_executor

# OR

cp docker-compose.yml.sample docker-compose.yml
# set PORT and SERCRET enviroment variables in docker-compose.yml
docker-compose build && docker-compose create
docker-compose start

```

## Usage

```
curl -s -X post -F "cmd=date" http://127.0.0.1:5100/SECRET
```

## Contributors

- [Sergey Kojin](https://github.com/skojin) - creator and maintainer
