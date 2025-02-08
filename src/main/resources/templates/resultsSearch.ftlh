<!DOCTYPE html>
<html lang="ru">

<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="icon" href="diploma_icon.png" type="image/x-icon">

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>

    <title>Сервис для сравнения цен на товары</title>

    <style>
        #emptyCartMessage {
            margin-left: 2rem;
            margin-top: 2rem;
            font-size: 24px;
            font-weight: 480
        }

        .search-bar {
            width: 52rem;
        }

        .searchBar-container {
            width: 82rem;
            margin-top: 2rem;
            margin-bottom: 2rem;
        }

        .custom-link {
            color: #000000;
            text-decoration: none;
            font-size: 18px;
        }
        .custom-link:hover {
            text-decoration: underline; /* Подчеркивание при наведении */
        }

        .button-sort {
            height: 46px;
            border: none;
            width: 100%;
            padding: 0!important;
            background: none!important;
            text-align: left !important;
            font-size: 18px;
            cursor: pointer;
        }

        /* Стили для удаления кнопок увеличения и уменьшения в input type number */
        input[type=number]::-webkit-outer-spin-button,
        input[type=number]::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
        input[type=number] {
            -moz-appearance: textfield;
        }




        .btn-mainPage {
             background: none;
             border: none;
             padding: 0;
             font-size: 2rem;
             color: #ffffff;
             cursor: pointer;
             text-align: left;
        }

        .dropdown-menu span {
            font-size: 18px;
            margin-bottom:4px;
        }

        .dropdown-menu li {
            font-size: 18px;
            padding-left: 1rem;
            padding-right: 1rem;
        }

        .dropdown-menu-check li:hover {
            background-color: #D6EFD8;
        }

        .btn-settings {
            width: 50px;
            height: 46px;
            border-color: #80AF81;
            font-size: 18px;
            margin-top:2px;
            color: #80AF81;

            display: flex;                /* Используем Flexbox */
            align-items: center;          /* Центрирование по вертикали */
            justify-content: center;      /* Центрирование по горизонтали */
        }

        .btn-settings:hover {
            border: 1px solid #80AF81 !important;
            color: #80AF81 !important;
            background-color: rgba(214, 239, 216, 0.5) !important;
        }
        .btn-settings:focus {
            border: 1px solid #80AF81 !important;
            color: #80AF81 !important;
            background-color: rgba(214, 239, 216, 0.5) !important;
        }

        .btn-settings:active {
            border: 1px solid #80AF81 !important;
            color: #80AF81 !important;
            background-color: rgba(214, 239, 216, 0.5) !important;
        }


        /* Скрыть стрелку у кнопки */
        .btn-settings::after {
            display: none;
        }

        input[type="checkbox"]:checked {
          background-color: green;
        }

        .btn-card {
            width: 100%;
            height: 46px;
            margin-top: 1rem;
            font-size: 18px;
            position: relative;
            overflow: hidden;
            transition: width 0.3s ease;
        }

        .btn-card-wb {
            border-color: #A864DD;
            background-color: #A864DD;
            color: #ffffff;
        }

        .btn-card-ozon {
            border-color: #5C91FE;
            background-color: #5C91FE;
            color: #ffffff;
        }

        .btn-card-ym {
            border-color: #FF9A66;
            background-color: #FF9A66;
            color: #ffffff;
        }

        .btn-card-mm {
            border-color: #FF6F61;
            background-color: #FF6F61;
            color: #ffffff;
        }

        .btn-card:hover {
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1), 0px 4px 8px rgba(0, 0, 0, 0.1);
        }

        .btn-card-wb:hover {
            border-color: #8E12DD;
            background-color: #8E12DD;
            color: #ffffff;
        }

        .btn-card-ozon:hover {
            border-color: #005CFE;
            background-color: #005CFE;
            color: #ffffff;
        }

        .btn-card-ym:hover {
            border-color: #FCE000;
            background-color: #FCE000;
            color: #ffffff;
        }

        .btn-card-mm:hover {
            border-color: #FF462D;
            background-color: #FF462D;
            color: #ffffff;
        }


        .card-container {
            width: 18rem;
            height: 38rem;
            margin-top: 1rem;
            margin-bottom: 1rem;
            margin-left: auto;
            margin-right: auto;
        }


        .photo-container {
            height: 25rem; /* фиксируем высоту контейнера */
            display: flex;
            justify-content: center; /* Центрирование по горизонтали */
            align-items: center; /* Центрирование по вертикали */
        }

        .photo {
            max-width: 100%; /* Ограничиваем ширину фото по ширине контейнера */
            max-height: 100%; /* Ограничиваем высоту фото по высоте контейнера */
            object-fit: contain; /* Сохраняем пропорции изображения */
            border-radius: 5px; /* Закругляем углы */
        }

        .text-container {
            height: 8rem;
        }

        .name {
            max-height: 30px;
            overflow: hidden;
            margin-bottom: 1rem;
        }

    </style>
