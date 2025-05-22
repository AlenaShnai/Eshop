## 📋 Use Case: Просмотр группы товаров

### №1: Посмотреть выбранную группу товаров

| Параметр           | Значение                                                                 |
|--------------------|--------------------------------------------------------------------------|
| **Актор**          | Все пользователи                                                         |
| **Аутентификация** | Не требуется                                                            |
| **Ресурс**         | `/categorys/{categorys}`                                                 |
| **Метод**          | `GET`                                                                   |

### 📤 Параметры запроса
- **Path параметр**:
  - `categorys` - ID группы товаров
- **Query параметры**:
  - `page=1&limit=10` - пагинация
  - `sort_by=revenue&order=desc` - сортировка

### 📥 Ответы сервера

**200 OK (Успешно):**
```json
{
  "category_id": 1,
  "category_name": "Молоко",
  "category_at": "2024-11-06T18:15:21.783418",
  "_links": {
    "self": {
      "href": "/categorys/1"
    },
    "products": {
      "href": "/categorys/1/products"
    },
    "all_categorys": {
      "href": "/categorys"
    }
  }
}


**400 Not Found (Группа не найдена):**

```json
{
  "error": "not_found",
  "message": "The category group with ID 12345 does not exist."
}
