<style>

    @font-face {
        font-family: 'Mikodacs';
        src: url('/fonts/Mikodacs-fMac.otf') format('opentype');
        font-weight: normal;
        font-style: normal;
    }

    /* Использование */

    .mikodacs-text {
        font-family: 'Mikodacs', sans-serif;
    }

    body {
        margin: 0;
        padding: 0;
        background-color: #F3F1ED;
    }


    .form-inline .form-group, .form-inline {
        display: flex;
        align-items: center;
    }

    .search-bar {
        padding-left: 17px;
        height: 54px;
        width: 82rem;
        font-size: 18px;
        border-radius: 40px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.35);
        flex-grow: 1;
    }

    /* Прогресс бар */
    .progress {
        background-color: #E6E6E6;
        height: 30px;
    }

    /* Контейнер для прогресс-бара */
    #progress-container {
        width: 100%; /* Ширина на всю модалку */
        height: 30px; /* Высота прогресс-бара */
        margin: 0 auto;
        position: relative;
        border-radius: 35px;
        overflow: hidden;
    }

    /* Основной прогресс-бар */
    .progress-bar {
        width: 100%;
        height: 100%;
        background: linear-gradient(to right, #A864DD 0%, #5C91FE 33%, #FF9A66 66%, #FA6252 100%);
        position: absolute;
        top: 0;
        left: 0;
    }

    /* Анимация уменьшения ширины */
    .shrinker {
        background-color: #F3F1ED;
        position: absolute;
        top: 0;
        right: 0;
        width: 100%;
        height: 100%;
        animation-name: timelapse;
        animation-fill-mode: forwards;
        animation-timing-function: linear;
    }


    @keyframes timelapse {
        0% {
            width: 100%;
        }
        100% {
            width: 0%;
        }
    }



    .loading-animation {
        position: relative;
        width: 100%;
        height: 100px; /* высота контейнера */
        overflow: hidden;
        background-color: #fff; /* Фоновый цвет */
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .modal-header {
        display: flex; /* Используем Flexbox */
        justify-content: space-between; /* Распределяем пространство между элементами */
        align-items: flex-start; /* Выравниваем элементы по верхнему краю */
        padding: 1rem; /* Добавляем отступы */
        width: 100%; /* Ширина на всю модалку */
    }

    .header-content {
        display: grid;
        grid-template-rows: auto auto; /* Две строки для заголовка и текста */
        gap: 0.5rem; /* Отступ между строками */
    }

    .modal-title {
        margin: 0; /* Убираем отступы вокруг заголовка */
    }

    .changing-text {
        color: grey; /* Цвет текста */
        font-size: 16px; /* Размер шрифта */
        margin: 0; /* Убираем отступы вокруг текста */
    }



    p {
        font-size: 18px;
    }


    .color-background {
        display: grid;
        background-color: #7f2f8d;
        background-image: radial-gradient(at 36% 24%, hsla(201, 88%, 63%, 1) 0, hsla(201, 88%, 63%, 0) 50%),
                          radial-gradient(at 82% 78%, hsla(30, 85%, 65%, 1) 0, hsla(30, 85%, 65%, 0) 50%),
                          radial-gradient(at 35% 89%, hsla(223, 90%, 67%, 1) 0, hsla(223, 90%, 67%, 0) 50%),
                          radial-gradient(at 90% 10%, hsla(0, 85%, 65%, 1) 0, hsla(0, 85%, 70%, 0) 50%);
    }


    .container-custom {
        margin: 2rem 4rem;
    }

    .search-container {
        display: flex;
        justify-content: left;
    }


    input[type=text]:hover,
    input[type=text]:active{
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.5) !important;
        border: none !important;
    }


</style>

<script>
    function showProgressBar(duration) {
        var myModal = new bootstrap.Modal(document.getElementById('progressModal'), {
        backdrop: 'static',  // Не закрывается при клике вне модального окна
        keyboard: false      // Не закрывается при нажатии клавиши Escape
    });
        myModal.show();

        // Удаляем старый класс с анимацией, если он есть
        var shrinker = document.querySelector('.shrinker');
        shrinker.style.animationDuration = duration + 's';

        // Анимация смены текста
        var texts = ["Обрабатываем ваш запрос", "Формируем запрос", "Проверяем цены на маркетплейсах",
        "Ищем лучшие предложения для вас", "Сравниваем и выбираем лучшие товары"];
        var textIndex = 0;
        var changingText = document.getElementById('changing-text');

        setInterval(function() {
        textIndex = (textIndex + 1) % texts.length;
        changingText.textContent = texts[textIndex];
    }, 4000); // Меняет текст каждые 4 секунды
    }

</script>


<!-- Модальное окно с прогресс-баром -->
<div class="modal fade" id="progressModal" tabindex="-1" aria-labelledby="progressModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <!-- Заголовок и текст -->
                <div class="header-content">
                    <h4 class="modal-title" id="progressModalLabel">Загрузка...</h4>
                    <p id="changing-text" class="changing-text">Обрабатываем ваш запрос</p>
                </div>
                <!-- Кнопка "крестик" -->
                <form action="/stopLoading" method="post">
                    <button type="submit" class="btn-close" data-bs-dismiss="modal" aria-label="Закрыть"></button>
                </form>
            </div>

            <div class="modal-body">
                <!-- Контейнер для прогресс-бара -->
                <div id="progress-container">
                    <div class="progress-bar"></div>
                    <div class="shrinker timelapse"></div>
                </div>
            </div>
        </div>
    </div>
</div>