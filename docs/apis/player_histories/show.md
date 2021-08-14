# PlayerHistories GET #show

Get a detailed history of a single player

### Endpoint

```
http://localhost:3000/api/v1/player_histories/:name
```

where `name` is a string of the player's name.

### Sample request

```bash
curl -X GET "http://localhost:3000/api/v1/player_histories/jacob"
```

#### Response

```
{
  "player_history": {
    "top_score": 20,
    "low_score": 1,
    "average_score": 8.666666666666666,
    "scores": [
      {
        "id": 1,
        "player": "jacob",
        "score": 1,
        "time": "2021-08-13T03:39:25Z"
      },
      {
        "id": 2,
        "player": "jacob",
        "score": 5,
        "time": "2021-02-02T00:00:00Z"
      },
      {
        "id": 3,
        "player": "jacob",
        "score": 20,
        "time": "2020-01-01T00:00:00Z"
      }
    ]
  }
}
```

- `top_score` is the highest score a player has achieved
- `low_score` is the lowest score a player has achieved
- `average_score` is the average score a player has achieved
- `scores` is an array of all related score records for ths player


#### Errors

When the record associated with the `name` does not exist, an empty body JSON body
will be returned with a 404 status code.
