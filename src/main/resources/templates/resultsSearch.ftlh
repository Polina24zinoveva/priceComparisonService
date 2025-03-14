<!DOCTYPE html>
<html lang="ru">

<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="icon" href="icon.png" type="image/x-icon">

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>

    <#include "blocks/searchBar.ftlh">

    <title>Сервис для сравнения цен на товары</title>

    <style>
        #emptyCartMessage {
            margin-left: 2rem;
            margin-top: 2rem;
            font-size: 24px;
            font-weight: 480
        }

        .settings-and-cards{
            margin: 2rem 0;
        }

        .filters-and-sort{
            margin: 2rem 0;
        }

        .searchText{
            margin-top:3rem;
            margin-bottom:2rem;

            font-size: 18px;
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

        .dropdown-toggle {
            font-size: 18px;
            border: none !important;
        }


        .dropdown-toggle:focus,
        .dropdown-toggle:active,
        .dropdown-toggle:hover {
            border: none !important;
            outline: none; /* Убираем рамку при фокусе */
            box-shadow: none; /* Убираем тень, если она появляется */
            text-decoration: underline;
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
            background-color: #DEE2E6;
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

        input[type="checkbox"]:checked {
          background-color: #989ca0;
        }

        input[type="radio"]:checked {
          background-color: #989ca0;
        }

        .card {
            border-radius: 20px;
            overflow: hidden;
            width: 21rem;
        }

        .card-container {
            margin: 1rem 2rem;
        }

        .photo-container {
            width: 21rem; /* Фиксируем ширину */
            height: 21rem; /* Фиксируем высоту (равную ширине, чтобы был квадрат) */
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden; /* Обрезка изображения */
        }

        .photo {
            width: 100%;
            height: 100%;
            object-fit: cover; /* Заполняем контейнер, сохраняя пропорции */
            object-position: center; /* Центрируем фото */
        }


        .text-container {
            height: 8rem;
        }


        .name {
            max-height: 30px;
            overflow: hidden;
            margin-bottom: 1rem;
        }


        .custom-link {
            color: #000000;
            text-decoration: none;
            font-size: 18px;
        }

        .custom-link:hover {
            text-decoration: underline; /* Подчеркивание при наведении */
        }


        .btn-card {
            width: 100%;
            height: 46px;
            margin-top: 1rem;
            border-radius: 30px;
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
            border-color: #f85340;
            background-color: #f85340;
            color: #ffffff;
        }

        .btn-card:hover {
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.35);
        }

        .btn-card-wb:hover,
        .btn-card-wb:active{
            background-color: #A864DD !important;
            color: #ffffff !important;
        }

        .btn-card-ozon:hover,
        .btn-card-ozon:active{
            background-color: #5C91FE !important;
            color: #ffffff !important;
        }

        .btn-card-ym:hover,
        .btn-card-ym:active{
            background-color: #FF9A66 !important;
            color: #ffffff !important;
        }

        .btn-card-mm:hover,
        .btn-card-mm:active{
            background-color: #FA6252 !important;
            color: #ffffff !important;
        }


        .btn-in-filters{
            border: 1px solid #DEE2E6;
            background-color: #DEE2E6;
        }

        .btn-in-filters:hover{
            border: 1px solid black;
            background-color: #DEE2E6;
        }

        .filter-button {
            height: 36px;
            font-size: 16px;
            border-radius: 30px;
            background-color: #E6E6E6;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 0 20px;
            cursor: pointer;
            border: none;
        }

        .filter-button:hover {
            border: 1px solid #2B2B2B;
        }

        .filters{
            margin-bottom: 3rem;
        }
    </style>
</head>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    function showMessage(message) {
        Swal.fire({
          text: message,
          icon: "success",
          confirmButtonColor: '#676767'
        });
    }
    function showWarning(warning) {
        Swal.fire({
          text: warning,
          icon: "warning",
          confirmButtonColor: '#676767'
        });
    }
    function showError(error) {
        Swal.fire({
          text: error,
          icon: "error",
          confirmButtonColor: '#676767'
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

    <#include "blocks/header.ftlh">

    <div style="display: grid;">
        <div style="margin: 0 4rem;">
            <div class="searchText">
                <p style="font-size: 34px; text-transform: uppercase; font-weight: bold;">${searchText}</p>
            </div>

            <div class="settings-and-cards">
                <div class="filters-and-sort d-flex justify-content-between">

                    <div class="d-flex">
                        <!-- Фильтры -->

                        <div class="btn-group me-1" role="group">
                            <button type="button" class="btn dropdown-toggle" style="padding-left:0;" data-bs-toggle="dropdown" aria-expanded="false">
                                Маркетплейс
                            </button>
                            <form action="/filters" method="post">
                                <ul class="dropdown-menu" style="width:232px;">
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
                                    <li>
                                        <button type="submit" class="btn btn-in-filters" style="width:200px;">Применить</button>
                                    </li>
                                </ul>
                            </form>
                        </div>

                        <div class="btn-group me-1" role="group">
                            <button type="button" class="btn dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                                Цена
                            </button>
                            <form action="/filters" method="post">
                                <ul class="dropdown-menu" style="width:260px; height: 54px;">
                                    <li>
                                        <div class="input-group mb-3">
                                            <input type="number" name="minPrice" class="form-control" min="0" max="100000000" placeholder="от ${minPrice}">
                                            <input type="number" name="maxPrice" class="form-control" min="1" max="100000000" placeholder="до ${maxPrice}">
                                            <button type="submit" class="btn btn-in-filters">ОК</button>
                                        </div>
                                    </li>
                                </ul>
                            </form>
                        </div>

                        <div class="btn-group me-1" role="group">
                            <button type="button" class="btn dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                                Рейтинг
                            </button>
                            <form action="/filters" method="post" id="ratingForm">
                                <ul class="dropdown-menu" style="width:160px;">
                                    <li>
                                        <div class="form-check sideMargin verticalMargin">
                                            <input class="form-check-input rating-checkbox" type="radio" name="rating" id="rating40" value="4.0" <#if selectedRating?? && selectedRating==4.0>checked</#if>>
                                            <label class="form-check-label" for="rating40">
                                                не ниже 4.0
                                            </label>
                                        </div>
                                        <div class="form-check sideMargin verticalMargin">
                                            <input class="form-check-input rating-checkbox" type="radio" name="rating" id="rating45" value="4.5" <#if selectedRating?? && selectedRating==4.5>checked</#if>>
                                            <label class="form-check-label" for="rating45">
                                                не ниже 4.5
                                            </label>
                                        </div>
                                        <div class="form-check sideMargin verticalMargin">
                                            <input class="form-check-input rating-checkbox" type="radio" name="rating" id="rating48" value="4.8" <#if selectedRating?? && selectedRating==4.8>checked</#if>>
                                            <label class="form-check-label" for="rating48">
                                                не ниже 4.8
                                            </label>
                                        </div>
                                        <div class="form-check sideMargin verticalMargin">
                                            <input class="form-check-input rating-checkbox" type="radio" name="rating" id="rating49" value="4.9" <#if selectedRating?? && selectedRating==4.9>checked</#if>>
                                            <label class="form-check-label" for="rating49">
                                                не ниже 4.9
                                            </label>
                                        </div>
                                        <div class="form-check sideMargin verticalMargin">
                                            <input class="form-check-input rating-checkbox" type="radio" name="rating" id="rating50" value="5.0" <#if selectedRating?? && selectedRating==5.0>checked</#if>>
                                            <label class="form-check-label" for="rating50">
                                                5.0
                                            </label>
                                        </div>
                                    </li>
                                </ul>
                            </form>
                            <script>
                                // Добавляем обработчик события change для всех radiobutton
                                document.querySelectorAll('.rating-checkbox').forEach(function(radio) {
                                    radio.addEventListener('change', function() {
                                        // Отправляем форму при выборе radiobutton
                                        document.getElementById('ratingForm').submit();
                                    });
                                });
                            </script>
                        </div>

                        <div class="btn-group me-1" role="group">
                            <button type="button" class="btn dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                                Количество заказов
                            </button>
                            <form action="/filters" method="post">
                                <ul class="dropdown-menu" style="width:260px; height: 54px;">
                                    <li>
                                        <div class="input-group mb-3">
                                            <input type="number" name="minReviews" class="form-control" min="0" max="100000000" placeholder="от ${minReviews}">
                                            <input type="number" name="maxReviews" class="form-control" min="1" max="100000000" placeholder="до ${maxReviews}">
                                            <button type="submit" class="btn btn-in-filters" style="padding-top:4px;">ОК</button>
                                        </div>
                                    </li>
                                </ul>
                            </form>
                        </div>
                    </div>


                    <!-- Сортировка -->
                    <div class="btn-group" role="group">
                        <button type="button" class="btn dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                            Сортировка
                        </button>
                        <ul class="dropdown-menu dropdown-menu-check dropdown-menu-end" style="width:260px;">
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
                </div>

                <#if (selectWb?? && selectWb==true) || (selectOzon?? && selectOzon==true) || (selectMm?? && selectMm==true)
                || (selectYm?? && selectYm==true) || selectedMinPrice?? || selectedMaxPrice?? || selectedRating??
                || selectedMinReviews?? || selectedMaxReviews??>
                    <form action="/deleteFilter" method="post" onsubmit="showProgressBar()" id="filterForm">
                        <div class="d-grid gap-2 d-md-flex justify-content-md-start filters">
                            <!-- Скрытые поля для фильтров -->
                            <input type="hidden" name="wbFilter" id="hidden-wbFilter">
                            <input type="hidden" name="ozonFilter" id="hidden-ozonFilter">
                            <input type="hidden" name="ymFilter" id="hidden-ymFilter">
                            <input type="hidden" name="mmFilter" id="hidden-mmFilter">
                            <input type="hidden" name="minPriceFilter" id="hidden-minPriceFilter">
                            <input type="hidden" name="maxPriceFilter" id="hidden-maxPriceFilter">
                            <input type="hidden" name="rating40Filter" id="hidden-rating40Filter">
                            <input type="hidden" name="rating45Filter" id="hidden-rating45Filter">
                            <input type="hidden" name="rating48Filter" id="hidden-rating48Filter">
                            <input type="hidden" name="rating49Filter" id="hidden-rating49Filter">
                            <input type="hidden" name="rating50Filter" id="hidden-rating50Filter">
                            <input type="hidden" name="minReviewsFilter" id="hidden-minReviewsFilter">
                            <input type="hidden" name="maxReviewsFilter" id="hidden-maxReviewsFilter">

                            <!-- Кнопки удаления фильтров -->
                            <#if selectWb?? && selectWb==true>
                                <button type="button" class="filter-button" onclick="deleteFilter('wbFilter')">&#x2715; Wildberries</button>
                            </#if>
                            <#if selectOzon?? && selectOzon==true>
                                <button type="button" class="filter-button" onclick="deleteFilter('ozonFilter')" style="margin-left:7px;">&#x2715; Ozon</button>
                            </#if>
                            <#if selectMm?? && selectMm==true>
                                <button type="button" class="filter-button" onclick="deleteFilter('ymFilter')" style="margin-left:7px;">&#x2715; Магнит Маркет</button>
                            </#if>
                            <#if selectYm?? && selectYm==true>
                                <button type="button" class="filter-button" onclick="deleteFilter('mmFilter')" style="margin-left:7px;">&#x2715; Яндекс Маркет</button>
                            </#if>
                            <#if selectedMinPrice??>
                                <button type="button" class="filter-button" onclick="deleteFilter('minPriceFilter')" style="margin-left:7px;">&#x2715; от ${selectedMinPrice} ₽</button>
                            </#if>
                            <#if selectedMaxPrice??>
                                <button type="button" class="filter-button" onclick="deleteFilter('maxPriceFilter')" style="margin-left:7px;">&#x2715; до ${selectedMaxPrice} ₽</button>
                            </#if>
                            <#if selectedRating?? && selectedRating==4.0>
                                <button type="button" class="filter-button" onclick="deleteFilter('rating40Filter')" style="margin-left:7px;">&#x2715; рейтинг от 4.0</button>
                            </#if>
                            <#if selectedRating?? && selectedRating==4.5>
                                <button type="button" class="filter-button" onclick="deleteFilter('rating45Filter')" style="margin-left:7px;">&#x2715; рейтинг от 4.5</button>
                            </#if>
                            <#if selectedRating?? && selectedRating==4.8>
                                <button type="button" class="filter-button" onclick="deleteFilter('rating48Filter')" style="margin-left:7px;">&#x2715; рейтинг от 4.8</button>
                            </#if>
                            <#if selectedRating?? && selectedRating==4.9>
                                <button type="button" class="filter-button" onclick="deleteFilter('rating49Filter')" style="margin-left:7px;">&#x2715; рейтинг от 4.9</button>
                            </#if>
                            <#if selectedRating?? && selectedRating==5.0>
                                <button type="button" class="filter-button" onclick="deleteFilter('rating50Filter')" style="margin-left:7px;">&#x2715; рейтинг 5.0</button>
                            </#if>
                            <#if selectedMinReviews??>
                                <button type="button" class="filter-button" onclick="deleteFilter('minReviewsFilter')" style="margin-left:7px;">&#x2715; от ${selectedMinReviews}
                                    <#if selectedMinReviews % 10 == 1>оценки<#else>оценок</#if>
                                </button>
                            </#if>
                            <#if selectedMaxReviews??>
                                <button type="button" class="filter-button" onclick="deleteFilter('maxReviewsFilter')" style="margin-left:7px;">&#x2715; до ${selectedMaxReviews}
                                    <#if selectedMaxReviews % 10 == 1>оценки<#else>оценок</#if>
                                </button>
                            </#if>

                            <a href="#" class="custom-link" style="text-decoration:underline;margin-left:7px; padding-top:4px; font-size: 16px;" id="clearFilters">Очистить все</a>
                        </div>
                    </form>
                </#if>
                <script>
                    function deleteFilter(filterName) {
                        document.getElementById('hidden-' + filterName).value = true;
                        document.getElementById('filterForm').submit();
                    }

                    document.getElementById('clearFilters').addEventListener('click', function(event) {
                        event.preventDefault();
                        document.getElementById('filterForm').submit();
                    });
                </script>
                <script>
                    document.querySelectorAll('.filter-background').forEach(function(filter) {
                        filter.addEventListener('click', function() {
                            const filterName = this.getAttribute('data-name');
                            const hiddenInput = document.getElementById('hidden-' + filterName);

                            if (hiddenInput) {
                                document.getElementById('filterForm').submit();
                            }
                        });
                    });

                    document.getElementById('clearFilters').addEventListener('click', function(event) {
                        document.getElementById('filterForm').submit();
                    });


                </script>

                <#if cards??>
                    <#if cards?size == 0>
                        <div id="emptyCartMessage">
                            <p class="fw-semibold">По вашему запросу ничего не найдено :(</p>
                        </div>
                    <#else>
                        <div class="row">
                            <#list cards as card>
                                <div class="col-md-3">
                                    <div class="card" style="margin-bottom:1rem;">
                                        <#if card.imageUrl??>
                                            <div class="photo-container">
                                                <img src="${card.imageUrl}" class="card-img-top photo" alt="Фото">
                                            </div>
                                        <#else>
                                        </#if>
                                        <div class="card-container">
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

                                                    <button type="submit" class="btn btn-card
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

