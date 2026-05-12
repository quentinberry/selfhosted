#!/bin/bash
# NAS folder setup script
# Usage: ./setup-folders.sh [--docker-volume2]
#
# By default, docker appdata is created under /volume1/docker.
# Pass --docker-volume2 to place docker appdata on /volume2 instead
# (useful for multi-volume setups where volume2 is dedicated to docker).

DOCKER_VOLUME="volume1"

for arg in "$@"; do
  case $arg in
    --docker-volume2)
      DOCKER_VOLUME="volume2"
      ;;
    *)
      echo "Unknown option: $arg"
      echo "Usage: $0 [--docker-volume2]"
      exit 1
      ;;
  esac
done

echo "Docker appdata volume: /$DOCKER_VOLUME"
echo "Data/media/scripts volume: /volume1"
echo ""

FOLDERS=(
  # Docker appdata
  "$TEST_ROOT/$DOCKER_VOLUME/docker/appdata/prowlarr"
  "$TEST_ROOT/$DOCKER_VOLUME/docker/appdata/Overseer"
  "$TEST_ROOT/$DOCKER_VOLUME/docker/appdata/sabnzbd"
  "$TEST_ROOT/$DOCKER_VOLUME/docker/appdata/plex"
  "$TEST_ROOT/$DOCKER_VOLUME/docker/appdata/lidarr"
  "$TEST_ROOT/$DOCKER_VOLUME/docker/appdata/anime-sonarr"
  "$TEST_ROOT/$DOCKER_VOLUME/docker/appdata/readarr"
  "$TEST_ROOT/$DOCKER_VOLUME/docker/appdata/tautulli"
  "$TEST_ROOT/$DOCKER_VOLUME/docker/appdata/mealie"
  "$TEST_ROOT/$DOCKER_VOLUME/docker/appdata/workoutwarrior"
  "$TEST_ROOT/$DOCKER_VOLUME/docker/appdata/mylar3"
  "$TEST_ROOT/$DOCKER_VOLUME/docker/appdata/kapowarr"
  "$TEST_ROOT/$DOCKER_VOLUME/docker/appdata/calibre"
  "$TEST_ROOT/$DOCKER_VOLUME/docker/appdata/watchlistarr"
  "$TEST_ROOT/$DOCKER_VOLUME/docker/appdata/postgres"
  "$TEST_ROOT/$DOCKER_VOLUME/docker/appdata/pgadmin"
  "$TEST_ROOT/$DOCKER_VOLUME/docker/appdata/ombi"
  "$TEST_ROOT/$DOCKER_VOLUME/docker/appdata/sonarr"
  "$TEST_ROOT/$DOCKER_VOLUME/docker/appdata/radarr"
  "$TEST_ROOT/$DOCKER_VOLUME/docker/appdata/nginx-proxy-manager"
  "$TEST_ROOT/$DOCKER_VOLUME/docker/appdata/immich-app"
  "$TEST_ROOT/$DOCKER_VOLUME/docker/appdata/nzbdav"
  "$TEST_ROOT/$DOCKER_VOLUME/docker/appdata/rclone"
  "$TEST_ROOT/$DOCKER_VOLUME/docker/appdata/home-assistant"
  "$TEST_ROOT/$DOCKER_VOLUME/docker/appdata/homarr"
  "$TEST_ROOT/$DOCKER_VOLUME/docker/appdata/bookshelf"
  "$TEST_ROOT/$DOCKER_VOLUME/docker/appdata/radarr-db-secrets"
  "$TEST_ROOT/$DOCKER_VOLUME/docker/appdata/radarr-db"
  "$TEST_ROOT/$DOCKER_VOLUME/docker/appdata/sonarr-db-secrets"
  "$TEST_ROOT/$DOCKER_VOLUME/docker/appdata/sonarr-db"
  "$TEST_ROOT/$DOCKER_VOLUME/docker/dashdot"

  # Usenet data
  "$TEST_ROOT/volume1/data/usenet/incomplete"
  "$TEST_ROOT/volume1/data/usenet/complete"
  "$TEST_ROOT/volume1/data/usenet/watch"
  "$TEST_ROOT/volume1/data/usenet/scripts"

  # Media library
  "$TEST_ROOT/volume1/data/media/movies"
  "$TEST_ROOT/volume1/data/media/tv"
  "$TEST_ROOT/volume1/data/media/tv-anime"
  "$TEST_ROOT/volume1/data/media/music"
  "$TEST_ROOT/volume1/data/media/4k-movies"
  "$TEST_ROOT/volume1/data/media/xxx"
  "$TEST_ROOT/volume1/data/media/books"
  "$TEST_ROOT/volume1/data/media/img"
  "$TEST_ROOT/volume1/data/media/files"
  "$TEST_ROOT/volume1/data/media/games"

  # NZBDav
  "$TEST_ROOT/volume1/data/nzbdav/nzbdav-mnt"
  "$TEST_ROOT/volume1/data/nzbdav/cache"

  # Scripts
  "$TEST_ROOT/volume1/scripts/logs"

  # Gallery
  "$TEST_ROOT/volume1/gallery/library"
  "$TEST_ROOT/volume1/gallery/upload"
  "$TEST_ROOT/volume1/gallery/backups"

  # Backups
  "$TEST_ROOT/volume1/backups/games"
)

CREATED=0
SKIPPED=0

for folder in "${FOLDERS[@]}"; do
  if [ -d "$folder" ]; then
    echo "  [skip]    $folder"
    ((SKIPPED++))
  else
    if mkdir -p "$folder"; then
      echo "  [created] $folder"
      ((CREATED++))
    else
      echo "  [error]   $folder"
    fi
  fi
done

echo ""
echo "Done. Created: $CREATED, Skipped (already existed): $SKIPPED"
