#!/bin/bash

# Copyright (C) 2022  Nick Schlobohm <nks@schlobohm.one>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.

# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

echo "This script will read from the INFLUXDB_PASSWORD environment variable.
Press ^C now if you want to back out and set that variable.
Otherwise, press any key to continue."
read -n1

CONFPATH=/srv/influxdb
cp docker-compose.yml $CONFPATH/.
mkdir -p $CONFPATH
cd $CONFPATH

if [ -z "$INFLUXDB_PASSWORD" ]; then
    INFLUXDB_PASSWORD="$(echo $RANDOM | md5sum | head -c 32; echo)"
    echo "No INFLUXDB_PASSWORD supplied. Using INFLUXDB_PASSWORD: $INFLUXDB_PASSWORD"
    echo "$INFLUXDB_PASSWORD" > "$CONFPATH/INFLUXDB_PASSWORD"
    echo "This has also been stored in $CONFPATH/INFLUXDB_PASSWORD"
fi

INFLUXDB_USERNAME="${INFLUXDB_USERNAME:=root}"
INFLUXDB_BUCKET="${INFLUXDB_BUCKET:=defaultBucket}"
INFLUXDB_ORG="${INFLUXDB_ORG:=schlobohm}"

docker run --rm influxdb:2.2-alpine influxd print-config > config.yml

docker compose up -d

echo "Waiting 15 seconds..."
wait 15

docker exec influxdb influx setup \
  --bucket "$INFLUXDB_BUCKET" \
  --org "$INFLUXDB_ORG" \
  --password "$INFLUXDB_PASSWORD" \
  --username "$INFLUXDB_USERNAME" \
  --force

INFLUXDB_TOKEN=`docker exec influxdb influx auth list | awk -v username=$INFLUXDB_USERNAME '$5 ~ username {print $4 " "}'`
echo "Auth token is: $INFLUXDB_TOKEN"
echo "$INFLUXDB_TOKEN" > "$CONFPATH/INFLUXDB_TOKEN"
echo "This has also been stored in $CONFPATH/INFLUXDB_TOKEN"
