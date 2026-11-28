#!/bin/sh
# Fetch every sitemap listed in sitemap-index.xml (live site) and report status + URL count.
idx=https://jkapila.github.io/sitemap-index.xml
for u in $idx $(curl -s "$idx" | grep -o '<loc>[^<]*' | sed 's/<loc>//'); do
  body=$(curl -s "$u")
  printf '%s  http=%s  loc=%s\n' "$u" "$(curl -s -o /dev/null -w '%{http_code}' "$u")" "$(printf '%s' "$body" | grep -c '<loc>')"
done
