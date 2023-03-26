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
  <title>Создание напитка</title>
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
        ${user.stringRole()} ${user.name}
      </div>
    </nav>
  </header>
  <main>
    <section class="products__warehouse">
      <#if items??>
      <form action="/add" method="post" enctype="multipart/form-data">
      <h1>Создать напиток
        <#if errorMessage??>
          <span style="color: red">${errorMessage}</span>
        </#if>
      </h1>
      <table>
        <thead>
          <th>Название</th>
          <th>Цена</th>
          <th>Описание</th>
          <th>Фото</th>
        </thead>
        <tbody id="tableBody">
          <tr>
            <td><input required name="title" type="text" class="input-td-wide"> </td>
            <td><input required name="price" type="number" class="input-td"></td>
            <td><textarea name="description" type="text" class="input-td-creation"></textarea></td>
            <td><input name="file" type="file" сlass="input-td-wide"></td>
          </tr>
        </tbody>
      </table>
      <br><br><br>
      <table>
        <thead>
          <th>Ингредиент</th>
          <th>Кол-во</th>
        </thead>
        <tbody>
        <#list items as item>
          <tr>
            <td>${item.title}</td>
            <td><input value="0" min="0" max="5" name="lot" type="number" class="input-td-wide"></td>
          </tr>
        </#list>
        </tbody>
      </table>
      <div class="add-btn-style">
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <button class="add-btn"><h2>Создать</h2></button>
      </div>
    </form>
    <#else>
        <h1>Нет ингридиентов.</h1>
    </#if>
    </section>
  </main>
  <footer>
    <p>© 2023 Бар</p>
  </footer>
</body>

</html>