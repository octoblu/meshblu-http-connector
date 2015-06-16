# meshblu-http-connector

Gateblu connector to make HTTP requests. Uses the [request](https://github.com/request/request) module.

#### Message Schema
```json
{
  "options": {
    "method": "GET",
    "url": "http://192.168.0.5/status"
  }
}
```

#### Response
```json
{
  "devices": ["*"],
  "topic": "http-response",
  "payload": {
    "statusCode": 200,
    "body": {
      "online": true
    }
  }
}
```
