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
        .btn-card {
            width: 100%;
            height: 46px;
            margin-top: 1rem;
            border-color: #80AF81;
            background-color: #80AF81;
            font-size: 18px;
            color: #ffffff;
            position: relative;
            overflow: hidden;
            transition: width 0.3s ease;
        }

        .btn-card:hover {
            color: #80AF81;
            border-color: #80AF81;
            background-color: rgba(214, 239, 216, 0.5);
        }

        .container-custom{
            margin: 2rem;
        }

        /* Прогресс бар */
        .progress {
            height: 20px;
            background-color: #E0F1EC;
            margin-bottom: 1rem;
        }

        .progress-bar {
            background-color: #01796F;
        }

        .progress-bar-long {
            background-color: #01796F;
        }

        @keyframes progressAnimation10s {
            from { width: 0%; }
            to { width: 100%; }
        }

        @keyframes progressAnimation30s {
            from { width: 0%; }
            to { width: 100%; }
        }

        .progress-bar.animation-10s {
            animation: progressAnimation10s 10s linear forwards;
        }

        .progress-bar.animation-30s {
            animation: progressAnimation30s 30s linear forwards;
        }


        #emptyCartMessage {
            flex-direction: column; /* Отображаем дочерние элементы в столбце */
            justify-content: center; /* Выравниваем элементы по вертикали */
            align-items: center; /* Выравниваем элементы по горизонтали */
        }

        .searchBar-container {
            width: 82rem;
            margin-top: 2rem;
            margin-bottom: 2rem;
        }

        .custom-link {
            color: #000000;
            text-decoration: none;
            font-size: 20px;
        }
        .custom-link:hover {
            text-decoration: underline; /* Подчеркивание при наведении */
        }

        h3 {
            margin-top: 10px;
            margin-bottom: 36px;
            margin-left: 1rem;
            color: #1A5319;
        }

        .card-container {
            width: 18rem;
            height: 46rem;
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
            max-height: 34px;
            overflow: hidden;
            margin-bottom: 1rem;
        }

        <#include "blocks/searchBar.ftlh">
    </style>
</head>
<script>
    function showProgressBar(duration) {
        var myModal = new bootstrap.Modal(document.getElementById('progressModal'), {
            backdrop: 'static',  // Не закрывается при клике вне модального окна
            keyboard: false      // Не закрывается при нажатии клавиши Escape
        });
        myModal.show();

        // Найдите элементы прогресс-баров
        var progress10Sec = document.querySelector('#progress10Sec .progress-bar');
        var progress30Sec = document.querySelector('#progress30Sec .progress-bar');

        // Установите начальные ширины (0%)
        progress10Sec.style.width = '0%';
        progress30Sec.style.width = '0%';

        // Удалите любые предыдущие анимации
        progress10Sec.classList.remove('animation-10s');
        progress30Sec.classList.remove('animation-30s');

        // Запустите нужную анимацию в зависимости от длительности
        if (duration === 10) {
            progress10Sec.classList.add('animation-10s');
        } else if (duration === 30) {
            progress30Sec.classList.add('animation-30s');
        }
    }

    function show10SecProgressBar() {
        document.getElementById("progress-container-long").style.display = "none"
        document.getElementById("progress-container-short").style.display = "block"
        showProgressBar(10);
    }

    function show30SecProgressBar() {
        document.getElementById("progress-container-short").style.display = "none"
        document.getElementById("progress-container-long").style.display = "block"

        showProgressBar(30);
    }



