# Публикация в MCP Registry

1. Скачать **mcp-publisher**: [GitHub releases](https://github.com/modelcontextprotocol/registry/releases) или `brew install mcp-publisher`.
2. DNS-верификация домена htmlweb.ru:
   ```bash
   mcp-publisher login dns
   ```
3. Из этого каталога:
   ```bash
   mcp-publisher publish server.json
   ```
4. Проверить: https://registry.modelcontextprotocol.io/ (поиск `ru.htmlweb/mcp`).
5. GitHub topics (вручную на https://github.com/kdg22/mcp-htmlweb/settings): `mcp`, `model-context-protocol`, `russia`, `inn`, `egrul`, `fintech`, `cursor`.

После изменения tools — bump `version` в `server.json`, push, republish.
