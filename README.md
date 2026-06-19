# htmlweb.ru MCP Server

**Remote MCP-сервер** для AI-агентов (Cursor, Claude, OpenAI и др.): справочники и проверки по России — организации, банки, geo, IP, email, WHOIS, телефон.

- **Endpoint:** https://mcp.htmlweb.ru/
- **Документация и тест с вашим ключом:** https://htmlweb.ru/user/mcp.php
- **Регистрация / api_key:** https://htmlweb.ru/user/signup.php
- **Карточка для MCP Registry:** https://mcp.htmlweb.ru/server.json

Транспорт: **Streamable HTTP** (JSON-RPC 2.0: `initialize`, `tools/list`, `tools/call`).  
Аутентификация: `Authorization: Bearer YOUR_API_KEY`.

## Быстрый старт

1. [Зарегистрируйтесь](https://htmlweb.ru/user/signup.php) и скопируйте **api_key** из профиля.
2. Проверьте подключение (бесплатно — только `tools/list`, лимит не списывается):

```bash
curl -sS -X POST 'https://mcp.htmlweb.ru/' \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer YOUR_API_KEY' \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}'
```

3. Подключите клиент — см. [examples/](examples/).

**Тариф:** 20 бесплатных запросов в сутки на ключ; далее — [тарифы htmlweb.ru](https://htmlweb.ru/user/tariffs.php).  
Валидация ИНН/ОГРН (`validate_inn`, `validate_ogrn`) — **бесплатно**, лимит не списывается.

## Tools (10)

| Tool | Описание |
|------|----------|
| `lookup_organization` | Организация / ИП по ИНН или ОГРН (ЕГРЮЛ) |
| `lookup_bank` | Банк по БИК (9 цифр) |
| `validate_inn` | Контрольная сумма ИНН (бесплатно) |
| `validate_ogrn` | Контрольная сумма ОГРН/ОГРНИП (бесплатно) |
| `ip_geolocation` | Город, регион, страна по IP |
| `geo_search` | Поиск стран, регионов, городов |
| `geo_distance` | Расстояние между городами (id из geo_search) |
| `verify_email` | Формат, MX; опционально SMTP |
| `domain_whois` | WHOIS домена |
| `phone_location` | Регион и оператор по номеру |

Пример вызова tool:

```bash
curl -sS -X POST 'https://mcp.htmlweb.ru/' \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer YOUR_API_KEY' \
  -d @examples/tool-call-validate-inn.json
```

## Cursor

Скопируйте в `.cursor/mcp.json` (подставьте ключ):

```json
{
  "mcpServers": {
    "htmlweb": {
      "url": "https://mcp.htmlweb.ru/",
      "headers": {
        "Authorization": "Bearer YOUR_API_KEY"
      }
    }
  }
}
```

Готовый файл: [examples/cursor-mcp.json](examples/cursor-mcp.json).

## Claude Desktop

Через [supergateway](https://www.npmjs.com/package/supergateway) — см. [examples/claude-desktop.json](examples/claude-desktop.json).

## OpenAI Responses API

```json
{
  "type": "mcp",
  "server_label": "htmlweb",
  "server_url": "https://mcp.htmlweb.ru/",
  "headers": { "Authorization": "Bearer YOUR_API_KEY" },
  "require_approval": "never"
}
```

## MCP Registry

Метаданные сервера — [server.json](server.json) (имя `ru.htmlweb/mcp`).

Публикация (CLI **mcp-publisher**, не npm):

```bash
# бинарник: https://github.com/modelcontextprotocol/registry/releases
mcp-publisher login dns    # верификация домена htmlweb.ru
mcp-publisher publish server.json
```

Подробнее: [MCP Registry quickstart](https://github.com/modelcontextprotocol/registry/blob/main/docs/modelcontextprotocol-io/quickstart.mdx).

## REST API

Те же данные доступны через REST: https://htmlweb.ru/api/

---

English: hosted MCP server for Russian business/geo lookups (INN, OGRN, BIK, IP geo, email, WHOIS, phone). Sign up at htmlweb.ru for an API key, connect via Streamable HTTP at `https://mcp.htmlweb.ru/`.
