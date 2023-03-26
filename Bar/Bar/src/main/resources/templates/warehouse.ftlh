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
  <title>Склад</title>
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
        <#if user.isAdmin()><li><a href="/add">Создать</a></li>
        <li><a href="/admin">Администрирование</a></li></#if>
        <li><a href="/about">О нас</a></li>
        <li><span class="material-symbols-sharp">
            <form action="/logout" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <input type="submit" value="logout"/>
            </form>
          </span></li>
      </ul>
      <div class="username">
        ${user.stringRole()} ${user.name}
      </div>
    </nav>
  </header>
  <main>
    <section class="products__warehouse">
      <#if user.isAdmin()>
      <h1>Добавление ингридиента</h1>
      <div class="products__warehouse-input-name">
        <h2>Название</h2>
        <form action="/warehouse" method="post">
        <input type="text" name="title" required class="input-td-wide">
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <button class="add-btn-warehouse"><h3>Добавить</h3></button>
        <#if errorMessage??>
            <span style="color: red">${errorMessage}</span>
        </#if>
        </form>
      </div>
      </#if>
      <br>
      <br>
      <h1><#if user.isProvider()>Заказы<#else>Склад</#if></h1>
      <#if items??>
      <table>
        <thead>
          <th>Название</th>
          <th>Количество</th>
        </thead>
        <tbody>
          <#list items as item>
          <tr>
            <td>${item.title}</td>
            <#if user.isProvider()>
                <form action="/warehouse/delivery/${item.title}" method="post">
                    <td><input required min="1" max="100" type="number" name="count"></td>
                    <td><input type="hidden" name="_csrf" value="${_csrf.token}"><button>Поставить</button></td>
                </form>
            <#else>
                <td>${item.count}</td>
                <td>
                    <#if item.request>Заказан<#else><form action="/warehouse/request/${item.title}" method="post"><input type="hidden" name="_csrf" value="${_csrf.token}"><button>Заказать</button></form></#if>
                </td>
            </#if>
          </tr>
          </#list>
        </tbody>
      </table>
    <#else>
        <h2>Пусто</h2>
    </#if>
    </section>
  </main>
  <footer>
    <p>© 2023 Бар</p>
  </footer>
</body>
</html>