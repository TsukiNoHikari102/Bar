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
  <title>Регистрация</title>
</head>

<body>
  <header>
    <nav>
      <ul>
        <li><span class="material-symbols-sharp">
            local_bar
          </span>
        </li>
        <li style="opacity: 0">.</li>
    </nav>
  </header>
  <main>
    <section class="login">
      <h1>
        Регистрация
          <#if errorMessage??>
            <span style="color: red">${errorMessage}</span>
          </#if>
      </h1>
      <div class="login-window">
  <div>
  <form action="/registration" method="post">
        <div class="login-window__item">
            <h2>E-mail</h2>
            <input required type="email" name="email">
        </div>
        <div class="login-window__item">
            <h2>Имя</h2>
            <input required type="text" name="name">
        </div>
        <div class="login-window__item">
            <h2>Пароль</h2>
            <input required maxlength="8" type="password" name="password">
        </div>
        <div class="login-window__btn2">
           <input type="hidden" name="_csrf" value="${_csrf.token}">
          <button type="submit">Регистрация</button>
        </div>
  </form>
  </div>
  <div class="login-window__img">
  </div>
      </div>
    </section>
  </main>
  <footer>
    <p>© 2023 Бар</p>
  </footer>
</body>
</html>