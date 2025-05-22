##  Авторизация через Bearer Token (JWT)

### Пример запроса на аутентификацию

Для получения JWT токена выполните POST-запрос на эндпоинт `/login`:

```bash
curl -X POST "https://virtserver.swaggerhub.com/solonovichlena/Iba/1.0.0/login" \
  -H "Content-Type: application/json" \
  -d '{
    "username": "example@example.com",
    "password": "password"
  }'
