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
  <title>Главная страница</title>
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
        <#if user.isVisitor()==false><li><a href="/warehouse" class="active">Склад</a></li></#if>
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


        <section class="products">
          <h1>Продукция</h1>
          <#list drinks as drink>
          <div class="products__item">
            <div class="products__item-box">
              <div class="products__item-image">
                <img <#if drink.image??>src="images/${drink.image.id}"<#else>src="/img/default.png"</#if> >
              </div>
              <div class="products__item-status">
                <h2>${drink.price} руб.</h2>
                <table>
                  <thead>
                  <tr>
                    <td>Ингредиент</td>
                    <td>Кол-во</td>
                  </tr>
                </thead>
                <tbody>
                                      <#list drink.components as key, value>
                                        <tr>
                                            <td>${key.title}</td>
                                            <td>${value}</td>
                                        </tr>
                                      </#list>
                </tbody>
                </table>
                <#if drink.description??><p>${drink.description}</p></#if>
              </div>
              <span class="material-symbols-sharp">
                liquor
              </span>
              <div class="products__item-content">
                <div class="products__item-title">
                  <h2>${drink.title}</h2>
                </div>
                <div class="buttons">
                <#if user.isAdmin()>
                  <div class="products__item-btn">
                                            <form action="/delete/${drink.title}" method="post">
                                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                                            <button class="delete">Удалить</button>
                                            </form>
                  </div>
                  </#if>
                  <div class="products__item-btn">
                    <#if user.isAdmin() || user.isBarmen()>
                                            <form action="/edit/${drink.title}" method="get">
                                                <button class="edit" type="submit">Редактировать</button>
                                            </form>
                                        <#else>
                                            <form action="/buy/${drink.title}" method="post">
                                                <input type="hidden" name="_csrf" value="${_csrf.token}">
                                                <button class="edit" type="submit">Купить</button>
                                            </form>
                                        </#if>
                  </div>
                </div>
              </div>
            </div>
          </div>
                <#else>
                <h2>Пусто</h2>
                </#list>
        </section>
  </main>
  <footer>
    <p>© 2023 Бар</p>
  </footer>
</body>
</html>