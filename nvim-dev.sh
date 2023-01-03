mkdir -p files/dev/local
docker run \
    --mount type=bind,source=${PWD}/files/dev/config/,target=/root/.config/nvim/ \
    --mount type=bind,source=${PWD}/files/dev/local/,target=/root/.local/ \
    \
    --rm -it nvim-test
