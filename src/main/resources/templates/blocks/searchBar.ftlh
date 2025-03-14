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

    .progress-bar {
        background: linear-gradient(90deg, #a864dd, #5c91fe, #ff9a66, #f85340);
        background-size: 200% 100%; /* Увеличиваем размер фона, чтобы градиент не растягивался */
        background-repeat: no-repeat;
        animation: progressAnimation 50s linear forwards, gradientMove 50s infinite linear;
    }

    @keyframes progressAnimation {
        from {
            width: 0%;
            background-position: 100% 0; /* Начинаем с конца градиента */
        }
        to {
            width: 100%;
            background-position: 0 0; /* Градиент двигается влево, открывая новые цвета */
        }
    }

    @keyframes gradientMove {
        0% {
            background-position: 0 50%;
        }
        100% {
            background-position: 100% 50%;
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
        display: grid;
        grid-template-rows: auto auto; /* Создаем две строки: одна для заголовка, другая для текста */
        justify-items: start; /* Выровнять содержимое по левому краю */
        padding: 1rem; /* Добавим немного отступов вокруг содержимого */
        width: 100%; /* Убедимся, что ширина соответствует модальному окну */
    }

    .header-content {
        display: grid;
        grid-template-rows: auto auto; /* Определяем строки для заголовка и текста */
    }

    p {
        font-size: 18px;
    }

    .modal-title {
        margin: 0; /* Убираем отступы вокруг заголовка */
    }

    .changing-text {
        color: grey; /* Цвет текста */
        font-size: 16px; /* Размер шрифта */
        margin: 0; /* Убираем отступы вокруг текста */
    }



    .color-background {
        display: grid;
        background-color: #7f2f8d;
        background-image: radial-gradient(at 36% 24%, hsla(201, 88%, 63%, 1) 0, hsla(201, 88%, 63%, 0) 50%),
                          radial-gradient(at 82% 78%, hsla(30, 85%, 65%, 1) 0, hsla(30, 85%, 65%, 0) 50%),
                          radial-gradient(at 35% 89%, hsla(223, 90%, 67%, 1) 0, hsla(223, 90%, 67%, 0) 50%),
                          radial-gradient(at 90% 10%, hsla(0, 85%, 65%, 1) 0, hsla(0, 85%, 70%, 0) 50%);
    }


    .container-custom{
        margin: 2rem 4rem;
    }

    .search-container {
        display: flex;
        justify-content: left;
    }


    .btn-favorites {
        width: 54px;
        height: 54px;
        font-size: 18px;
        border-radius: 40px;
        box-shadow: 0 5px 15px rgba(255, 255, 255, 0.35);


        display: flex;                /* Используем Flexbox */
        align-items: center;          /* Центрирование по вертикали */
        justify-content: center;      /* Центрирование по горизонтали */

        position: relative;
        overflow: hidden;
        transition: width 0.3s ease;
    }

    .btn-favorites span {
        position: absolute;
        left: 48px;
        padding-bottom: 3px;
        opacity: 0;
        white-space: nowrap;
        transition: opacity 0.3s ease; /* Плавное появление текста */
    }

    /* Стили при наведении */
    .btn-favorites:hover {
        width: 160px; /* Увеличиваем ширину кнопки при наведении */
        justify-content: flex-start; /* Иконка перемещается вправо */
        padding-left: 12px;
    }

    .btn-favorites:hover span {
        opacity: 1; /* Показать текст при наведении */
    }


    .search-button {
        width: 150px; /* Увеличиваем ширину кнопки при наведении */
        justify-content: flex-start; /* Иконка перемещается вправо */
        padding-left: 12px;
        height: 54px;
        font-size: 18px;
        border-radius: 40px;
        color: #000000;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.35);


        position: relative;
        overflow: hidden;
    }

    /* Стили при наведении */
    .search-button:hover,
    .search-button:active,
    .search-button:focus,{
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.5) !important;
        color: #000000 !important;
        border: none !important;
    }

    input[type=text]:hover,
    input[type=text]:active{
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.5) !important;
        border: none !important;
    }


</style>

<script>
    function showProgressBar() {
        var myModal = new bootstrap.Modal(document.getElementById('progressModal'), {
            backdrop: 'static',  // Не закрывается при клике вне модального окна
            keyboard: false      // Не закрывается при нажатии клавиши Escape
        });
        myModal.show();

        // Находим элемент прогресс-бара
        var progressBar = document.querySelector('.progress-bar');

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


<!-- Модальное окно с прогресс-баром -->
<div class="modal fade" id="progressModal" tabindex="-1" aria-labelledby="progressModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <div class="header-content">
                    <h4 class="modal-title" id="progressModalLabel">Загрузка...</h4>
                    <p id="changing-text" class="changing-text">Обрабатываем ваш запрос</p>
                </div>
            </div>

            <div class="modal-body">
                <div class="progress">
                    <div class="progress-bar" role="progressbar"></div>
                </div>
            </div>
        </div>
    </div>
</div>
