recoll with webui in a docker container

based on https://github.com/amsaravi/docker-recoll-webui

  docker build -t recoll-webui:local --ulimit nofile=1048576:1048576 .
  docker run -d -p 8080:8080 --name recoll \
      -v /home/data/ebooks:/docs \
      --ulimit nofile=1048576:1048576 \
      recoll-webui:local
  docker exec recoll recollindex

ulimits must be set to avoid long stalls
https://github.com/MaastrichtUniversity/docker-dev/commit/97ab4fd04534f73c023371b07e188918b73ac9d0
https://stackoverflow.com/a/78069377/203515

caveats:
the index including xapiandb lives in containers, which isn't what I want.
I'm symlinking to /root as I failed to configure recoll properly:

  rm -rf /root/.recoll
  ln -s /docs/.recoll /root/.recoll
