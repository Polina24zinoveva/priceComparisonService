<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@500&display=swap" rel="stylesheet">
    <link rel="icon" href="diploma_icon.png" type="image/x-icon">

    <style>
        body{
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .main{
            width: 550px;
            height: 600px;
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
            margin-top: 80px;
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
            padding-top: 20px;
            color: #1A5319;
            transform: scale(.6);
        }
        .signup .custom-button:hover{
            background: #ffffff;
        }

        #chk:checked ~ .signup{
            transform: translateY(-580px);
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
            <label for="chk" aria-hidden="true">Регистрация</label>
            <div class="signup-input-container">
                <input type="email" id="email" name="email" placeholder="Email" required>
                <input type="password" id="password" name="password" placeholder="Пароль" required>
                <button class="custom-button">Зарегистрироваться</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>