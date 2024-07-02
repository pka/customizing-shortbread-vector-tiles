% Customizing Shortbread vector tiles
% Pirmin Kalberer @implgeo
% State of the Map Europe 2024 Łódź
---
width: 1600
height: 900
---

# About me

. . .

Lazy mapper (55 changesets in 15 years)

. . .

FOSSGIS e.V. board (German OSM chapter)

. . .

GIS developer

* Sourcepole, Switzerland
* t-rex tile server -> BBOX

# Shortbread schema

* Basic, lean, general-purpose vector tile schema for OSM data
* CC0 licensed

![](images/shortbread_logo.png){ width=20% }

## Schema specification

<https://shortbread-tiles.org/schema/1.0/>

# Shortbread styles

## Versatiles Colorful

![](images/versatiles-colorful-z13.webp)

## Versatiles Neutrino

![](images/versatiles-neutrino-z13.webp)

# Styling

Mapbox / MapLibre GL JSON: <https://maplibre.org/maplibre-style-spec/>

```json
{
  "source": "birddata",
  "source-layer": "change_increase",
  "type": "circle",
  "paint": {
    "circle-radius": {
      "property": "code",
      "stops": [
        [1, 5],
        [2, 10],
        [3, 15],
        [4, 20]
      ]
    },
    "circle-stroke-color": "#000000"
  }
},
```
![](images/gl-json-birddata.png)

## Style editor

Maputnik Editor ([maplibre.org/maputnik](https://maplibre.org/maputnik/))

![](images/maputnik-screenshot.jpg)

## Viewer

* MapLibre GL
* OpenLayers (ol-mapbox-style)
* Leaflet (MapLibre/mapbox-gl-leaflet plugin)
* deck.gl (MVTLayer), kepler.gl

# Tile creation workflows

## PPF → Vector tiles

![](images/pbf-mvt.png)

* tilemaker ([tilemaker.org](https://tilemaker.org/))
* Planetiler ([github.com/onthegomap/planetiler](https://github.com/onthegomap/planetiler))

## PPF → DB → Vector tiles

![](images/pbf-db-mvt.png)

* osm2pgsql flex ([osm2pgsql.org](https://osm2pgsql.org/))
* BBOX (t-rex) ([www.bbox.earth](https://www.bbox.earth/))
* Tilekiln ([github.com/pnorman/tilekiln](https://github.com/pnorman/tilekiln))

### tilemaker

* Configs for OpenMapTiles and Shortbread schema
* Json configuration with Lua scripts
* Output formats: MBTiles, PMTiles
* No diff support

### Shortbread with tilemaker

```bash
git clone https://github.com/shortbread-tiles/shortbread-tilemaker
cd shortbread-tilemaker

# Download additional data (water polygons, etc.). Requires ogr2ogr!
./get-shapefiles.sh

# Download OSM extract
curl -sSfO --output-dir data https://download.geofabrik.de/europe/liechtenstein-latest.osm.pbf

docker run --rm -v $PWD:/var/tm -w /var/tm versatiles/versatiles-tilemaker \
  tilemaker --config config.json --process process.lua \
  --input data/liechtenstein-latest.osm.pbf --output data/liechtenstein-latest.pmtiles
```

::: notes
docker run --rm -p 8080:8080 -v $PWD:/data:ro -v $PWD/../../tilemaker/server/static:/static:ro versatiles/versatiles-tilemaker tilemaker-server --static /static --input /data/liechtenstein-latest.pmtiles
:::

### Planetiler

* Configs for OpenMapTiles and Shortbread schema
* Yaml configuration or Java application
* Output formats: MBTiles, PMTiles
* No diff support
* Extremely fast: Planet in 22m

### Shortbread with Planetiler

```bash
docker run -rm -v $PWD/data:/data ghcr.io/onthegomap/planetiler shortbread.yml --download --area=liechtenstein
```

::: notes
sh quickstart.sh --docker --area=liechtenstein shortbread.yml
:::

### osm2pgsql flex

### BBOX

### Tilekiln

## Tile storage

* Files / S3
* MBTiles + tile service
* PMTiles
* DB cache + tile service

# Schema extensions

## Extend shortbread

## Combine tilesets

# Summary

# Thank you

Pirmin Kalberer

<https://mapstodon.space/@implgeo>
