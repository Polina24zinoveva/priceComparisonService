<!DOCTYPE html>
<html>
<head>
    <title>Сервис для сравнения цен на товары</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@500&display=swap" rel="stylesheet">
    <link rel="icon" href="icon.png" type="image/x-icon">

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
            background-color: #e8a08c;
            background-image:
                radial-gradient(at 10% 15%, #58A5E6 15%, rgba(88, 165, 230, 0.1) 50%, transparent 70%), /* Голубой (уменьшен) */
                radial-gradient(at 85% 15%, #A46AB9 20%, rgba(164, 106, 185, 0.2) 50%, transparent 80%), /* Фиолетовый выше */
                radial-gradient(at 80% 50%, #E8A08C 25%, rgba(232, 160, 140, 0.2) 60%, transparent 80%), /* Оранжевый поднят выше */
                radial-gradient(at 15% 65%, hsla(331, 94%, 79%, 0.6) 0, hsla(331, 94%, 79%, 0) 50%),
                radial-gradient(at 52% 98%, hsla(55, 95%, 66%, 0.6) 0, hsla(55, 95%, 66%, 0) 50%);

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
            background: none;
            border: 2px solid white;
            box-shadow: 0 5px 15px rgba(255, 255, 255, 0.35);

            font-size: 18px;

            margin-top: 30px;
            outline: none;
            border-radius: 5px;
            transition: .2s ease-in;
            cursor: pointer;
        }

        .custom-button:hover{
            color: #FFFFFF;
            background: none;
            border: 2px solid white;
            box-shadow: 0 5px 15px rgba(255, 255, 255, 0.5);
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
            color: #E4AB8D;
            transform: scale(.6);
        }

        .signup .custom-button{
            background: #E4AB8D;
            border: 2px solid #E4AB8D;
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
            confirmButtonColor: '#676767'
        });
        uncheck();
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

    <#include "blocks/header.ftlh">

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
                <form action="/registration" method="post" id="registrationForm">
                    <label for="chk" aria-hidden="true" style="margin-bottom:0; padding-bottom:0">Регистрация</label>
                    <div class="signup-input-container" style="margin-top:10px; padding-top:0">
                        <input type="email" id="emailReg" name="email" placeholder="Email" autocomplete="off" required
                               minlength="5" maxlength="64">

                        <input type="password" id="password1" name="password" placeholder="Пароль" required
                               minlength="6" maxlength="20">

                        <input type="password" id="password2" name="password2" placeholder="Повтор пароля" required>
                        <button class="custom-button" onclick="validatePasswords()">Зарегистрироваться</button>
                    </div>
                </form>
                <script>
                    function validatePasswords() {
                        let email = document.getElementById("emailReg").value;
                        let password1 = document.getElementById("password1").value;
                        let password2 = document.getElementById("password2").value;

                        let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                        if (!emailPattern.test(email)) {
                            alert("Введите корректный email (например, example@domain.com)");
                            event.preventDefault();
                            return;
                        }

                        if (password1 !== password2) {
                            alert("Пароли не совпадают. Попробуйте еще раз");
                            event.preventDefault();
                        }
                    }
                </script>
            </div>
        </div>
    </div>
</body>
</html>