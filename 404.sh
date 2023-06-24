#!/bin/bash

check_status() {
  url="$1"
  response=$(curl -s -o /dev/null -w "%{http_code}" "$url")
  if [[ $response == 404 ]]; then
    echo "$url - Halaman tidak ditemukan (404)"
    echo "$url" >> 404.txt
  else
    echo "$url - Halaman ditemukan"
  fi
}

export -f check_status

cat "$1" | xargs -I {} -P 4 bash -c 'check_status "$@"' _ {}
