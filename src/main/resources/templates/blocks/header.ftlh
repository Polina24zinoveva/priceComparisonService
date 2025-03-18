<style>
    .custom-gradient {
        background-color: #7f2f8d;
        background-image: radial-gradient(at 36% 24%, hsla(201, 88%, 63%, 1) 0, hsla(201, 88%, 63%, 0) 50%),
                          radial-gradient(at 82% 78%, hsla(30, 85%, 65%, 1) 0, hsla(30, 85%, 65%, 0) 50%),
                          radial-gradient(at 35% 89%, hsla(223, 90%, 67%, 1) 0, hsla(223, 90%, 67%, 0) 50%),
                          radial-gradient(at 90% 10%, hsla(0, 85%, 65%, 1) 0, hsla(0, 85%, 70%, 0) 50%);
        background-size: 100% 300%; /* Растянем градиент по высоте */
        background-position: center top; /* Оставляем верхнюю часть */
    }


    .btn-mainPage {
        width: 460px;
        height: 54px;
        font-size: 20px;
        border-radius: 40px;
        color: #ffffff;
        border: 2px solid #ffffff;
        box-shadow: 0 5px 15px rgba(255, 255, 255, 0.35);
        padding-bottom: 10px;


        display: flex;                /* Используем Flexbox */
        align-items: center;          /* Центрирование по вертикали */
        justify-content: center;      /* Центрирование по горизонтали */

    }

    /* Стили при наведении */
    .btn-mainPage:hover,
    .btn-mainPage:active{
       border: 2px solid white !important;
       color: white !important;
       box-shadow: 0 5px 15px rgba(255, 255, 255, 0.55) !important;
    }




    /* Стили для панели поиска */
    #searchPanel {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 120px;
        background-color: #7f2f8d;
        background-image: radial-gradient(at 36% 24%, hsla(201, 88%, 63%, 1) 0, hsla(201, 88%, 63%, 0) 50%),
                          radial-gradient(at 82% 78%, hsla(30, 85%, 65%, 1) 0, hsla(30, 85%, 65%, 0) 50%),
                          radial-gradient(at 35% 89%, hsla(223, 90%, 67%, 1) 0, hsla(223, 90%, 67%, 0) 50%),
                          radial-gradient(at 90% 10%, hsla(0, 85%, 65%, 1) 0, hsla(0, 85%, 70%, 0) 50%);
        background-size: 100% 300%; /* Растянем градиент по высоте */
        background-position: center top; /* Оставляем верхнюю часть */
        display: none; /* Скрыто по умолчанию */
        justify-content: end;
        align-items: start;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        z-index: 1000;
    }

    /* Кнопка закрытия */
    #closeSearch {
        color: #000000;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.35);
    }

    /* Эффект наведения */
    #closeSearch:hover {
        color: #000000;
        border: 2px solid #000000;
    }


    /* Стили для формы поиска */
    .search-form {
        margin-top: 2rem;
        margin-right: 4rem;
        display: flex;
        gap: 7px;
        width: 100%;
        max-width: 1450px;
    }

    .search-button:hover{
        color: #000000;
        border: 1px solid #000000;
    }
</style>
<#include "buttons.ftlh">

<div style="display: grid;" class="custom-gradient">
    <div style="margin: 2rem 4rem;">
        <div class="d-flex justify-content-between align-items-center">
            <form action="/main" method="get">
                <button class="btn btn-mainPage">Сервис для сравнения цен на маркетплейсах</button>
            </form>

            <div class="d-flex gap-2"> <!-- Контейнер для кнопок поиска и избранного -->
                <button class="btn btn-round btn-search" id="openSearch">
                    <span>Искать</span>
                    <svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                        <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
                    </svg>
                </button>

                <!-- Кнопка "Избранное" -->
                <form id="favoritesForm" action="/favorites" method="get" style="display: none;">
                    <button type="submit" class="btn btn-round btn-favorites">
                        <span>Избранное</span>
                        <svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
                            <path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143q.09.083.176.171a3 3 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15"/>
                        </svg>
                    </button>
                </form>

                <!-- Кнопка "Выйти" -->
                <form id="logoutForm" action="/logout" method="get" style="display: none;">
                    <button type="submit" class="btn btn-round btn-logout">
                        <span>Выйти</span>
                        <svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" fill="currentColor" class="bi bi-box-arrow-right" viewBox="0 0 16 16">
                            <path fill-rule="evenodd" d="M10 12.5a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v2a.5.5 0 0 0 1 0v-2A1.5 1.5 0 0 0 9.5 2h-8A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-2a.5.5 0 0 0-1 0z"/>
                            <path fill-rule="evenodd" d="M15.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 0 0-.708.708L14.293 7.5H5.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708z"/>
                        </svg>
                    </button>
                </form>
            </div>
        </div>



        <!-- Панель поиска -->
        <div id="searchPanel">
            <form action="/resultsSearch" method="post" onsubmit="showProgressBar(52)" class="search-form">
                <input type="text" name="searchText" id="searchText" class="form-control search-bar" placeholder="Введите название товара">
                <button type="submit" class="btn search-button">
                    <svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                        <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
                    </svg>
                    <span>Искать</span>
                </button>
                <button id="closeSearch" class="btn-round close-button" type="button">
                    <svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" fill="currentColor" class="bi bi-x-lg" viewBox="0 0 16 16">
                      <path d="M2.146 2.854a.5.5 0 1 1 .708-.708L8 7.293l5.146-5.147a.5.5 0 0 1 .708.708L8.707 8l5.147 5.146a.5.5 0 0 1-.708.708L8 8.707l-5.146 5.147a.5.5 0 0 1-.708-.708L7.293 8z"/>
                    </svg>
                </button>

            </form>
        </div>

        <script>
            // Открытие панели поиска
            document.getElementById("openSearch").addEventListener("click", function() {
                document.getElementById("searchPanel").style.display = "flex";
            });

            // Закрытие панели поиска
            document.getElementById("closeSearch").addEventListener("click", function(event) {
                event.preventDefault(); // Предотвращаем отправку формы
                document.getElementById("searchPanel").style.display = "none";
            });

            // Функция для отображения нужной кнопки
            function updateButtons() {
                const favoritesForm = document.getElementById("favoritesForm");
                const logoutForm = document.getElementById("logoutForm");

                // Получаем текущий URL
                const currentUrl = window.location.pathname;

                // Если текущая страница — "Избранное", показываем кнопку "Выйти"
                if (currentUrl === "/favorites") {
                    favoritesForm.style.display = "none";
                    logoutForm.style.display = "block";
                } else {
                    // Иначе показываем кнопку "Избранное"
                    favoritesForm.style.display = "block";
                    logoutForm.style.display = "none";
                }
            }

            // Обновляем кнопки при загрузке страницы
            updateButtons();
        </script>
    </div>
</div>