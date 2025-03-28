<!DOCTYPE html>
<html lang="ru">

<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="icon" href="icon.png" type="image/x-icon">

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>

    <title>Сервис для сравнения цен на товары</title>

    <style>

        .progress-bar10 {
            background: linear-gradient(90deg, #a864dd, #5c91fe, #ff9a66, #fa6252);
            background-size: 200% 100%; /* Увеличиваем размер фона, чтобы градиент не растягивался */
            background-repeat: no-repeat;
            animation: progressAnimation 15s linear forwards, gradientMove 15s infinite linear;
        }


        #emptyCartMessage {
            flex-direction: column; /* Отображаем дочерние элементы в столбце */
            justify-content: center; /* Выравниваем элементы по вертикали */
            align-items: center; /* Выравниваем элементы по горизонтали */
        }

        .custom-link {
            color: #000000;
            text-decoration: none;
            font-size: 20px;
        }
        .custom-link:hover {
            text-decoration: underline; /* Подчеркивание при наведении */
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
            max-height: 34px;
            overflow: hidden;
            margin-bottom: 1rem;
        }

        .btn-card {
            width: 100%;
            height: 46px;
            margin-top: 1rem;
            border-radius: 30px;
            border-color: none;
            background-color: none;
            color: black;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.35);
            font-size: 18px;
            font-size: 18px;
            position: relative;
            overflow: hidden;
            transition: width 0.3s ease;
        }

        .btn-card:hover {
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.5);
            color: black;
        }

        .searchText{
            margin-top:3rem;
            margin-bottom:2rem;

            font-size: 18px;
        }

        .aTitle{
            font-size: 34px;
            text-decoration:none;
            text-transform: uppercase;
            font-weight: bold;
            color: black
        }


        <#include "blocks/searchBar.ftlh">
    </style>
</head>
<script>
    function show10SecProgressBar() {
        var myModal = new bootstrap.Modal(document.getElementById('progressModal10'), {
            backdrop: 'static',  // Не закрывается при клике вне модального окна
            keyboard: false      // Не закрывается при нажатии клавиши Escape
        });
        myModal.show();

        // Находим элемент прогресс-бара
        var progressBar = document.querySelector('.progress-bar10');

        // Устанавливаем начальную ширину (0%)
        progressBar.style.width = '0%';

        // Анимация смены текста
        var texts = ["Обрабатываем ваш запрос", "Формируем запрос", "Проверяем цены на маркетплейсах",
         "Ищем лучшие предложения для вас", "Сравниваем и выбираем лучшие товары"];
        var textIndex = 0;
        var changingText = document.getElementById('changing-text');

        setInterval(function() {
            textIndex = (textIndex + 1) % texts.length;
            changingText.textContent = texts[textIndex];
        }, 4000); // Меняет текст каждые 2 секунды

        marketplaces
    }

</script>

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
    function showWarningCheck(warningCheck, idFavorite) {
        if (!idFavorite) {
            console.error("idFavorite не передан!");
            Swal.fire("Ошибка!", "ID товара не найден", "error");
            return;
        }

        Swal.fire({
            title: warningCheck,
            text: "Удалить товар из избранного?",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#676767",
            cancelButtonColor: "#000000",
            confirmButtonText: "Удалить",
            cancelButtonText: "Отмена"
        }).then((result) => {
            if (result.isConfirmed) {
                deleteFavorite(idFavorite);
            }
        });
    }
    function deleteFavorite(idFavorite) {
        fetch("/deleteFavorite", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: "idFavorite=" + encodeURIComponent(idFavorite)
        }).then(response => {
            window.location.href = "favorites";
        })
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
    <#if warningCheck??>
        <script>
            showWarningCheck("${warningCheck}", "${idFavorite}");
        </script>
    </#if>
    <#if error??>
        <script>
            showError("${error}");
        </script>
    </#if>

    <#include "blocks/header.ftlh">

    <div style="display: grid;">
        <div style="margin: 2rem 4rem;">
            <#if cards??>
                <#if cards?size = 0>
                    <div id="emptyCartMessage" class="d-flex flex-column justify-content-center align-items-center" style="height: 94%;">
                        <h4>У вас нет избранных товаров</h4>
                    </div>
                <#else>
                    <div class="searchText">
                        <a href="/favorites" class="aTitle">Избранные товары</a>
                    </div>
                    <div class="row">
                        <#list cards as card>
                            <div class="col-md-3">
                                <div class="card" style="margin-bottom:1rem;">
                                    <#if card.cardImageUrl??>
                                        <div class="photo-container">
                                            <img src="${card.cardImageUrl}" class="card-img-top photo" alt="Фото">
                                        </div>
                                    <#else>
                                    </#if>
                                    <div class="card-container">
                                        <div class="text-container">
                                            <div class="d-flex justify-content-between" style="margin-top: 1rem;">
                                                <h4 style="color:
                                                   <#if card.cardMarketplace == "Wildberries">#A864DD;</#if>
                                                   <#if card.cardMarketplace == "Ozon">#5C91FE;</#if>
                                                   <#if card.cardMarketplace == "Яндекс Маркет">#FF9A66;</#if>
                                                   <#if card.cardMarketplace == "Магнит Маркет">#FA6252;</#if>
                                                ">
                                                ${card.cardMarketplace}</h4>
                                                <p style="font-size: 20px; font-weight: 480; color: #595c5f;" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Рекомендуем проверить цену, для получения актуальной информации"> ${card.cardPrice} ₽</p>
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

                                        <form action="/checkPrice" method="post" onsubmit="showProgressBar(10)">
                                            <input type="hidden" name="url" value="${card.cardUrl}">
                                            <input type="hidden" name="idFavorite" value="${card.id}">
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

                                        <form action="/resultsSearch" method="post" onsubmit="showProgressBar(52)">
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
                </#if>
            <#else>
                <div id="emptyCartMessage" class="d-flex flex-column justify-content-center align-items-center" style="height: 94%;">
                    <h4>По вашему запросу ничего не найдено</h4>
                </div>
            </#if>
        </div>
    </div>
</body>
</html>

