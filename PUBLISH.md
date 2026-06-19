# Публикация в MCP Registry

## GitHub push — вам ничего не нужно

Репозиторий уже на https://github.com/kdg22/mcp-htmlweb (push делали из Cursor).  
Локально меняете файлы → `git push` только если правили README/server.json в `mcp-htmlweb/`.

---

## Registry: DNS через Яндекс (имя `ru.htmlweb/mcp`)

**На Яндекс DNS команды не нужны** — только одна TXT-запись в веб-панели.  
`mcp-publisher` уже на **RuWebServer** в `/var/www/htmlweb/data/www/htmlweb.ru/mcp/`.

### Шаг 1 — TXT в Яндекс 360 / Connect

Зона **htmlweb.ru** → добавить запись:

| Поле | Значение |
|------|----------|
| Тип | **TXT** |
| Имя / хост | **@** (корень зоны, **не** `_mcp-auth`, **не** `www`) |
| Значение | см. ниже — строка целиком |

```
v=MCPv1; k=ed25519; p=EBATTjHaIim+J3LP9EZ0gb6eqVHPonSpSrokj4YNo8M=
```

Сохранить. Подождать 5–30 мин (иногда до 2 ч).

Проверка с RuWeb:
```bash
dig +short TXT htmlweb.ru @8.8.8.8
```
В ответе должна быть подстрока `v=MCPv1`.

### Шаг 2 — publish на сервере

```bash
ssh RuWebServer
sudo -u htmlweb /var/www/htmlweb/data/www/htmlweb.ru/mcp/publish-registry.sh
```

Или попросить агента выполнить после появления TXT.

---

## Альтернатива без DNS: GitHub (`io.github.kdg22/mcp-htmlweb`)

1. В `server.json` сменить `"name"` на `io.github.kdg22/mcp-htmlweb`.
2. На своём ПК: скачать [mcp-publisher](https://github.com/modelcontextprotocol/registry/releases), затем:
   ```bash
   mcp-publisher login github
   ```
   Откроется код устройства — войти в GitHub как **kdg22**.
3. `mcp-publisher publish server.json`

DNS Яндекса не трогаем; в каталоге имя будет `io.github.kdg22/...`, не `ru.htmlweb/mcp`.

---

## CLI

Бинарник: https://github.com/modelcontextprotocol/registry/releases (не npm).

После publish: https://registry.modelcontextprotocol.io/
