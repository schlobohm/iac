#!/bin/sh

PLUGINDIR=/srv/minecraft/plugins

mkdir -p $PLUGINDIR
cd $PLUGINDIR

# EssentialsX and related
curl -s https://api.github.com/repos/EssentialsX/Essentials/releases/latest \
  | grep "browser_download_url.*\.jar" `# filter for artifacts with URLs ending in ".jar"` \
  | cut -d : -f 2,3 `# print fields 2 and 3 where delimiter is ':' - there is a colon after HTTPS so we must select both fields` \
  | tr -d \" `# delete '"' characters` \
  | awk '{$1=$1};1' `# remove leading and trailing whitespace` \
  | wget -q -i - `# download via wget, quietly, taking input from stdin`

# Multiverse-Core
curl -s "https://ci.onarandombox.com/job/Multiverse-Core/lastSuccessfulBuild/api/json?pretty=true" \
  | grep "relativePath.*\.jar" `# filter for artifacts with names ending in ".jar"` \
  | cut -d : -f 2 `# print field 2 where delimiter is ':' - ie. json value` \
  | grep -v -e "javadoc.jar" -e "sources.jar" `# exclude lines with specific strings` \
  | tr -d \" `# delete '"' characters` \
  | awk '{$1=$1};1' `# remove leading and trailing whitespace` \
  | sed 's/^/https:\/\/ci.onarandombox.com\/job\/Multiverse-Core\/lastSuccessfulBuild\/artifact\//g' `# add beginning of URL to each line that gets passed into stdin` \
  | wget -q -i - # download via wget, quietly, taking input from stdin

# Dynmap
curl -s https://dynmap.us/builds/dynmap/ \
  | grep "Dynmap.*spigot\.jar" `# filter for artifacts with names beginning with "Dynmap" and ending with "spigot.jar"` \
  | head -n 1 `# only use first line matching filter criteria above` \
  | awk -F'<a href="' '{print $2}' `# get everything after "<a href=\"\""` \
  | cut -d '"' -f 1 `# delete everything after (and including) the first '"' character` \
  | sed 's/^/https:\/\/dynmap.us\/builds\/dynmap\//g' `# add beginning of URL to each line that gets passed into stdin` \
  | wget -q -i - # download via wget, quietly, taking input from stdin
