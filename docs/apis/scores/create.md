# Scores POST #create

Create a new score record

### Endpoint

```
http://localhost:3000/api/v1/scores
```

### Required fields

- `player`: a String containing the name of player. It will identify the players.
"Edo" or "edo" or "EDO" should be the same player. But "Ed0" and "Edo" should not.
Do not worry about fuzziness but the name should be case insensitive.
- `score`: a Integer strictly superior to 0 that represents the score.
- `time`: a string representing date and time. This must be in the ISO8601 format

### Sample request

```bash
curl -H "Content-Type: application/json" -X POST -d '{"player":"panda","score":80,"time":"2021-01-31T00:00:00Z"}' http://localhost:3000/api/v1/scores
```

#### Response

```
{
  "score": {
    "id": 6,
    "player": "panda",
    "score": 80,
    "time": "2021-01-31T00:00:00Z"
  }
}
```

The `time` field will be a string in the ISO8601 format.


#### Errors

When a required field is missing, a 422 will be returned with information about the error:


```bash
curl -H "Content-Type: application/json" -X POST -d '{"score":80,"time":"2021-01-31T00:00:00Z"}' http://localhost:3000/api/v1/scores
```

```
{
  "errors": "Player can't be blank"
}
```

If the provided `time` is incompatible with the ISO8601 format, a 422 will be
returned with information about the error:


```bash
curl -H "Content-Type: application/json" -X POST -d '{"player":"panda","score":80,"time":"Mar 21 2021"}' http://localhost:3000/api/v1/scores
```

```
{
  "errors": "time must be iso8601 compliant"
}
```
