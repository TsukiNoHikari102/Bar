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
  <title>Авторизация</title>
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
      <h1>Вход
              <#if RequestParameters.error??>
              <span style="color: red">
              <#if SPRING_SECURITY_LAST_EXCEPTION.message == "User is disabled">
                  Пользователь заблокирован
              <#else>
                  Пользователь не существует
              </#if>
              </span>
              </#if>
              </h1>
      <div class="login-window">
  <div><form action="/login" method="post">
        <div class="login-window__item">
            <h2>E-mail</h2>
            <input required type="email" name="username">
        </div>
        <div class="login-window__item">
            <h2>Пароль</h2>
            <input required maxlength="8" type="password" name="password">
        </div>
        <div class="login-window__btn">
          <input type="hidden" name="_csrf" value="${_csrf.token}">
          <button type="submit">Войти</button>
          <br>
          <br>
          <a href="/registration"><button type="button">Регистрация</button></a>
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