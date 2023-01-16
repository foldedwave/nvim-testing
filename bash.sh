mkdir -p files/main/local
docker run \
    --mount type=bind,source=${PWD}/files/main/config/,target=/root/.config/nvim/ \
    --mount type=bind,source=${PWD}/files/main/local/,target=/root/.local/ \
    \
    --rm -it nvim-test /bin/bash
