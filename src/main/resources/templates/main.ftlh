<!DOCTYPE html>
<html lang="ru">


<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="icon" href="icon.png" type="image/x-icon">
    <title>Сервис для сравнения цен на товары</title>
    <#include "blocks/buttons.ftlh">


    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #F3F1ED; /* Черный фон по всей странице */
        }
        .about-service-container {
            margin-top: 1rem;
            margin-bottom: 1rem;
            color: #0C4E43;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
        }

        .title{
            color: #ffffff;
            max-width: 35rem;
            font-size: 48px;
        }

        .subTitle{
            color: #ffffff;
            font-size: 20px;
            max-width: 35rem;
        }

        .marketplace-background {
            height: 46px;
            font-size: 18px;
            border-radius: 30px;
            display: flex;                /* Используем Flexbox */
            align-items: center;          /* Центрирование по вертикали */
            justify-content: center;      /* Центрирование по горизонтали */
            padding: 0 20px;              /* Дополнительные отступы по горизонтали, если нужно */
            cursor: pointer; /* Курсор указателя для интерактивности */
            color:  #ffffff;
        }

        .marketplace-background:hover {
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.35);
        }

        .marketplace-background.active {
            border: 1px solid #FF4601;
        }

        .marketplaces{
            margin-top: 1rem;
        }

        .wb-background{
            background-color: #A864DD;
        }
        .ozon-background{
            background-color: #5C91FE;
        }
        .ym-background{
            background-color: #FF9A66;
        }
        .mm-background{
            background-color: #FA6252;
        }

        .wb-background.active{
            border: 2px solid #7600d1;
        }
        .ozon-background.active{
            border: 2px solid #004ef0;
        }
        .ym-background.active{
            border: 2px solid #fa5400;
        }
        .mm-background.active{
            border: 2px solid #d11400;
        }

        .searchBar-container {
            margin-top: 2rem;
            margin-bottom: 2rem;
        }

    </style>
</head>

<body>
    <div class="color-background">
        <div class="container-custom">
            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                <form action="/favorites" method="get">
                    <button type="submit" class="btn btn-round btn-favorites">
                        <span>Избранное</span> <!-- Добавляем текст, который будет появляться -->
                        <svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
                            <path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143q.09.083.176.171a3 3 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15"/>
                        </svg>
                    </button>
                </form>
            </div>

            <div class="about-service-container">
                <p class="mikodacs-text title">СЕРВИС ДЛЯ СРАВНЕНИЯ ЦЕН НА МАРКЕТПЛЕЙСАХ</p>
                <p class="mikodacs-text subTitle">это простой способ сэкономить деньги и время на покупках</p>
            </div>

        </div>
    </div>

    <div style="margin-left:3rem; margin-right:2rem;">
        <div class="searchBar-container">
            <#include "blocks/searchBar.ftlh">
            <form action="/resultsSearch" method="post" onsubmit="showProgressBar(52)">
                <div class="search-container">
                    <div class="form-group mx-sm-3 mb-2">
                        <input type="text" name="searchText" id="searchText" placeholder="Введите название товара"
                            class="form-control search-bar" style="width: 81.5rem;">
                    </div>
                    <button type="submit" class="btn search-button">
                        <svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
                        </svg>
                        <span>Искать</span>
                    </button>
                </div>
                <div class="d-grid gap-2 d-md-flex justify-content-md-center marketplaces">
                    <input type="hidden" name="ozonMainPage" id="ozonMainPage">
                    <input type="hidden" name="wbMainPage" id="wbMainPage">
                    <input type="hidden" name="ymMainPage" id="ymMainPage">
                    <input type="hidden" name="mmMainPage" id="mmMainPage">

                    <div id="wbMainPage" class="marketplace-background wb-background" data-name="wbMainPage">Wildberries</div>
                    <div id="ozonMainPage" class="marketplace-background ozon-background" style="margin-left:7px;" data-name="ozonMainPage">Ozon</div>
                    <div id="ymMainPage" class="marketplace-background ym-background" style="margin-left:7px;" data-name="ymMainPage">Яндекс Маркет</div>
                    <div id="mmMainPage" class="marketplace-background mm-background" style="margin-left:7px;" data-name="mmMainPage">Магнит Маркет</div>
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
</body>

</html>

