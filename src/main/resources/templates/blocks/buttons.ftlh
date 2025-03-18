<style>
    .btn-round {
        width: 54px;
        height: 54px;
        font-size: 18px;
        border-radius: 40px;
        box-shadow: 0 5px 15px rgba(255, 255, 255, 0.35);
        color: #ffffff;
        border: 2px solid #ffffff;


        display: flex;                /* Используем Flexbox */
        align-items: center;          /* Центрирование по вертикали */
        justify-content: center;      /* Центрирование по горизонтали */

        position: relative;
        overflow: hidden;
        transition: width 0.3s ease;
    }

    .btn-round span{
        position: absolute;
        left: 48px;
        padding-bottom: 3px;
        opacity: 0;
        white-space: nowrap;
        transition: opacity 0.3s ease; /* Плавное появление текста */
        color: #ffffff;
    }

    .btn-round:hover{
        justify-content: flex-start; /* Иконка перемещается вправо */
        padding-left: 12px;
    }

    .btn-round:hover span {
        opacity: 1; /* Показать текст при наведении */
    }

    .btn-round:hover,
    .btn-round:focus,
    .btn-round:active {
        border: 2px solid white !important;
        color: white !important;
    }


    .btn-favorites:hover {
        width: 160px;
    }

    /* Стили при наведении */
    .btn-search:hover{
        width: 130px; /* Увеличиваем ширину кнопки при наведении */
    }

    .btn-logout:hover {
        width: 120px; /* Увеличиваем ширину кнопки при наведении */
    }


    .search-button {
        width: 150px;
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
    .search-button:focus{
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.5) !important;
        color: #000000 !important;
        border: none !important;
    }




    .close-button {
        width: 60px;
        background-color: transparent; /* Прозрачный фон */
        border: none; /* Убираем границу */
        cursor: pointer; /* Курсор в виде указателя */
    }

    .close-button:hover {
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.5) !important;
        color: #000000 !important;
        border: none !important;
        padding-left: 16px;
    }

</style>