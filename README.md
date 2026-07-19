# htmlweb.ru MCP Server

**Remote MCP** для Cursor, Claude, OpenAI: справочники и проверки по России через **штатный REST** `/json/{obj}/{m}`.

- **Endpoint:** https://mcp.htmlweb.ru/
- **Каталог методов:** MCP tool `api_catalog` · [commerce.json](https://mcp.htmlweb.ru/commerce.json) · [llm.txt](https://mcp.htmlweb.ru/llm.txt)
- **Тест с ключом:** https://htmlweb.ru/user/mcp.php
- **Registry:** https://mcp.htmlweb.ru/server.json
- **Тарифы:** [PRICING.md](PRICING.md)

## Быстрый старт

1. Подключите MCP **без** ключа → агент вызывает `register_agent` → сохраняет `api_key`.
2. Или [регистрация на сайте](https://htmlweb.ru/user/signup.php) → свой `api_key` в `Authorization: Bearer`.
3. Данные: `api_catalog` → `api_call` с `obj` + `m`.
4. Баланс / пакет: `api_call` `money/get_limit` и `money/set_limit` (`Money::pub_*`).

## MCP tools (v1.6.2)

| Tool | Назначение |
|------|------------|
| `register_agent` | Выдать `api_key` (до 2/сутки с IP) |
| `api_catalog` | Каталог классов и `pub_*` |
| `api_call` | `Get::apiParam` → `Class::pub_*` (= `/json/{obj}/{m}`) |
| `get_pricing` | Тарифы / commerce |
| `bind_payment_card` / `charge_saved_card` | Привязка карты + rebill |
| `create_topup_card` / `create_topup_crypto` | Пополнение рублями |
| `acp_checkout` | ACP create/complete |

Баланс **не** отдельными tools: `api_call obj=money m=get_limit` · пакет: `m=set_limit` + `set_limit=1000`.

## Примеры

```json
{"name":"api_call","arguments":{"obj":"money","m":"get_limit"}}
{"name":"api_call","arguments":{"obj":"money","m":"set_limit","set_limit":1000}}
{"name":"api_call","arguments":{"obj":"mnp","m":"phone","phone":"79001234567"}}
```

Классы: `calendar`, `convert`, `geo`, `mail`, `mnp`, `money`, `service`, `validator`.

## Registry

Карточка **ru.htmlweb/mcp** v1.6.2.
