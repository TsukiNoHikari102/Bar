<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/css/normalize.css">
  <link rel="stylesheet" href="/css/reset.css">
  <link rel="stylesheet" href="/css/style.css">
  <link rel="preconnect" href="https://fonts.googleapis.com" crossorigin="anonymous">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
  <link href="https://fonts.googleapis.com/css2?family=Rubik:wght@300;400;500;600;700&display=swap" rel="stylesheet" crossorigin="anonymous">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Sharp:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" crossorigin="anonymous"/>
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" crossorigin="anonymous">
  <title>Редактирование пользователя</title>
</head>

<body>
  <header>
    <nav>
      <ul>
        <li><span class="material-symbols-sharp">
            local_bar
          </span>
        </li>
        <li><a href="/" class="active">Главная</a></li>
        <li><a href="/warehouse" class="active">Склад</a></li>
        <li><a href="/add">Создать</a></li>
        <li><a href="/admin">Администрирование</a></li>
        <li><a href="/about">О нас</a></li>
        <li><span class="material-symbols-sharp">
            <form action="/logout" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <input type="submit" value="logout"/>
            </form>
          </span></li>
      </ul>
      <div class="username">
        Админ admin
      </div>
    </nav>
  </header>
  <main>
    <section class="products__table">
      <h1>Редактировать пользователя ${user.name}</h1>
      <form action="/admin/edit_role" method="post">
      <div class="products__item">
        <div class="user-control">
            <#list roles as role>
                <input type="radio" name="user_role" id="${role}" value="${role}" ${user.roles?seq_contains(role)?string("checked", "")}> ${role}
                <br>
            </#list>
          <input type="hidden" value="${user.id}" name="userId">
          <input type="hidden" value="${_csrf.token}" name="_csrf">
          <button type="submit">Сохранить</button>
        </div>
      </div>
      </form>
    </section>
  </main>
  <footer>
    <p>© 2023 Бар</p>
  </footer>
</body>

</html>