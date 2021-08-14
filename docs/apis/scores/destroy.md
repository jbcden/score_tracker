# Scores DELETE #destroy

Destroy a specific score record by providing its `id`

### Endpoint

```
http://localhost:3000/api/v1/scores/:id
```

### Sample request

```bash
curl -X DELETE http://localhost:3000/api/v1/scores/6
```

#### Response

The response will be an empty JSON body with a 200 status.

```
{}
```

#### Errors

When the `id` cannot be found, a 404 status will be returned with an empty
JSON body.


```bash
curl -X DELETE http://localhost:3000/api/v1/scores/100
```

```
{}
```
