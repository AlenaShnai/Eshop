@startuml E-commerce Container Diagram
!include <C4/C4_Container>


title Контейнерная диаграмма интернет-магазина (SOA)


' === Персоны ===
Person(guest, "Гость", "Просматривает товары")
Person(customer, "Зарегистрированный пользователь", "Совершает покупки")
Person(admin, "Администратор", "Управляет системой")
Person(courier, "Курьер", "Обновляет статусы доставки")
Person(moderator, "Модератор", "Проверяет отзывы")


' === Внешние системы ===
System_Ext(payment_gw, "PayPal", "Внешняя платежная система")
System_Ext(delivery_api, "Внешняя система доставки", "Яндекс.Доставка")
System_Ext(email_service, "Unisender", "Email/SMS-рассылки")
System_Ext(cdn, "CDN", "Яндекс CDN")


' === Основная система ===
System_Boundary(shop, "Интернет-магазин") {
    ' --- Фронтенд ---
    Container(web_app, "Веб-приложение", "React", "SPA интерфейс")
    Container(mobile_app, "Мобильное приложение", "Java/Spring MVC")
   
    ' --- Сервисы ---
    Container(api_gateway, "API Gateway", "Kong", "Маршрутизация")
    Container(auth_service, "Auth Service", "Keycloak", "Аутентификация")
   
    Container(catalog_service, "Каталог", "Java/Spring Boot", "Управление товарами")
    Container(cart_service, "Корзина", "Java/Spring Boot", "Временное хранение")
    Container(orders_service, "Заказы", "Java/Spring Boot", "Обработка заказов")
    Container(payments_service, "Платежи", "Java/Spring Boot", "Обработка платежей")
    Container(delivery_service, "Доставка", "Java/Spring Boot", "Логистика")
    Container(reviews_service, "Отзывы", "Java/Spring Boot", "Модерация контента")
   
    ' --- Инфраструктура ---
    ContainerDb(postgres, "Основная БД", "PostgreSQL", "Хранение данных")
    ContainerDb(mongo, "NoSQL БД", "MongoDB", "Хранение отзывов")
    Container(redis, "Кеш", "Redis", "Кеширование данных")
    Container(kafka, "Message Broker", "Kafka", "Асинхронные события")
    }


' === Связи ===
' Пользователи
guest --> web_app : "Просмотр товаров\nHTTPS"
guest --> mobile_app : "Просмотр товаров\nHTTPS"
customer --> web_app : "Покупки\nHTTPS"
customer --> mobile_app : "Покупки\nHTTPS"
admin --> web_app : "Управление\nHTTPS"
courier --> mobile_app : "Обновление статусов\nHTTPS"
moderator --> web_app : "Модерация\nHTTPS"


' Фронтенд
web_app --> api_gateway : "API запросы\nJSON/HTTPS"
mobile_app --> api_gateway : "API запросы\nJSON/HTTPS"
web_app --> cdn : "Загрузка статики\n(JS/CSS/изображения)"


' API Gateway
api_gateway --> auth_service : "Проверка токенов\nJWT"
api_gateway --> catalog_service : "Запросы товаров\nJSON/HTTPS API"
api_gateway --> cart_service : "Управление корзиной\nJSON/HTTPS API"
api_gateway --> orders_service : "Оформление заказов\nJSON/HTTPS API"
api_gateway --> reviews_service : "Работа с отзывами\nJSON/HTTPS API"


' Сервисы
catalog_service --> postgres : "Чтение/запись\nJDBC"
cart_service --> redis : "Хранение данных\nRedis Protocol"
orders_service --> postgres : "Хранение заказов\nJDBC"
payments_service --> payment_gw : "Обработка платежей\nAPI"
delivery_service --> delivery_api : "Расчет доставки\nAPI"
reviews_service --> mongo : "Хранение отзывов\nMongoDB Protocol"
auth_service --> postgres : "Хранение пользователей\nJDBC"
delivery_service --> postgres : "Хранение инфо по доставке\nJDBC"
payments_service --> postgres : "Хранение оплат\nJDBC"


' События и интеграции
orders_service --> kafka : "События заказов\nAvro"
delivery_service --> kafka : "Статусы доставки\nAvro"
reviews_service --> kafka : "Статусы отзывов\nAvro"
kafka --> email_service : "Триггерные письма\nAPI"
catalog_service --> redis : "Кеширование\nRedis Protocol"
orders_service --> payments_service : "Инициация платежа\ngRPC"
orders_service --> delivery_service : "Создание доставки\ngRPC"


' Стилизация
skinparam defaultTextAlignment center
UpdateElementStyle(person, $bgColor="#08427b", $fontColor="white")
UpdateElementStyle(system, $bgColor="#1168bd", $fontColor="white")
UpdateElementStyle(container, $bgColor="#438dd5", $fontColor="white")
UpdateElementStyle(containerDb, $bgColor="#f5da81", $fontColor="black")
@enduml

