# Тарификация MCP

MCP вызывает **тот же** биллинг, что REST: `Get::apiParam` → `Class::pub_*` (`/json/{obj}/{m}`).

## Баланс (Money, без отдельных MCP-tools)

| Действие | Вызов |
|----------|--------|
| Остаток | `api_call` → `money` / `get_limit` (`Money::pub_get_limit`) |
| Купить пакет с баланса | `api_call` → `money` / `set_limit` + `set_limit=N` (`Money::pub_set_limit`) |

Пополнение рублями (карта/крипто/rebill) — MCP tools `create_topup_*`, `bind_payment_card`, `charge_saved_card`, `acp_checkout` (Robokassa/Bybit), не методы Money.

## MCP tools без списания лимита запросов

`register_agent`, `get_pricing`, `api_catalog`, `tools/list`; `money/get_limit` и `money/set_limit` тоже не тратят «запрос справочника» на сам вызов.

## Данные

`mnp`, `geo`, `service`, `convert`, `calendar`, `mail`, `validator` — как у REST; каталог: `api_catalog`.

## Бесплатная суточная квота

- Подтверждённый аккаунт сайта (`adm≠0`): N/сутки.
- Ключ `register_agent` (`adm=0`): без бесплатной квоты.
- Антиабьюз: ≤2 `register_agent`/сутки с IP; повтор за день — тот же ключ; ≤3 ключа агента с IP.

## Боты

Корневой `.htaccess` htmlweb.ru: AI-UA **без** api_key/Bearer → **403 Forbidden** (не редирект на mcp). MCP — для клиентов с ключом/MCP, не свалка краулеров.
