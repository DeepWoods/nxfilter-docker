# NxFilter #

[NxFilter](http://nxfilter.org/p3/)  is a scalable and reliable DNS filter server software by Jahastech. 

Container image is based off of Ubuntu:latest minimal with DEB package for NxFilter from [NxFilter](https://nxfilter.org/p3/download/).


### Usage ###

#### Interactive container: ####

```
docker run -it --name nxf \
   -p 53:53/udp \
   -p 80:80 \
   -p 443:443 \
   deepwoods/nxfilter:latest
```

#### Detached container with persistent data volumes: ####

```
docker run --rm -d --name nxf \
  -v nxconf:/nxfilter/conf \
  -v nxdb:/nxfilter/db \
  -v nxlog:/nxfilter/log \
  -p 53:53/udp \
  -p 80:80 \
  -p 443:443 \
  -p 19002-19004:19002-19004 \
  deepwoods/nxfilter:latest
```
