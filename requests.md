# Форматы запросов

## Логин

Для операторы
```json
{
    "type": "login-operator",
    "login": "your-login", // text
    "pass": "your-pass" //text
}
```

Для курера
```json
{
    "type": "login-courier",
    "login": "your-login", // text
    "pass": "your-pass" //text
}
```

## Курьеры

Все записи
```json
{
    "type": "couriers-list"
}
```

Добавть нового курьера
```json
{
    "type": "add-courier",
    "name": "full-name", // полное имя
    "login": "login", 
    "password": "password",
    "token": "token" // токен андроид устройства, может быть уберу потом
}
```

Обновть данные курьера
```json
{
    "type": "update-courier",
    "id": id,
    "name": "full-name",
    "login": "login",
    "password": "password",
    "token": "token" // токен андроид устройства, может быть уберу потом
}
```

Удалить курьера
```json
{
    "type": "delete-courier",
    "id": id
}
```
