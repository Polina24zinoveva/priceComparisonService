<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@500&display=swap" rel="stylesheet">
    <link rel="icon" href="diploma_icon.png" type="image/x-icon">

    <style>
        .body-login{
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 90vh;
            background-color: #ffffff;
            border-top-left-radius: 50px;  /* Закругление левого верхнего угла */
            border-top-right-radius: 50px; /* Закругление правого верхнего угла */
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


        .main{
            width: 500px;
            height: 500px;
            overflow: hidden;
            background: #7FB77E;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.35);
        }
        #chk{
            display: none;
        }

        .login{
            position: relative;
            width: 100%;
            height: 100%;
        }
        label{
            color: #ffffff;
            font-size: 2.3em;
            justify-content: center;
            display: flex;
            margin: 50px;
            font-weight: bold;
            cursor: pointer;
            transition: .5s ease-in-out;
        }

        p{
            color: #ffffff;
            font-size: 1em;
            justify-content: center;
            display: flex;
            margin: 20px;
            cursor: pointer;
        }

        .input-container {
            display: flex;
            flex-direction: column;
            align-items: center; /* Центрирование по горизонтали */
            margin-top: 30px;
        }

        input{
            width: 60%;
            height: 50px;
            background: #ffffff;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.35);
            justify-content: center;
            display: flex;
            padding: 12px;
            border: none;
            outline: none;
            border-radius: 5px;
            margin-top: 20px;
            font-size: 18px;
        }

        .custom-button{
            width: 60%;
            height: 50px;
            margin: 10px auto;
            justify-content: center;
            display: block;
            color: #FFFFFF;
            background: #7FB77E;
            border: 2px solid #FFFFFF;
            box-shadow: 0 5px 15px rgba(255, 255, 255, 0.35);

            font-size: 18px;

            margin-top: 30px;
            outline: none;
            border-radius: 5px;
            transition: .2s ease-in;
            cursor: pointer;
        }

        .custom-button:hover{
            background: #7FB77E;
            border: 2px solid #1A5319;
            color: #1A5319;
        }

        .signup{
            height: 600px;
            background: #ffffff;
            border-radius: 60% / 10%;
            transform: translateY(-180px);
            transition: .8s ease-in-out;
        }

        .signup input{
            background: #ffffff;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.35);
        }

        .signup-input-container {
            display: flex;
            flex-direction: column;
            align-items: center; /* Центрирование по горизонтали */
            margin-top: 40px;
        }

        .signup label{
            padding-top: 5px;
            color: #1A5319;
            transform: scale(.6);
        }

        .signup .custom-button:hover{
            background: #ffffff;
        }

        #chk:checked ~ .signup{
            transform: translateY(-500px);
        }
        #chk:checked ~ .signup label{
            transform: scale(1);
        }
        #chk:checked ~ .login label{
            transform: scale(.6);
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
<script>
    // Функция для проверки, находится ли элемент внутри другого элемента
    function isClickOutside(element, target) {
        return !element.contains(target);
    }

    // Функция обработки клика по документу
    document.addEventListener('click', function(event) {
        const main = document.querySelector('.main');

        // Если клик произошел вне элемента .main
        if (isClickOutside(main, event.target)) {
            window.history.back(); // Возврат на предыдущую страницу
        }
    });
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
<div class="body-login">
<div class="main">

    <input type="checkbox" id="chk" aria-hidden="true">

    <div class="login">
        <form action="/login" method="post">
            <label for="chk" aria-hidden="true">Вход</label>
            <div class="input-container">
                <input type="email" id="username" name="username" placeholder="Email">
                <input type="password" id="password" name="password" placeholder="Пароль">
                <button class="custom-button">Войти</button>
            </div>
        </form>
    </div>

    <div class="signup">
        <form action="/registration" method="post">
            <label for="chk" aria-hidden="true" style="margin-bottom:0; padding-bottom:0">Регистрация</label>
            <div class="signup-input-container" style="margin-top:10px; padding-top:0">
                <input type="email" id="email" name="email" placeholder="Email" required>
                <input type="password" id="password" name="password" placeholder="Пароль" required>
                <input type="password" id="password2" name="password2" placeholder="Повтор пароля" required>
                <button class="custom-button">Зарегистрироваться</button>
            </div>
        </form>
    </div>
</div>
</div>
</body>
</html>