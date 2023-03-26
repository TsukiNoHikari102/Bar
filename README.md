# Ресторанный бизнес / общепит. Бар – торговля и склад.
<h3 align="center"></h3>

Данный проект реализован в рамках курсового проекта в университете, который осуществляет работу бара.

##  Инструкция по запуску проекта
1. Откройте проект в Idea. В idea -> File -> Open -> Папка с проектом
2. Перейдите в файл application.properties и замените значения datasourceurl, username/password - на ваши данные для подключения к MySQL.
3. Перейдите в файл BarApplication и запустите приложение.
4. Далее в БД автоматически сгенерируются таблицы
5. Перейдите в браузер и введите http://localhost:8080/login
6. Зарегистрируйте одного пользователя
7. Авторизируйтесь на сайте

## Оглавление

1. [Структура проекта](#Структура-проекта)
   1. [Описание проекта](#Описание-проекта)
   2. [Описание веб-сайта](#Описание-веб-сайта)
   3. [Models](#Models)
   4. [Views](#Views)
   5. [Controllers](#Controllers)
2. [Страницы сайта](#Страницы-сайта)
   1. [Регистрация](#Регистрация)
   2. [Авторизация](#Авторизация)
   3. [Блок Header ](#Блок-Header)
   4. [Товары](#Товары)
   5. [Назначение сотрудников](#Назначение-сотрудников)
   6. [Добавление напитков](#Добавление-напитков)
   7. [Подробнее о товаре](#Подробнее-о-товаре)
   8. [О нас](#О-нас)

## Структура проекта
 
### Описание проекта
Проект написан на языке программирования Java с использованием фреймворка 
Spring, базы данных MySQL, языка разметов HTML и таблицы стилей CSS. 
Структура проекта реализована по шаблону MVC. 
### Описание веб-сайта
Веб-сайт представляет собой сайт для управления баром и его складскими запасами. Пользователь может 
просматривать напитки и покупать их. Управление напитками доступно только администратору и бармену. На сайте присутствует форма
регистрация и авторизации. У 
зарегистрированных пользователей может быть одна из 
чертырех ролей: клиент, бармен, поставщик, администратор.
Роль определяет функционал, позволяющий управлять товарами. 
Клиент просматривает доступные напитки, совершает покупки.
Бармен редактирует напитки, делает заказ на поставку.
Админ раздает роли, владеет тем же функционалом, что и бармен, но так же может добавлять новые напитки.
### Models
Сервис работает с базой данных, в которой товары. Поэтому под категорию моделей
попадают все классы данных, 
хранящихся в БД, репотизориев и сервисов. 
[Ссылка](https://github.com/TsukiNoHikari102/Bar/tree/main/Bar/Bar/src/main/java/com/Bar/blog/models) 
на директорию models. 
### Views
Работу сервиса отображают страницы сайта. Поэтому под 
категорию представлений попадают HTML шаблоны страниц,
которые могут отображать различную информацию, в 
зависимости от различных условий (роль пользователя, 
наполнение базы данных и т.д.).
[Ссылка](https://github.com/TsukiNoHikari102/Bar/tree/main/Bar/Bar/src/main/java/com/Bar/blog/repositories)
на директорию templates.
### Controllers
Для того, чтобы загружать страницы сайта с нужной 
информацией, а также для обработки POST запросов 
нужны классы контроллеры. Они достают из
базы данных нужные данные, а затем отправляют их на страницы, 
которые их уже отображают нужным образом. Также 
контроллеры формы на страницах, добавляют в БД новые
данные.
[Ссылка](https://github.com/TsukiNoHikari102/Bar/tree/main/Bar/Bar/src/main/java/com/Bar/blog/controllers)
на директорию controllers.
## Страницы сайта
### Регистрация
Страница регистрации пользволяет зарегестрироваться новым сотрудникам на сайте. 
Далее функции будут доступны сотруднику согласно его должности, 
определенную администратором.
### Авторизация
Страница для авторизации зарегестрированных пользователей.
### Блок Header 
На каждой странице (кроме страницы авторизации и регистрации) есть 
верхний блок. В нем расположены расположены ссылки на другие страницы сайта,
а также кнопка выхода из аккаунта. Наполненность ссылками на другие страницы 
зависит от роли пользователя.
### Товары
На главной странице сервиса расположено товары с картинками и кратким описанием.

### Назначение сотрудников
**Данная страница доступна только администратору**
На странице показаны все зарегестрированные пользователи, которым администратор может выдать права доступа
### Добавление напитков
**Данная страница доступна только администратору.**
На данной странице администратор имеет возможность добавить товар с подробным описанием.



### Подробнее о товаре
Данная страница доступная всем клиентам

### О нас
Данная страница доступная всем и позволяет ознакомиться с деятельностью компании.