</head>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    function showMessage(message) {
        Swal.fire({
          text: message,
          icon: "success",
          confirmButtonColor: '#7FB77E'
        });
    }
    function showWarning(warning) {
        Swal.fire({
          text: warning,
          icon: "warning",
          confirmButtonColor: '#7FB77E'
        });
    }
    function showError(error) {
        Swal.fire({
          text: error,
          icon: "error",
          confirmButtonColor: '#7FB77E'
        });
    }
</script>
<body>
    <#if message??>
        <script>
            showMessage("${message}");
        </script>
    </#if>
    <#if warning??>
        <script>
            showWarning("${warning}");
        </script>
    </#if>
    <#if error??>
        <script>
            showError("${error}");
        </script>
    </#if>

    <div class="color-background">
        <div class="container-custom">
            <div class="d-grid gap-2 d-md-flex justify-content-md-between">
                <form action="/main" method="get">
                    <button type="submit" class="btn btn-mainPage me-md-2" style="background: none; border: none; padding: 0; font-size: 2rem; color: #ffffff; cursor: pointer; text-align: left;">
                        Сервис для сравнения цен на маркетплейсах
                    </button>
                </form>

                <form action="/favorites" method="get">
                    <button type="submit" class="btn btn-favorites">
                        <span>Избранное</span> <!-- Добавляем текст, который будет появляться -->
                        <svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
                            <path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143q.09.083.176.171a3 3 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15"/>
                        </svg>
                    </button>
                </form>
            </div>
        </div>

        <div class="searchBar-background">
            <div class="searchBar-container">
                <div class="d-grid gap-2 d-md-flex justify-content-md-left">
                    <div class="search-container">
                        <form action="/resultsSearch" method="post" onsubmit="showProgressBar()">
                            <div class="form-group mx-sm-3 mb-2">
                                <input type="text" name="searchText" id="searchText"  class="form-control search-bar" <#if searchText??> placeholder="${searchText}" <#else> placeholder="Введите название товара" </#if>>
                            </div>

                            <#include "blocks/searchBar.ftlh">
                        </form>
                        <form class="form-inline" action="/resultsSearch" method="post" onsubmit="showProgressBar()">
                            <button type="submit" class="btn btn-search mb-2" style="width: 100px; margin-right: 16px;">Искать</button>
                            <input type="hidden" name="searchText" id="searchText">
                        </form>

                        <div class="btn-group form-inline" role="group">
                            <button type="button" class="btn btn-settings dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false" data-bs-offset="0,4">
                                <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" fill="currentColor" class="bi bi-arrow-down-up" viewBox="0 0 16 16">
                                  <path fill-rule="evenodd" d="M11.5 15a.5.5 0 0 0 .5-.5V2.707l3.146 3.147a.5.5 0 0 0 .708-.708l-4-4a.5.5 0 0 0-.708 0l-4 4a.5.5 0 1 0 .708.708L11 2.707V14.5a.5.5 0 0 0 .5.5m-7-14a.5.5 0 0 1 .5.5v11.793l3.146-3.147a.5.5 0 0 1 .708.708l-4 4a.5.5 0 0 1-.708 0l-4-4a.5.5 0 0 1 .708-.708L4 13.293V1.5a.5.5 0 0 1 .5-.5"/>
                                </svg>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-check dropdown-menu-start" style="width:232px;">
                                <li>
                                    <form action="/sortByDefault" method="post">
                                        <#if selectedSort=="sortByDefault">
                                            <button class="button-sort" type="submit"><b>По умолчанию</b></button>
                                        <#else>
                                            <button class="button-sort" type="submit">По умолчанию</button>
                                        </#if>
                                    </form>
                                </li>
                                <li>
                                    <form action="/sortPriseAsc" method="post">
                                        <#if selectedSort=="sortPriseAsc">
                                            <button class="button-sort" type="submit"><b>По возрастанию цены</b></button>
                                        <#else>
                                            <button class="button-sort" type="submit">По возрастанию цены</button>
                                        </#if>
                                    </form>
                                </li>
                                <li>
                                    <form action="/sortPriseDesc" method="post">
                                        <#if selectedSort=="sortPriseDesc">
                                            <button class="button-sort" type="submit"><b>По убыванию  цены</b></button>
                                        <#else>
                                            <button class="button-sort" type="submit">По убыванию  цены</button>
                                        </#if>
                                    </form>
                                </li>
                                <li>
                                    <form action="/sortPopular" method="post">
                                        <#if selectedSort=="sortPopular">
                                            <button class="button-sort" type="submit"><b>По популярности</b></button>
                                        <#else>
                                            <button class="button-sort" type="submit">По популярности</button>
                                        </#if>
                                    </form>
                                </li>
                                <li>
                                    <form action="/sortRating" method="post">
                                        <#if selectedSort=="sortRating">
                                            <button class="button-sort" type="submit"><b>По рейтингу</b></button>
                                        <#else>
                                            <button class="button-sort" type="submit">По рейтингу</button>
                                        </#if>
                                    </form>
                                </li>
                            </ul>
                        </div>

                        <div class="btn-group me-1" role="group">
                            <button type="button" class="btn btn-settings dropdown-toggle" style="margin-top:10px; margin-left:1rem;" data-bs-toggle="dropdown" aria-expanded="false" data-bs-offset="-66,4">
                                <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" fill="currentColor" class="bi bi-sliders" viewBox="0 0 16 16">
                                    <path fill-rule="evenodd" d="M11.5 2a1.5 1.5 0 1 0 0 3 1.5 1.5 0 0 0 0-3M9.05 3a2.5 2.5 0 0 1 4.9 0H16v1h-2.05a2.5 2.5 0 0 1-4.9 0H0V3zM4.5 7a1.5 1.5 0 1 0 0 3 1.5 1.5 0 0 0 0-3M2.05 8a2.5 2.5 0 0 1 4.9 0H16v1H6.95a2.5 2.5 0 0 1-4.9 0H0V8zm9.45 4a1.5 1.5 0 1 0 0 3 1.5 1.5 0 0 0 0-3m-2.45 1a2.5 2.5 0 0 1 4.9 0H16v1h-2.05a2.5 2.5 0 0 1-4.9 0H0v-1z"/>
                                </svg>
                            </button>
                            <form action="/filters" method="post">
                                <ul class="dropdown-menu" style="width:232px;">
                                    <li>
                                        <button type="submit" class="btn btn-search" style="width:200px;">Применить</button>
                                    </li>
                                    <li><hr class="dropdown-divider"></li>
                                    <span class="dropdown-item" style="pointer-events: none;">Маркетплейс</span>
                                    <li>
                                        <#if selectWbMainPage == true>
                                            <div class="form-check sideMargin verticalMargin">
                                                <input class="form-check-input" type="checkbox" name="wb" id="wb" value="true" <#if selectWb?? && selectWb == true>checked</#if>>
                                                <label class="form-check-label" for="wb">
                                                    Wildberries
                                                </label>
                                            </div>
                                        </#if>
                                        <#if selectOzonMainPage == true>
                                            <div class="form-check sideMargin verticalMargin">
                                                <input class="form-check-input" type="checkbox" name="ozon" id="ozon" value="true" <#if selectOzon?? && selectOzon == true>checked</#if>>
                                                <label class="form-check-label" for="ozon">
                                                    Ozon
                                                </label>
                                            </div>
                                        </#if>
                                        <#if selectMmMainPage == true>
                                            <div class="form-check sideMargin verticalMargin">
                                                <input class="form-check-input" type="checkbox" name="mm" id="mm" value="true" <#if selectMm?? && selectMm == true>checked</#if>>
                                                <label class="form-check-label" for="mm">
                                                    Магнит Маркет
                                                </label>
                                            </div>
                                        </#if>
                                        <#if selectYmMainPage == true>
                                            <div class="form-check sideMargin verticalMargin">
                                                <input class="form-check-input" type="checkbox" name="ym" id="ym" value="true" <#if selectYm?? && selectYm == true>checked</#if>>
                                                <label class="form-check-label" for="ym">
                                                    Яндекс Маркет
                                                </label>
                                            </div>
                                        </#if>
                                    </li>
                                    <li><hr class="dropdown-divider"></li>

                                    <span class="dropdown-item" style="pointer-events: none;">Цена</span>
                                    <li>
                                        <div class="input-group mb-3">
                                            <input type="number" name="minPrice" class="form-control" min="0" max="100000000" placeholder="от ${minPrice}">
                                            <input type="number" name="maxPrice" class="form-control" min="1" max="100000000" placeholder="до ${maxPrice}">
                                        </div>
                                    </li>
                                    <li><hr class="dropdown-divider"></li>

                                    <span class="dropdown-item" style="pointer-events: none;">Рейтинг</span>
                                    <li>
                                        <div class="form-check sideMargin verticalMargin">
                                            <input class="form-check-input rating-checkbox" type="checkbox" name="rating" id="rating40" value="4.0" <#if selectedRating==4.0>checked</#if>>
                                            <label class="form-check-label" for="rating40">
                                                не ниже 4.0
                                            </label>
                                        </div>
                                        <div class="form-check sideMargin verticalMargin">
                                            <input class="form-check-input rating-checkbox" type="checkbox" name="rating" id="rating45" value="4.5" <#if selectedRating==4.5>checked</#if>>
                                            <label class="form-check-label" for="rating45">
                                                не ниже 4.5
                                            </label>
                                        </div>
                                        <div class="form-check sideMargin verticalMargin">
                                            <input class="form-check-input rating-checkbox" type="checkbox" name="rating" id="rating48" value="4.8" <#if selectedRating==4.8>checked</#if>>
                                            <label class="form-check-label" for="rating48">
                                                не ниже 4.8
                                            </label>
                                        </div>
                                        <div class="form-check sideMargin verticalMargin">
                                            <input class="form-check-input rating-checkbox" type="checkbox" name="rating" id="rating49" value="4.9" <#if selectedRating==4.9>checked</#if>>
                                            <label class="form-check-label" for="rating49">
                                                не ниже 4.9
                                            </label>
                                        </div>
                                        <div class="form-check sideMargin verticalMargin">
                                            <input class="form-check-input rating-checkbox" type="checkbox" name="rating" id="rating50" value="5.0" <#if selectedRating==5.0>checked</#if>>
                                            <label class="form-check-label" for="rating50">
                                                5.0
                                            </label>
                                        </div>
                                    </li>

                                    <script>
                                        // JavaScript для обеспечения выбора только одного чекбокса
                                        const checkboxes = document.querySelectorAll('.rating-checkbox');

                                        checkboxes.forEach((checkbox) => {
                                            checkbox.addEventListener('change', function() {
                                                // Снять отметку со всех чекбоксов, кроме текущего
                                                checkboxes.forEach((cb) => {
                                                    if (cb !== this) {
                                                        cb.checked = false;
                                                    }
                                                });
                                            });
                                        });
                                    </script>

                                    <li><hr class="dropdown-divider"></li>

                                    <span class="dropdown-item" style="pointer-events: none;">Количество заказов</span>
                                    <li>
                                        <div class="input-group mb-3">
                                            <input type="number" name="minReviews" class="form-control" min="0" max="100000000" placeholder="от ${minReviews}">
                                            <input type="number" name="maxReviews" class="form-control" min="1" max="100000000" placeholder="до ${maxReviews}">
                                        </div>
                                    </li>
                                </ul>
                            </form>
                        </div>

                    </div>
                </div>

                <#if cards??>
                    <#if cards?size == 0>
                        <div id="emptyCartMessage">
                            <p class="fw-semibold">По вашему запросу ничего не найдено :(</p>
                        </div>
                    <#else>
                        <div style="margin-top: 1rem; margin-left: 1rem; margin-right: 120px;">
                            <div class="row">
                                <#list cards as card>
                                    <div class="col-md-4">
                                        <div class="card" style="margin-bottom:1rem;">
                                            <div class="card-container">
                                                <#if card.imageUrl??>
                                                    <div class="photo-container">
                                                        <img src="${card.imageUrl}" class="card-img-top photo" alt="Фото">
                                                    </div>
                                                <#else>
                                                </#if>
                                                <div class="text-container">
                                                    <div class="d-flex justify-content-between" style="margin-top: 1rem;">
                                                        <h4>${card.price} ₽</h4>
                                                        <p style="font-size: 20px; font-weight: 480;">${card.marketplace}</p>
                                                    </div>
                                                    <div class="name">
                                                        <a href="${card.url}" class="custom-link">${card.name}</a>
                                                    </div>


                                                    <div class="d-grid d-md-flex">
                                                        <div class="d-flex align-items-center justify-content-center" style="margin-right:1rem;">
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
                                                                <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                                                            </svg>
                                                            <p style="margin: 0 0 0 4px; font-size: 18px;">${card.rating?string("0.0")?replace(",", ".")}</p>
                                                        </div>
                                                        <#if card.countReviews % 10 == 1>
                                                            <p class="card-reviews" style="margin: 0; font-size: 18px;">${card.countReviews} оценка</p>
                                                        <#else>
                                                            <#if card.countReviews % 10 == 2>
                                                                <p class="card-reviews" style="margin: 0; font-size: 18px;">${card.countReviews} оценки</p>
                                                            <#else>
                                                                 <p class="card-reviews" style="margin: 0; font-size: 18px;">${card.countReviews} оценок</p>
                                                            </#if>
                                                        </#if>
                                                    </div>
                                                </div>
                                                <#if card.inFavorites==false>
                                                    <form id="addFav" onclick="addOrAdded()" action="/addToFavorite" method="post">
                                                        <input type="hidden" name="name" value="${card.name}">
                                                        <input type="hidden" name="marketplace" value="${card.marketplace}">
                                                        <input type="hidden" name="url" value="${card.url}">
                                                        <input type="hidden" name="price" value="${card.price}">
                                                        <input type="hidden" name="rating" value="${card.rating?string("0.0")?replace(",", ".")}">
                                                        <input type="hidden" name="countReviews" value="${card.countReviews}">
                                                        <input type="hidden" name="imageUrl" value="${card.imageUrl}">
                                                        <input type="hidden" name="searchText" value="${searchText}">

                                                        <button type="submit"class="btn btn-card
                                                                <#if card.marketplace == "Wildberries">btn-card-wb</#if>
                                                                <#if card.marketplace == "Ozon">btn-card-ozon</#if>
                                                                <#if card.marketplace == "Яндекс Маркет">btn-card-ym</#if>
                                                                <#if card.marketplace == "Магнит Маркет">btn-card-mm</#if>">
                                                            <div class="d-flex align-items-center justify-content-center" style="margin-right:1rem;">
                                                                <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
                                                                    <path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143q.09.083.176.171a3 3 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15"/>
                                                                </svg>
                                                                <p style="margin: 0 0 4px 8px; font-size: 18px;">Добавить в избранное</p>
                                                            </div>
                                                        </button>
                                                    </form>
                                                    <form id="addedFav" onclick="addOrAdded()" action="/removeFromFavoritesInResultSearchPage" method="post" style="display:none;">
                                                        <input type="hidden" name="url" value="${card.url}">
                                                        <button type="submit" class="btn btn-card
                                                            <#if card.marketplace == "Wildberries">btn-card-wb</#if>
                                                            <#if card.marketplace == "Ozon">btn-card-ozon</#if>
                                                            <#if card.marketplace == "Яндекс Маркет">btn-card-ym</#if>
                                                            <#if card.marketplace == "Магнит Маркет">btn-card-mm</#if>">
                                                            <div class="d-flex align-items-center justify-content-center" style="margin-right:1rem;">
                                                                <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
                                                                    <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314"/>
                                                                </svg>
                                                                <p style="margin: 0 0 4px 8px; font-size: 18px;">В избранном</p>
                                                            </div>
                                                        </button>
                                                    </form>

                                                <#else>
                                                    <form id="addFav" onclick="addOrAdded()" action="/addToFavorite" method="post" style="display:none;">
                                                        <input type="hidden" name="name" value="${card.name}">
                                                        <input type="hidden" name="marketplace" value="${card.marketplace}">
                                                        <input type="hidden" name="url" value="${card.url}">
                                                        <input type="hidden" name="price" value="${card.price}">
                                                        <input type="hidden" name="rating" value="${card.rating?string("0.0")?replace(",", ".")}">
                                                        <input type="hidden" name="countReviews" value="${card.countReviews}">
                                                        <input type="hidden" name="imageUrl" value="${card.imageUrl}">
                                                        <button type="submit"class="btn btn-card
                                                            <#if card.marketplace == "Wildberries">btn-card-wb</#if>
                                                            <#if card.marketplace == "Ozon">btn-card-ozon</#if>
                                                            <#if card.marketplace == "Яндекс Маркет">btn-card-ym</#if>
                                                            <#if card.marketplace == "Магнит Маркет">btn-card-mm</#if>">
                                                            <div class="d-flex align-items-center justify-content-center" style="margin-right:1rem;">
                                                                <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
                                                                    <path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143q.09.083.176.171a3 3 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15"/>
                                                                </svg>
                                                                <p style="margin: 0 0 4px 8px; font-size: 18px;">Добавить в избранное</p>
                                                            </div>
                                                        </button>
                                                    </form>
                                                    <form id="addedFav" onclick="addOrAdded()" action="/removeFromFavoritesInResultSearchPage" method="post">
                                                        <input type="hidden" name="url" value="${card.url}">
                                                        <button type="submit"class="btn btn-card
                                                            <#if card.marketplace == "Wildberries">btn-card-wb</#if>
                                                            <#if card.marketplace == "Ozon">btn-card-ozon</#if>
                                                            <#if card.marketplace == "Яндекс Маркет">btn-card-ym</#if>
                                                            <#if card.marketplace == "Магнит Маркет">btn-card-mm</#if>">
                                                            <div class="d-flex align-items-center justify-content-center" style="margin-right:1rem;">
                                                                <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
                                                                    <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314"/>
                                                                </svg>
                                                                <p style="margin: 0 0 4px 8px; font-size: 18px;">В избранном</p>
                                                            </div>
                                                        </button>
                                                    </form>
                                                </#if>

                                                <script>
                                                    function addOrAddedFav() {
                                                        if (document.getElementById("addedFav").style.display === "none") {
                                                            document.getElementById("addedFav").style.display = "block"
                                                            document.getElementById("addFav").style.display = "none"
                                                        } else {
                                                            document.getElementById("addedFav").style.display = "none"
                                                            document.getElementById("addFav").style.display = "block"
                                                        }
                                                    }
                                                </script>
                                            </div>
                                        </div>
                                    </div>
                                </#list>
                            </div>
                        </div>
                    </#if>
                <#else>
                    <div id="emptyCartMessage">
                        <p>По вашему запросу ничего не найдено :(</p>
                    </div>
                </#if>
            </div>
        </div>
    </div>
</body>
</html>

