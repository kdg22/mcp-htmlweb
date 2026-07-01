# Тарификация MCP и бесплатные API

MCP повторяет биллинг REST API htmlweb.ru: тот же `api_key`, те же `limit` и `balans` в ответе.

## Сейчас

| Категория | Сервисы | Списание лимита |
|-----------|-------|-----------------|
| **Бесплатно** | `get_balance`, `validate_inn`, `validate_ogrn`, `validate_requisites`, список сервисов (`tools/list`) | Нет |
| **1 запрос** | org, bank, geo, email (MX), whois, phone, MNP, inflect, num2str, mcc, … | Да |
| **2 запроса** | `verify_email` с `smtp_check=1`, `geo/timezone` без country | Да ×2 |

**20 запросов/сутки** бесплатно на ключ (суммарно все API). Далее — [тарифы](https://htmlweb.ru/user/tariffs.php).

## Рекомендации: как монетизировать «бесплатные» validator/сервисы

Сейчас `Validator` **не списывает** лимит — агент может гонять validate бесконечно. Варианты (продуктовые, без смены кода пока):

### A. Оставить как есть (воронка)
- Бесплатная проверка checksum → платный `lookup_organization` / `lookup_bank`.
- Плюс: низкий порог входа. Минус: нагрузка без выручки.

### B. Льготный MCP-пакет (рекомендуется)
- **100 validate-вызовов/сутки через MCP** на ключ, далее 1 платный запрос за batch.
- Реализация: счётчик в `limit_request` или отдельное поле `mcp_validate_day`.
- REST API validator остаётся полностью бесплатным (обратная совместимость).

### C. Пакет «Бухгалтерия AI»
- Тариф: N₽/мес → 5000 validate + 500 org lookup.
- Продавать в [личном кабинете](https://htmlweb.ru/user/tariffs.php) отдельной строкой.

### D. Ужесточить только MCP
- После 50 бесплатных validate/день через MCP → HTTP 429 с текстом «используйте lookup_organization».
- Не трогать прямой REST — только заголовок `User-Agent` / Referer mcp или внутренний curl с `mcp.htmlweb.ru`.

### E. Объединить validate в один tool (уже сделано)
- `validate_requisites` — один вызов, несколько полей, всё ещё бесплатно, но меньше RPC-шума.

**Практичный старт:** A + E сейчас; через месяц статистики — **B** или **D** по отчёту `/user/#report`.

## Для агентов

1. В начале сессии: `get_balance`.
2. При `limit` &lt; 5: сообщить пользователю ссылку на [баланс](https://htmlweb.ru/user/balans.php).
3. Checksum → `validate_*`; реальные данные → `lookup_*`.
