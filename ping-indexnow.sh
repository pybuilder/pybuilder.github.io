#!/bin/bash -eEu

# Ping IndexNow with all URLs from the sitemap.
# IndexNow distributes to Bing, Yandex, Naver, Seznam, and Yep.
# Google does not participate in IndexNow (deprecated their ping endpoint in 2023).

SITEMAP_FILE="${1:?Usage: $0 <sitemap-file> <indexnow-key>}"
INDEXNOW_KEY="${2:?Usage: $0 <sitemap-file> <indexnow-key>}"
SITE_HOST="pybuilder.io"

# Extract URLs from sitemap XML
URLS=$(python3 -c "
import xml.etree.ElementTree as ET
tree = ET.parse('$SITEMAP_FILE')
ns = {'s': 'http://www.sitemaps.org/schemas/sitemap/0.9'}
for loc in tree.findall('.//s:loc', ns):
    print(loc.text)
")

if [ -z "$URLS" ]; then
    echo "No URLs found in sitemap"
    exit 1
fi

URL_COUNT=$(echo "$URLS" | wc -l)
echo "Submitting $URL_COUNT URLs to IndexNow"

# Build JSON URL list
URL_JSON=$(echo "$URLS" | python3 -c "
import sys, json
urls = [line.strip() for line in sys.stdin if line.strip()]
print(json.dumps(urls))
")

RESPONSE=$(curl -s -w "\n%{http_code}" -X POST "https://api.indexnow.org/indexnow" \
    -H "Content-Type: application/json; charset=utf-8" \
    -d "{
        \"host\": \"$SITE_HOST\",
        \"key\": \"$INDEXNOW_KEY\",
        \"keyLocation\": \"https://$SITE_HOST/$INDEXNOW_KEY.txt\",
        \"urlList\": $URL_JSON
    }")

HTTP_CODE=$(echo "$RESPONSE" | tail -1)
BODY=$(echo "$RESPONSE" | head -n -1)

echo "IndexNow response: HTTP $HTTP_CODE"
if [ -n "$BODY" ]; then
    echo "$BODY"
fi

case "$HTTP_CODE" in
    200|202) echo "IndexNow submission accepted" ;;
    *) echo "IndexNow submission failed"; exit 1 ;;
esac
