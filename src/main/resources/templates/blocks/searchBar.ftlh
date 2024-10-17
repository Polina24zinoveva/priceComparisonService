<style>
    .form-inline .form-group, .form-inline {
        display: flex;
        align-items: center;
    }

    .search-bar {
        margin-top: 10px;
        height: 46px;
        font-size: 18px;
    }

    /* Прогресс бар */
    .progress {
        height: 30px;
        background-color: #D6EFD8;
    }

    .progress-bar {
        background-color: #7FB77E;
        animation: progressAnimation 27s linear forwards;
    }

    @keyframes progressAnimation {
        from { width: 0%; }
        to { width: 100%; }
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
        background: #7FB77E;
    }

    .container-custom{
        margin-top: 2rem;
        margin-bottom: 2rem;
        margin-left: 17rem;
        margin-right: 4rem;
    }

    .search-container {
        display: flex;
        justify-content: left;
    }

    .searchBar-background {
        background-color: #ffffff;
        border-top-left-radius: 50px;  /* Закругление левого верхнего угла */
        border-top-right-radius: 50px; /* Закругление правого верхнего угла */
    }

    .searchBar-container {
        margin-left: 16rem;
        width: 76rem;
        margin-top: 2rem;
        margin-bottom: 2rem;
    }

    .btn-favorites {
        width: 54px;
        height: 54px;
        font-size: 18px;
        border-radius: 40px;
        color: #FFFFFF;
        border: 1px solid #FFFFFF;
        box-shadow: 0 5px 15px rgba(255, 255, 255, 0.35);


        display: flex;                /* Используем Flexbox */
        align-items: center;          /* Центрирование по вертикали */
        justify-content: center;      /* Центрирование по горизонтали */

        position: relative;
        overflow: hidden;
        transition: width 0.3s ease;
    }

    /* Стили текста, который появляется при наведении */
    .btn-favorites span {
        position: absolute;
        left: 48px;
        padding-bottom: 3px;
        opacity: 0;
        white-space: nowrap;
        transition: opacity 0.3s ease; /* Плавное появление текста */
        color: #FFFFFF;
    }

    /* Стили при наведении */
    .btn-favorites:hover {
        border: 2px solid #FFFFFF;
        width: 160px; /* Увеличиваем ширину кнопки при наведении */
        justify-content: flex-start; /* Иконка перемещается вправо */
        padding-left: 12px;
        color: #FFFFFF;
    }

    .btn-favorites:hover span {
        opacity: 1; /* Показать текст при наведении */
    }
    .btn-favorites:hover:focus:active  {
        color: #FFFFFF;
        border: 1px solid #FFFFFF;
    }


    .btn-search {
        width: 150px;
        height: 46px;
        margin-top: 10px;
        border-color: #80AF81;
        background-color: #80AF81;
        font-size: 18px;
        color: #ffffff;
    }

    .btn-search:hover {
        color: #80AF81;
        border-color: #80AF81;
        background-color: rgba(214, 239, 216, 0.5);
    }

    input[type=text]:hover {
      border: 2px solid #80AF81;
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
        var texts = ["Обрабатываем ваш запрос", "Проверяем цены на Wildberries", "Проверяем цены на Ozon",
         "Ищем лучшие предложения для вас", "Сравниваем и выбираем лучшие предложения"];
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