</script>
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
                <#if cards??>
                    <#if cards?size = 0>
                        <div id="emptyCartMessage" class="d-flex flex-column justify-content-center align-items-center" style="height: 94%;">
                            <h4>У вас нет избранных товаров</h4>
                        </div>
                    <#else>
                        <h3>Избранные товары</h3>
                        <div style="margin-top: 1rem; margin-left: 1rem; margin-right: 120px;">
                            <div class="row">
                                <#list cards as card>
                                    <div class="col-md-4">
                                        <div class="card" style="margin-bottom:1rem;">
                                            <div class="card-container">
                                                <#if card.cardImageUrl??>
                                                    <div class="photo-container">
                                                        <img src="${card.cardImageUrl}" class="card-img-top photo" alt="Фото">
                                                        <input type="hidden" name="cardImageUrl" value="${card.cardImageUrl}">
                                                    </div>
                                                <#else>
                                                </#if>
                                                <div class="text-container">
                                                    <div class="d-flex justify-content-between" style="margin-top: 1rem;">
                                                        <h4>${card.cardMarketplace}</h4>
                                                        <p style="font-size: 20px; font-weight: 480; color: #595c5f;" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Цена не является актуальной. Рекомендуем проверить цену, для получения актуальной информации"> ${card.cardPrice} ₽</p>
                                                    </div>
                                                    <div class="name">
                                                        <a href="${card.cardUrl}" class="custom-link">${card.cardName}</a>
                                                    </div>


                                                    <div class="d-grid d-md-flex">
                                                        <div class="d-flex align-items-center justify-content-center" style="margin-right:1rem;">
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
                                                                <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                                                            </svg>
                                                            <p style="margin: 0 0 0 4px; font-size: 18px;">${card.cardRating?string("0.0")?replace(",", ".")}</p>
                                                        </div>
                                                        <#if card.cardCountReviews % 10 == 1>
                                                            <p class="card-reviews" style="margin: 0; font-size: 18px;">${card.cardCountReviews} оценка</p>
                                                        <#else>
                                                            <#if card.cardCountReviews % 10 == 2>
                                                                <p class="card-reviews" style="margin: 0; font-size: 18px;">${card.cardCountReviews} оценки</p>
                                                            <#else>
                                                                 <p class="card-reviews" style="margin: 0; font-size: 18px;">${card.cardCountReviews} оценок</p>
                                                            </#if>
                                                        </#if>
                                                    </div>
                                                </div>

                                                <form action="/checkPrice" method="post" onsubmit="show10SecProgressBar()">
                                                    <input type="hidden" name="url" value="${card.cardUrl}">
                                                    <input type="hidden" name="marketplace" value="${card.cardMarketplace}">
                                                    <button class="btn btn-card" type="submit">
                                                        <div class="d-flex align-items-center justify-content-center" style="margin-right:1rem;">
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-graph-up" viewBox="0 0 16 16">
                                                              <path fill-rule="evenodd" d="M0 0h1v15h15v1H0zm14.817 3.113a.5.5 0 0 1 .07.704l-4.5 5.5a.5.5 0 0 1-.74.037L7.06 6.767l-3.656 5.027a.5.5 0 0 1-.808-.588l4-5.5a.5.5 0 0 1 .758-.06l2.609 2.61 4.15-5.073a.5.5 0 0 1 .704-.07"/>
                                                            </svg>
                                                            <p style="margin: 0 0 0 8px; font-size: 18px;">Проверить цену</p>
                                                        </div>
                                                    </button>
                                                </form>

                                                <form action="/resultsSearch" method="post" onsubmit="show30SecProgressBar()">
                                                    <input type="hidden" name="searchText" value="${card.cardSearchText}">
                                                    <button class="btn btn-card" type="submit">
                                                        <div class="d-flex align-items-center justify-content-center" style="margin-right:1rem;">
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                                                              <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
                                                            </svg>
                                                            <p style="margin: 0 0 0 8px; font-size: 18px;">Посмотреть все цены</p>
                                                        </div>
                                                    </button>
                                                </form>

                                                <form action="/deleteFavorite" method="post">
                                                    <input type="hidden" name="idFavorite" value="${card.id}">
                                                    <button class="btn btn-card" type="submit">
                                                        <div class="d-flex align-items-center justify-content-center" style="margin-right:1rem;">
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-trash3" viewBox="0 0 16 16">
                                                              <path d="M6.5 1h3a.5.5 0 0 1 .5.5v1H6v-1a.5.5 0 0 1 .5-.5M11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3A1.5 1.5 0 0 0 5 1.5v1H1.5a.5.5 0 0 0 0 1h.538l.853 10.66A2 2 0 0 0 4.885 16h6.23a2 2 0 0 0 1.994-1.84l.853-10.66h.538a.5.5 0 0 0 0-1zm1.958 1-.846 10.58a1 1 0 0 1-.997.92h-6.23a1 1 0 0 1-.997-.92L3.042 3.5zm-7.487 1a.5.5 0 0 1 .528.47l.5 8.5a.5.5 0 0 1-.998.06L5 5.03a.5.5 0 0 1 .47-.53Zm5.058 0a.5.5 0 0 1 .47.53l-.5 8.5a.5.5 0 1 1-.998-.06l.5-8.5a.5.5 0 0 1 .528-.47M8 4.5a.5.5 0 0 1 .5.5v8.5a.5.5 0 0 1-1 0V5a.5.5 0 0 1 .5-.5"/>
                                                            </svg>
                                                            <p style="margin: 0 0 0 8px; font-size: 18px;">Удалить из избранного</p>
                                                        </div>
                                                    </button>
                                                </form>

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

                        <!-- Модальное окно с двумя прогресс-барами -->
                        <div class="modal fade" id="progressModal" tabindex="-1" aria-labelledby="progressModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="progressModalLabel">Загрузка...</h5>
                                    </div>
                                    <div class="modal-body">
                                        <div id="progress-container-short" class="progress-container-short">
                                            <div class="progress" id="progress10Sec">
                                                <div class="progress-bar" role="progressbar"></div>
                                            </div>
                                        </div>
                                        <div id="progress-container-long" class="progress-container-long">
                                            <div class="progress" id="progress30Sec">
                                                <div class="progress-bar progress-bar-long" role="progressbar"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </#if>
                <#else>
                    <div id="emptyCartMessage" class="d-flex flex-column justify-content-center align-items-center" style="height: 94%;">
                        <h4>По вашему запросу ничего не найдено</h4>
                    </div>
                </#if>
            </div>
        </div>
    </div>
</body>
</html>

