# htmlweb.ru MCP Server

**Remote MCP** для Cursor, Claude, OpenAI: справочники и проверки по России.

- **Endpoint:** https://mcp.htmlweb.ru/
- **Тест с ключом:** https://htmlweb.ru/user/mcp.php
- **Registry:** https://mcp.htmlweb.ru/server.json · [каталог MCP](https://registry.modelcontextprotocol.io/)
- **Agentic Commerce:** [commerce.json](https://mcp.htmlweb.ru/commerce.json) · [llm.txt](https://mcp.htmlweb.ru/llm.txt)
- **Тарифы / бесплатные API:** [PRICING.md](PRICING.md)

## Быстрый старт

1. [Регистрация](https://htmlweb.ru/user/signup.php) → `api_key` в профиле.
2. Проверка (бесплатно):

```bash
curl -sS -X POST 'https://mcp.htmlweb.ru/' \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer YOUR_API_KEY' \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}'
```

3. Cursor — [examples/cursor-mcp.json](examples/cursor-mcp.json).

**20 запросов/сутки** бесплатно (платные сервисы); validator и `get_balance` — без списания.

## Agentic Commerce (v1.2)

Агент платит **сам** (ключ оператора в MCP). Конечному пользователю регистрация не нужна.

| Сервис | Назначение |
|--------|------------|
| `get_pricing` | Тарифы и пакеты |
| `purchase_requests` | Купить пакет с баланса ключа |
| `create_topup_card` | Robokassa, карта, от 50₽ |
| `create_topup_crypto` | Крипто, от 500₽ |

Цикл: `get_balance` → `create_topup_*` → `purchase_requests` → `lookup_*`.

## Сервисы (29)

| Сервис | Назначение | Лимит |
|------|------------|-------|
| `get_balance` | Остаток запросов и баланс ₽ | бесплатно |
| `get_pricing` | Тарифы Agentic Commerce | бесплатно |
| `purchase_requests` | Пакет запросов с баланса ключа | бесплатно |
| `create_topup_card` | Пополнение ключа, карта | бесплатно |
| `create_topup_crypto` | Пополнение ключа, крипто | бесплатно |
| `lookup_organization` | ЕГРЮЛ/ИП по ИНН/ОГРН | 1 |
| `lookup_bank` | Банк по БИК | 1 |
| `validate_requisites` | Пакет checksum: ИНН, КПП, БИК, р/с, к/с, ОГРН | бесплатно |
| `validate_inn` / `validate_ogrn` | Контрольная сумма | бесплатно |
| `inflect_russian` | Склонение слова | 1 |
| `number_to_words_rub` | Сумма прописью | 1 |
| `parse_text_date` | «завтра», «15 марта» → дата | 1 |
| `lookup_mcc` | MCC → категория терминала | 1 |
| `russian_holidays` | Праздники РФ из `/json/calendar/list` | 1 |
| `calendar_daytype` | Рабочий/выходной/перенос | 1 |
| `calendar_workdays` | Число рабочих дней в периоде | 1 |
| `calendar_networkdays` | NETWORKDAYS Excel с переносами | 1 |
| `calendar_nearest` | Ближайший праздник, дней до выходного | 1 |
| `verify_email` | Email MX/SMTP | 1–2 |
| `phone_location` | Оператор DEF | 1 |
| `phone_mnp_operator` | Оператор после MNP | 1 |
| `ip_geolocation` | Geo по IP | 1 |
| `ip_spam_reputation` | IP в spam-базах | 1 |
| `geo_search` | Поиск city id | 1 |
| `geo_distance` | Расстояние км | 1 |
| `nearest_city` | Города у GPS | 1 |
| `timezone_and_sun` | Рассвет/закат | 1 |
| `transliterate` | Транслит | 1 |
| `detect_text_language` | Язык текста | 1 |
| `card_bin_lookup` | BIN карты | 1 |
| `car_brand_model` | Марки/модели авто | 1 |
| `domain_whois` | WHOIS домена | 1 |

## Registry

Карточка **ru.htmlweb/mcp** v1.2.0: [registry.modelcontextprotocol.io](https://registry.modelcontextprotocol.io/) · метаданные [server.json](https://mcp.htmlweb.ru/server.json).

---

English: hosted MCP for Russian business data (INN, OGRN, BIK, geo, email, WHOIS). Bearer api_key from htmlweb.ru.
