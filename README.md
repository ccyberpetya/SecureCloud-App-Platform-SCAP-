# SCAP Project (SecureCloud App Platform)

## 📌 Описание

Данный проект представляет собой веб-приложение на базе FastAPI с использованием PostgreSQL, полностью контейнеризированное с помощью Docker и управляемое через Docker Compose.

Проект демонстрирует практику DevOps-подхода, включая:

* Контейнеризацию (Docker)
* Работу с базой данных (PostgreSQL)
* ORM (SQLAlchemy)
* Миграции базы данных (Alembic)
* Проверку безопасности (Trivy)

---

## 🏗 Архитектура

```
Клиент → FastAPI → SQLAlchemy → PostgreSQL
```

---

## 🚀 Запуск проекта

### 1. Клонирование репозитория

```bash
git clone <repo_url>
cd scap-project
```

---

### 2. Настройка переменных окружения

Создай файл `.env` на основе шаблона:

```bash
cp .env.example .env
```

Отредактируй `.env`:

```env
POSTGRES_USER=your_user
POSTGRES_PASSWORD=your_password
POSTGRES_DB=your_db
DATABASE_URL=postgresql://your_user:your_password@db:5432/your_db
```

---

### 3. Запуск приложения

```bash
docker compose up --build
```

---

### 4. Применение миграций

```bash
docker compose exec app alembic upgrade head
```

---

## 📡 API эндпоинты

| Метод  | Endpoint    | Описание             |
| ------ | ----------- | -------------------- |
| GET    | /           | Проверка сервиса     |
| GET    | /users      | Получить список      |
| POST   | /users      | Создать пользователя |
| GET    | /users/{id} | Получить по ID       |
| PUT    | /users/{id} | Обновить             |
| DELETE | /users/{id} | Удалить              |

---

## 🛡 Безопасность

Для анализа безопасности проекта использовался инструмент Trivy.

Примеры запуска:

```bash
trivy config .
trivy fs .
trivy image <image_name>
```

Результаты проверки:

* Секреты не обнаружены
* Ошибки конфигурации Dockerfile отсутствуют
* Уязвимости в Python-зависимостях отсутствуют
* Уязвимости на уровне ОС присутствуют и приняты как риск базового образа

---

## 📦 Используемые технологии

* FastAPI
* PostgreSQL
* SQLAlchemy
* Alembic
* Docker / Docker Compose
* Trivy

---

## 📌 Примечания

* Файл `.env` не хранится в репозитории
* Для примера используется `.env.example`
* Структура базы данных управляется через Alembic

---

## Инфраструктура Terraform

Проект содержит Terraform-конфигурацию для создания инфраструктуры в Yandex Cloud:
- VPC
- Subnet
- Security Group
- VM для приложения

Команды:
terraform init
terraform plan
terraform apply
