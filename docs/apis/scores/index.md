# Scores GET #index

Get a list of score records. By default, this endpoint will return up to 20
score records (currently in an unordered fashion).

### Endpoint

```
http://localhost:3000/api/v1/scores
```

### Optional fields

- `after`: an ISO8601 compliant datetime string. Any score records with a `time`
strictly **after** this datetime will be returned.
- `before`: an ISO8601 compliant datetime string. Any score records with a `time`
strictly **before** this datetime will be returned.
- `players`: a list of players to filter results by
- `page`: an integer indicating the page of results to return. By default, results
are limited to 20 results. If you would like to retrieve records after 20, you
will need to specify a page greater than 1. Default is 1.
- `per`: an integer indicating the size of the pages. There is currently no max
value for this, although that is something that should be added in the future.
Default is 20.

### Sample request

```bash
curl -X GET "http://localhost:3000/api/v1/scores?before=2021-03-01&after=2021-01-01&players[]=Jacob&players[]=otheR"
```

#### Response

```
{
  "scores": [
    {
      "id": 2,
      "player": "jacob",
      "score": 5,
      "time": "2021-02-02T00:00:00Z"
    },
    {
      "id": 4,
      "player": "other",
      "score": 20,
      "time": "2021-01-31T00:00:00Z"
    }
  ]
}
```

The `time` field will be a string in the ISO8601 format.


#### Errors

If the provided values for either `before` or `after` is incompatible with the
ISO8601 format, a 422 will be returned with information about the error:


```bash
curl -X GET "http://localhost:3000/api/v1/scores?before=2021-03-01&after=1628927779&players[]=Jacob&players[]=otheR"
```

```
{
  "errors": "`after` must be iso8601 compliant"
}
```
