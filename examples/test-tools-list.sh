#!/usr/bin/env bash
# Usage: API_KEY=xxx ./test-tools-list.sh
set -euo pipefail
KEY="${API_KEY:-YOUR_API_KEY}"
curl -sS -X POST 'https://mcp.htmlweb.ru/' \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer ${KEY}" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}'
