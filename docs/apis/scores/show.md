# Scores GET #show

Get details of a specific score record:

### Endpoint

```
http://localhost:3000/api/v1/scores/:id
```

`id` is a numerical id identifying a score record. This value will be returned
as `id` from requests to create score records as well as from the index endpoint.

### Sample request

```bash
curl -X GET http://localhost:3000/api/v1/scores/2
```

#### Response

```
{
  "score": {
    "id": 2,
    "player": "jacob",
    "score": 5,
    "time": "2021-02-02T00:00:00Z"
  }
}
```

The `time` field will be a string in the ISO8601 format.

#### Errors

When the record associated with the `id` does not exist, an empty body JSON body
will be returned with a 404 status code.
