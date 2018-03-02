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

### Params ###

None

### Response ###

**Code:** `200 (OK)` **Content:** `JSON`

```json
{
 "orders":[
  {
   "order_id":"ORD1519985528",
   "delivery_date":"2018-03-02",
   "delivery_time":"10:12 - 10:42 AM"
  },
  {
   "order_id":"ORD1519985538",
   "delivery_date":"2018-03-02",
   "delivery_time":"10:12 - 10:42 AM"
  }
 ]
}
```


## Get order detail 

### Request ###

`GET /orders/:order_id`

### Params ###

	order_id: "ORD1519985528"

### Response ###

**Code:** `200 (OK)` **Content:** `JSON`

```json
{
 "order":{
  "order_id":"ORD1519985528",
  "delivery_date":"2018-03-02",
  "delivery_time":"10:12 - 10:42 AM",
  "order_items":[
   {
    "name":"Laksa Potato Salad",
    "quantity":1,
    "total_price":10
   }
  ]
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