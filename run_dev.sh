#!/bin/sh

# start server with code reloading
# https://github.com/kemalcr/kemal/issues/335#issuecomment-320079295
# npm i -g nodemon
SECRET=X PORT=5100 nodemon --ext cr,ecr --exec "crystal run" src/server.cr
