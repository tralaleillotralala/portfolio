<?php
    //Запускаем сессию
    session_start();
?>
<!DOCTYPE html>
<title>Lagoona</title>
  <link rel="stylesheet" href="css/normalize.css">
  <link rel="stylesheet" href="css/style.css">
<div id="header" class="header">
    <div class="container flex header-container main-contact-section">
      <ul class="list-reset flex header-right">
        <li class="header-list-item">
          <a href="#" class="header-logo">
            <img src="img/logo.svg" class="logo" alt="Lagoona logo">
          </a>
        </li>
        <li class="header-list-item flex">
          <a href="tel:+74953225448" class="header-company-tel">
            +7&nbsp;495&nbsp;322&nbsp;54&nbsp;48
          </a>
        </li>
      </ul>
      <div class="personal-account">
      <a href="http://magicteam.online/kyrsvoya/login.php"  class="btn btn-reset header-btn"><strong class="personal-account-container">
            Войти
          </strong>
        </a>
        <a href="http://magicteam.online/kyrsvoya/reg.php"  class="btn btn-reset header-btn"><strong class="personal-account-container">
            Зарегистрироваться
          </strong>
        </a>
      </div>
    </div>

    <div class="container flex header-container header-navigation list-item-container">
      <nav class="header-nav flex">
        <ul class="list-reset header-list-nav flex">
          <li class="header-list-item">
            <a href="#about-us" class="header-link">
              О&nbsp;нас
            </a>
          </li>
          <li class="header-list-item">
            <a href="#services" class="header-link">
              Услуги
            </a>
          </li>
          <li class="header-list-item">
            <a href="#advantages" class="header-link">
              Преимущества
            </a>
          </li>
          <li class="header-list-item">
            <a href="#placement" class="header-link">
              Размещение
            </a>
          </li>
          <li class="header-list-item">
            <a href="#webblog" class="header-link">
              Блог
            </a>
          </li>
          <li class="header-list-item">
            <a href="#contacts" class="header-link">
              Контакты
            </a>
          </li>
        </ul>
        <div class="flex btn-container">
          <button class="btn btn-reset header-btn flex">
            Хочу тур
          </button>
          <button class="btn btn-reset header-btn flex">
            Обратный звонок
          </button>
        </div>
      </nav>
    </div>
  </div>