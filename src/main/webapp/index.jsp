<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<jsp:include page="header.jsp"></jsp:include>

<jsp:forward page="login"></jsp:forward>
<link rel="stylesheet" href="Assets/css/land.css">
<link rel="scss" href="Assets/css/button.sass">
<script src="https://kit.fontawesome.com/a81368914c.js"></script>
<script src="Assets/js/app.js"></script>
    <main>
      <div class="big-wrapper light">
        <img src="Assets/img/shape.png" alt="" class="shape" />

        <header>
          <div class="container">
            <div class="logo">
              <img src="Assets/img/brand_logo.png" alt="Logo" />
              <h3>DigiXam</h3>
            </div>

            <div class="links">
              <ul>
                <li><a href="#">Features</a></li>
                <li><a href="#">Pricing</a></li>
                <li><a href="#">About</a></li>
                <li><a href="#" class="btn">Sign in</a></li>
              </ul>
            </div>
            <div class="overlay"></div>

            <div class="hamburger-menu">
              <div class="bar"></div>
            </div>
          </div>
        </header>

        <div class="showcase-area">
          <div class="container">
            <div class="left">
              <div class="big-title">
                <h1>A better place to</h1>
                <h1>give your exams</h1>
              </div>
              <p class="text" width="50px">
              A new era of online examinations!
              </p>
              <div class="cta">
                <a href="#" class="btn">Get started</a> 
              </div>
            </div>

            <div class="right">
              <img src="Assets/img/illustration.png" alt="Illustration" class="illustration" />
            </div>
          </div>
        </div>

        <div class="bottom-area">
          <div class="container">
            <button class="toggle-btn">
              <i class="far fa-moon"></i>
              <i class="far fa-sun"></i>
            </button>
          </div>
        </div>
      </div>
    </main>

<jsp:include page="footer.jsp"></jsp:include>