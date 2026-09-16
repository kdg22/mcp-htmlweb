# Календарь htmlweb — материалы для публикации (без исходников)

> Подготовлено 2026-09-16. Публиковать эти тексты можно на GitHub (README репозитория только с релизами),
> в каталогах (Softpedia, Softportal, Softodrom), на AlternativeTo и в PR winget-pkgs.
> Исходный код не публикуется; здесь — описание, API и примеры вызовов.

## Тексты

### Краткое описание (до 500 знаков)

Календарь htmlweb — часы с календарём на панели задач Windows 10/11 рядом с треем.
Клик по часам открывает месяц и ближайшие события из Google Календаря и календаря htmlweb:
события, дни рождения, праздники. Важные встречи предупреждают заранее (карточка со звуком,
«за сколько» настраивается). Входящим звонкам и СМС на телефоне (СМС-шлюз htmlweb) — карточка
на компьютере с именем, фото и заметкой из контактов Google. Настройка — в самом окне.
Сайт и программа видят один день: событие, созданное где угодно, попадает в Google на телефон.

### Полное описание

Программа для Windows «Календарь htmlweb» заменяет часы в правом нижнем углу на часы с календарём:
клик открывает сетку месяца и список ближайших событий. Источники — Google Календарь (OAuth-вход,
выбор календарей галочками) и календарь htmlweb (ключ из профиля). События редактируются прямо в окне
и попадают в Google на телефон; события с телефона приходят на компьютер.

Возможности:
- Часы у трея: цифровые с секундами / аналоговые / только трей; масштаб часов и окна под системный шрифт.
- Список ближайших событий с группировкой по дням, прошедшие — серые; дни рождения 🎂, праздники, церковные даты.
- «Важное событие» — карточка со звуком заранее: «за сколько предупреждать» настраивается (0–1440 минут).
- Карточка входящего звонка/СМС: СМС-шлюз htmlweb на Android присылает номер, программа показывает фото,
  имя, возраст и заметку из копии контактов Google на этом компьютере.
- Карточки от своих сервисов через API: заголовок, текст, картинка, до двух кнопок.
- Устойчивость: при недоступности Google события берутся со снимка сервера, несохранённые события
  досылаются автоматически, программа обновляется сама.

Сайт https://htmlweb.ru/calendar/app.php работает с теми же данными.

### Ключевые слова

google календарь для windows, календарь в часах windows, календарь на панели задач,
напоминания google calendar, дни рождения из google, карточка звонка на компьютер, sms шлюз android windows

## Ссылки

- Страница и скачивание: https://htmlweb.ru/calendar/about.php#download
- Прямая ссылка: https://htmlweb.ru/calendar/win/HtmlwebCalendar.exe
- Веб-календарь: https://htmlweb.ru/calendar/app.php
- Политика конфиденциальности: https://htmlweb.ru/calendar/privacy.php
- Условия: https://htmlweb.ru/calendar/about.php#terms

## SmartScreen (для описаний установки)

Файл распространяется без сертификата подписи кода. Если Windows покажет синее окно
«Система защитила ваш компьютер»: нажмите «Подробнее» → «Выполнить в любом случае».

## API и примеры использования

База: `https://htmlweb.ru/json/deskcal/МЕТОД` (или `https://htmlweb.ru/api.php?obj=deskcal&m=МЕТОД`).
Параметры GET или POST, `?json` — формат ответа. Авторизация: `api_key` из профиля htmlweb или сессия сайта.
Автосправка по каждому методу: `https://htmlweb.ru/api/deskcal/notify_push/?help`.

### Отправить карточку на рабочий стол пользователя

```
GET https://htmlweb.ru/json/deskcal/notify_push?json
    &api_key=КЛЮЧ_ИЗ_ПРОФИЛЯ
    &title=Заказ собран
    &text=Можно забирать с 10:00
    &image=https://example.com/logo.png
    &btn1_title=Открыть заказ&btn1_url=https://example.com/order/123
    &btn2_title=На карте&btn2_url=https://example.com/map
    &important=1
```
Ответ: `{"status":200,"message":"отправлено","item":{"id":…,"title":…,…}}`.
`important=1` — карточка не исчезает сама. Кнопки открывают только http(s).

### Прочитать события за период

```
GET https://htmlweb.ru/json/deskcal/events?json&api_key=КЛЮЧ&from=2026-09-01 00:00:00&to=2026-09-30 23:59:59
```
Ответ: `{"status":200,"from":…,"to":…,"events":[{…,"uid","t0","t1","allday","payload_json"}]}`.
`uid` вида `g:календарь:событие` — встреча из Google; `payload_json` `{"important":1}` — важная.

### Создать/изменить событие (уходит и в Google, если подключён)

```
POST https://htmlweb.ru/json/deskcal/event_save
Content-Type: application/x-www-form-urlencoded

api_key=КЛЮЧ&title=Совещание&t0=2026-09-10 10:00:00&t1=2026-09-10 11:00:00
&location=Офис&description=Повестка&allday=0&cal=СЕМЕЙНЫЙ_КАЛЕНДАРЬ@group.calendar.google.com
```
`cal` — куда писать при создании (id календаря Google); без него — основной календарь.
Правка: добавить `id`. Ответ содержит объект `event`.

### Удалить событие

```
GET https://htmlweb.ru/json/deskcal/event_del?json&api_key=КЛЮЧ&id=123
GET https://htmlweb.ru/json/deskcal/event_del?json&api_key=КЛЮЧ&uid=g:календарь:событие
```

### Лента карточек (для своих клиентов, аналог пуша)

```
GET https://htmlweb.ru/json/deskcal/notify?json&api_key=КЛЮЧ&unseen=1&limit=10
GET https://htmlweb.ru/json/deskcal/notify_read?json&api_key=КЛЮЧ&id=123
```
`notify?unseen=1` — короткий запрос (так программа Windows забирает карточки раз в 10 секунд);
`notify_wait?after=ID` — длинный запрос до 22 с, оставлен для совместимости.

## winget (PR в microsoft/winget-pkgs)

Черновик манифестов — в папке `winget/` этого каталога: положить файлы в
`manifests/h/Htmlweb/Calendar/1.1.0/` своего форка и открыть PR. Перед подачей проверить
актуальную схему (`wingetcreate new https://htmlweb.ru/calendar/win/HtmlwebCalendar.exe`
сделает заготовку сам). SHA256 текущего exe:
`3e209d7b1b9ce2bb448bd21fd558d27cd65aa5b6a16dc193beddc17cbab50920`

## AlternativeTo

Создать запись «Календарь htmlweb» (platform: Windows), в поле «alternatives to» указать:
Google Calendar (desktop), Rainlendar, MiniCalendar. Категория: Calendar & Time.
