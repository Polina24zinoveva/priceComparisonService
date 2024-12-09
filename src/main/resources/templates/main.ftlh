<!DOCTYPE html>
<html lang="ru">

<!-- Цвета

серый            #595c5f
зеленый          #7FB77E
чуть светлее зеленый #80AF81
светло зеленый   #D6EFD8    rgb(214, 239, 216)
темно зеленый    #1A5319

-->

<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="icon" href="diploma_icon.png" type="image/x-icon">
    <title>Сервис для сравнения цен на товары</title>

    <style>
        .about-service-container {
            margin-top: 3rem;
            margin-bottom: 3rem;
            display: flex;
            flex-direction: column;
            align-items: left;
            text-align: left;
        }

        .search-bar {
            width: 60rem;
        }

        .marketplace-background {
            height: 46px;
            font-size: 18px;
            border-radius: 30px;
            background-color: rgba(214, 239, 216, 0.5);
            display: flex;                /* Используем Flexbox */
            align-items: center;          /* Центрирование по вертикали */
            justify-content: center;      /* Центрирование по горизонтали */
            padding: 0 20px;              /* Дополнительные отступы по горизонтали, если нужно */
            cursor: pointer; /* Курсор указателя для интерактивности */
        }

        .marketplace-background:hover {
            box-shadow: 0 0 10px rgb(26, 83, 25, 0.5); /* Горизонтальное смещение, вертикальное смещение, размытие и цвет*/
        }

        .marketplace-background.active {
            border: 1px solid #1A5319;
        }

        .marketplaces{
            margin-left: 16px;
            margin-top: 0.5rem;
        }
    </style>
</head>

<body>
    <div class="color-background">
        <div class="container-custom">
            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                <form action="/favorites" method="get">
                    <button type="submit" class="btn btn-favorites">
                        <span>Избранное</span> <!-- Добавляем текст, который будет появляться -->
                        <svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
                            <path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143q.09.083.176.171a3 3 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15"/>
                        </svg>
                    </button>
                </form>
            </div>

            <div class="about-service-container">
                <h2 style="color: #ffffff;">Сервис для сравнения цен на маркетплейсах</h2>
                <figcaption class="blockquote-footer" style="padding-top: 10px; font-size: 18px; color: #E8F2E8;">
                    <cite>это простой способ сэкономить деньги и время на покупках</cite>
                </figcaption>
            </div>
        </div>

        <div class="searchBar-background">
            <div class="searchBar-container">
                <form action="/resultsSearch" method="post" onsubmit="showProgressBar()">
                    <div class="search-container">
                        <div class="form-group mx-sm-3 mb-2">
                            <input type="text" name="searchText" id="searchText" placeholder="Введите название товара" class="form-control search-bar">
                        </div>
                        <#include "blocks/searchBar.ftlh">
                        <button type="submit" class="btn btn-search mb-2" style="width: 100px;">Искать</button>
                    </div>
                    <div class="d-grid gap-2 d-md-flex justify-content-md-start marketplaces">
                        <input type="hidden" name="ozonMainPage" id="ozonMainPage">
                        <input type="hidden" name="wbMainPage" id="wbMainPage">

                        <div id="wbMainPage" class="marketplace-background" data-name="wbMainPage">Wildberries</div>
                        <div id="ozonMainPage" class="marketplace-background" style="margin-left:7px;" data-name="ozonMainPage">Ozon</div>
                        <div id="ymMainPage" class="marketplace-background" style="margin-left:7px;" data-name="ymMainPage">Яндекс Маркет</div>
                        <div id="mmMainPage" class="marketplace-background" style="margin-left:7px;" data-name="mmMainPage">Магнит Маркет</div>
                    </div>
                </form>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // JavaScript для переключения стиля и значения
            document.querySelectorAll('.marketplace-background').forEach(element => {
                element.addEventListener('click', function() {
                    const isActive = this.classList.contains('active');
                    const name = this.getAttribute('data-name');


                    // Установка нового состояния
                    if (!isActive) {
                        this.classList.add('active');
                        document.getElementById(name).value = 'true';
                    }
                    else{
                        this.classList.remove('active');
                        document.getElementById(name).value = null;
                    }
                });
            });
        </script>
    </div>
</body>

</html>

