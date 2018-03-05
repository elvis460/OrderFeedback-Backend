# Grain Technical Test

Grain Technical Test

# Getting Started

### Install required ruby gems

bundle the ruby gems

```
$ bundle install
```

### Migrate the database

```
$ rails db:setup
```

## The website is working now.

```
$ rails s
```

# Running the tests

```
$ rspec
```

# Orders API

***Now support only orders list and order detail ***

## Get orders list 

### Request ###

`GET /orders`

### Headers ###

`Auth-Token: {token}`

### Params ###

None

### Response ###

**Code:** `200 (OK)` **Content:** `JSON`

```json
{
  "orders": [
  {
    "id": 2,
    "order_id": "ORD1520211697",
    "delivery_date": "2018-03-05",
    "delivery_time": "01:01 - 01:31 AM",
    "feedback_submitted": false,
    "order_items": [
    {
      "order_item_id": 2,
      "name": "Beef Bulgogi Bibimbap"
    },
    {
      "order_item_id": 3,
      "name": "Tofu‑Powered Tabbouleh"
    }]
  },
  {
    "id": 1,
    "order_id": "ORD1520211687",
    "delivery_date": "2018-03-05",
    "delivery_time": "01:01 - 01:31 AM",
    "feedback_submitted": false,
    "order_items": [
    {
      "order_item_id": 1,
      "name": "Laksa Potato Salad"
    }]
  }]
}
```


## Get order detail 

### Request ###

`GET /orders/:order_id`

### Headers ###

`Auth-Token: {token}`

### Params ###

order_id: "ORD1519985528"

### Response ###

**Code:** `200 (OK)` **Content:** `JSON`

```json
{
  "order":
  {
    "order_id": "ORD1520211697",
    "delivery_date": "2018-03-05",
    "delivery_time": "01:01 - 01:31 AM",
    "order_items": [
    {
      "name": "Beef Bulgogi Bibimbap",
      "quantity": 3,
      "total_price": 45
    },
    {
      "name": "Tofu‑Powered Tabbouleh",
      "quantity": 2,
      "total_price": 18
    }]
  }
}
```

**Code:** `404 (NotFound)` **Content:** `JSON`

```json
{
 "status": "Failed",
 "msg": "Order_id Not Found"
}
```

## Post Order Feedbacks

### Request ###

`POST /orders/:order_id/feedbacks`

### Headers ###

`Auth-Token: {token}`

### Params ###

order_id: "ORD1520211697"

```json
{
  "feedbacks": [
  {
    "ratable_id": 1,
    "ratable_type": "DeliveryOrder",
    "rating": 1,
    "comment": "Good"
  },
  {
    "ratable_id": 1,
    "ratable_type": "OrderItem",
    "rating": -1,
    "comment": "So So"
  }
  {
    "ratable_id": 2,
    "ratable_type": "OrderItem",
    "rating": 1,
    "comment": "Awesome"
  }]
}
```

### Response ###

**Code:** `200 (OK)` **Content:** `JSON`

```json
{
  "status": "OK"
}
```

**Code:** `401 (BadRequest)` **Content:** `JSON`

```json
{
  "status": "Failed",
  "msg": "Required attribute empty"
}
```


## Get Order Feedbacks

### Request ###

`GET /orders/:order_id/feedbacks`

### Headers ###

`Auth-Token: {token}`

### Params ###

order_id: "ORD1519985528"

### Response ###

**Code:** `200 (OK)` **Content:** `JSON`

```json
{
  "feedbacks": [
  {
    "ratable_id": 1,
    "ratable_type": "DeliveryOrder",
    "rating": 1,
    "comment": "Good"
  },
  {
    "ratable_id": 1,
    "ratable_type": "OrderItem",
    "rating": -1,
    "comment": "So So"
  }
  {
    "ratable_id": 2,
    "ratable_type": "OrderItem",
    "rating": 1,
    "comment": "Awesome"
  }]
}
```