# README
# Blog - Блог

## Функции

- Можно зарегистрироваться (выполнено через Devise)
- Можно создавать посты
- К посту можно прикрепить одну картинку (+ валидация на картинки и размер файла)
- Пост после публикации можно редактировать или удалить
- В постах можно комментировать
- Комментарии можно редактировать или удалить
- Сортировка на главной - все посты/мои посты
- Админ.панель - можно управлять постами и комментариями, пользователями
- Из админ.панели можно скрыть посты. Такие посты в списке "мои посты" подписаны "not active!"

## Структура БД
- User has_many Posts (belongs_to User)
- User has_many Comments (belongs_to User)
- Post has_many Comments (belongs_to Post)
- Post has_one_attached :attachment

## Установка (Docker)

```sh
git clone "git@github.com:ivanprofpv/blog.git"
cd blog
docker pull profpv/blog:latest
docker compose build
docker compose run web rake db:migrate db:seed
docker compose up
```

Данные для входа в админку:

```sh
localhost:3000/admin
admin@example.com
password
```
Данные для входа в на сайт (пользователь):

```sh
localhost:3000
user@blog.com
12345678
```

## Технологии и гемы

- Ruby 3.1.2
- Rails 7.0.3
- БД: Postgresql
- Devise
- bootstrap
- kaminari
- activeadmin
