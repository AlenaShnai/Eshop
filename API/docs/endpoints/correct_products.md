📋 Use Case: Изменение товара в каталоге
№1: Изменить количество товара в 
Параметр	Значение
Актор	Все пользователи
Аутентификация	Не требуется
Ресурс	/categorys/{categorys}
Метод	GET


### 📤 Пример запроса
```http
PATCH /api/products/55 HTTP/1.1
Host: elena-Eshop.com
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI
Content-Type: application/json

{
  "product_name": "Молоко 3,2% Ультра",
  "start_price": 3.80
}
```

### 📥 Примеры ответов

**200 OK**
```json
{
  "product_id": 5,
  "category": 1,
  "product_name": "Молоко 3,2% Ультра",
  "start_price": 3.50,
  "SKU": "15648",
  "stockQuantity": 50.000,
  "createAt": "2025-05-10T12:34:56.789123",
  "updateAt": "2025-05-10T12:34:56.789123"
}
```

**404 Not Found**
```json
{
  "error": "not_found",
  "message": "The product with ID 55 does not exist."
}
```

**400 Bad Request**
```json
{
  "error": "Validation error",
  "details": {
    "product_name": "This field is required.",
    "start_price": "Must be a positive number."
  }
}
```

**401 Unauthorized**
```json
{
  "error": "Unauthorized",
  "message": "You must authenticate to access this resource."
}
```

**403 Forbidden**
```json
{
  "error": "Forbidden",
  "message": "You do not have permission to perform this action."
}
```
