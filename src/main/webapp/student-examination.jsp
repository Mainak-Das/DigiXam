<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- ===== CSS ===== -->
        <link rel="stylesheet" href="Assets/css/styles.css">
    
        <!-- ===== BOX ICONS ===== -->
        <link href='https://cdn.jsdelivr.net/npm/boxicons@2.0.5/css/boxicons.min.css' rel='stylesheet'>

        <title>Sign In</title>
    </head>
    <body>
        <div class="login">
            <div class="login__content">
                <div class="login__img">
                    <img src="Assets/img/img-login.png" alt="">
                </div>

                <div class="login__forms">
                    <form action="LoginController" method="post" class="login__registre" id="login-in">
                        <h1 class="login__title">Sign In</h1>
    
                        <div class="login__box">
                            <i class='bx bx-user login__icon'></i>
                            <input type="text" name="usernameOrEmail" placeholder="Username or Email" style="color: #000000;" class="login__input">
                        </div>
    
                        <div class="login__box">
                            <i class='bx bx-lock-alt login__icon'></i>
                            <input type="password" name="password" placeholder="Password" style="color: #000000;" class="login__input">
                        </div>

                        <a href="#" class="login__forgot">Forgot password?</a>

                        <button type="submit" class="login__button">Sign In</button>
                    </form>
                </div>
            </div>
        </div>

        <!--===== MAIN JS =====-->
        <script src="Assets/js/main.js"></script>
    </body>
</html>