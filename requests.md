# Форматы запросов

## Логин

Для операторы
url `/login/operator/`
```json
{
    "login": "your-login", // text
    "pass": "your-pass" //text
}
```

Для курера
url `/login/courier/`
```json
{
    "login": "your-login", // text
    "pass": "your-pass" //text
}
```

## Курьеры

Все записи
url `/couriers/list/`
json не имеет значения

Получит запись по id
url `/couriers/id/`
```json
{
    "id": id
}
```

Добавть нового курьера
url `/couriers/add/`
```json
{
    "name": "full-name", // полное имя
    "login": "login", 
    "password": "password",
    "token": "token" // токен андроид устройства, может быть уберу потом
}
```

Обновть данные курьера
url `/couriers/update/`
```json
{
    "id": id,
    "name": "full-name",
    "login": "login",
    "password": "password",
    "token": "token" // токен андроид устройства, может быть уберу потом
}
```

Удалить курьера
url `/couriers/delete/`
```json
{
    "id": id
}
```

## Орераторы

Все записи
url `/operators/list/`
json не имеет значения

Получит запись по id
url `/operators/id/`
```json
{
    "id": id
}
```

Добавть нового oрераторa
url `/operators/add/`
```json
{
    "name": "full-name", // полное имя
    "login": "login", 
    "password": "password",
}
```

Обновть данные oрераторa
url `/operators/update/`
```json
{
    "id": id,
    "name": "full-name",
    "login": "login",
    "password": "password",
}
```

Удалить oрераторa
url `/operators/delete/`
```json
{
    "id": id
}
```

## Заказы

Все записи
url `/oreders/list/`
json не имеет значения

Получит запись по id
url `/oreders/id/`
```json
{
    "id": id
}
```

Добавть новый заказ
url `/oreders/add/`
```json
{
    "courierid": id,
    "operatorid": id,
    "created_time": "data",
    "start_delivery_time": "date",
    "end_delivery_time": "date",
    "delivery_address": "adress"
}
```

Обновть данных заказа
url `/orders/update/`
```json
{
    "id": id,
    "courierid": id,
    "operatorid": id,
    "created_time": "data",
    "start_delivery_time": "date",
    "end_delivery_time": "date",
    "delivery_address": "adress"
}
```

Удалить заказ
url `/orders/delete/`
```json
{
    "id": id
}
```

## Информация о заказах

Все записи заказа
url `/orders-info/list/`
```json
{
    "orderId": id
}
```

Получит запись по id
url `/oreders-info/id/`
```json
{
    "id": id
}
```

Добавть новый товар в заказ
url `/oreders-info/add/`
```json
{
    "orderid": id,
    "name": "name",
    "price": "price",
    "count_": "count",
}
```

Обновть данных товары в заказе 
url `/orders-info/update/`
```json
{
    "id": id,
    "orderid": id,
    "name": "name",
    "price": "price",
    "count_": "count",
}
```

Удалить товар в заказе
url `/orders-info/delete/`
```json
{
    "id": id
}
```

## Товары

Все записи товаров
url `/products/list/`

Получит запись по id
url `/products/id/`
```json
{
    "id": id
}
```

Добавть новый товар 
url `/products/add/`
```json
{
    "name": "name",
    "price": "price",
}
```

Обновть данных товары 
url `/products/update/`
```json
{
    "id": id,
    "name": "name",
    "price": "price",
}
```

Удалить товар 
url `/products/delete/`
```json
{
    "id": id
}
```