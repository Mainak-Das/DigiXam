# **DigiXam**
![DigiXam-repository-cover2](https://user-images.githubusercontent.com/93379681/208264704-ec2720f9-010b-4b73-9a92-dcf48038b289.png)


# DigiXam - An Online Examination System

DigiXam is a modern web-based platform designed for online exams. It allows educational institutions to conduct exams online, simplifying the process of exam creation, management, and evaluation. Built with a combination of front-end technologies (HTML, CSS, JavaScript, Bootstrap) and a robust Java backend integrated with MySQL for database management, DigiXam provides an easy-to-use and responsive system for both administrators and students.

## Features
- User registration and login system
- Exam creation and management for administrators
- Secure online examination for students
- Responsive design for mobile, tablet, and desktop users
- Real-time result evaluation and feedback
- Backend integration with MySQL for data storage

## Project Structure

```
DigiXam/
│
├── backend/
│   ├── com/
│   │   └── IMAP/
│   │       ├── ExamManagement.java
│   │       ├── UserManagement.java
│   │       └── DatabaseConnection.java
│   ├── pom.xml
│
├── src/
│   ├── main/
│   │   └── webapp/
│   │       ├── index.html
│   │       ├── css/
│   │       │   └── style.css
│   │       ├── js/
│   │       │   ├── script.js
│   │       │   └── validate.js
│   │       ├── images/
│   │       └── fonts/
│
├── .gitignore
├── .settings/
├── .classpath
├── .project
└── README.md
```

### Folder Descriptions

#### `backend/`
This folder contains the core backend logic of the DigiXam platform. It handles the functionalities like user authentication, exam creation, management, and database interactions.

- **com/IMAP/**: This package includes Java classes for different functionalities.
    - **ExamManagement.java**: Manages the creation, modification, and scheduling of exams. It also handles fetching exam results and related data.
    - **UserManagement.java**: Handles user registration, login, password management, and session management.
    - **DatabaseConnection.java**: Establishes a connection with the MySQL database and handles queries related to user data, exam data, and results.
- **pom.xml**: The Maven configuration file for the backend Java project. It includes dependencies for the project, such as MySQL connectors and other Java libraries.

#### `src/main/webapp/`
This folder contains all the front-end files, including HTML, CSS, and JavaScript that define the user interface and interaction.

- **index.html**: The homepage of the DigiXam platform. This is where users can register, log in, and access the exam interface.
- **css/style.css**: Custom CSS file for styling the front-end. It defines the look and feel of the platform, including layouts, buttons, forms, and responsiveness.
- **js/script.js**: The main JavaScript file that controls the user interaction with the platform. It includes scripts for handling form submissions, validating user input, and interacting with the backend.
- **js/validate.js**: Contains JavaScript functions for client-side form validation to ensure users submit correct and valid data (e.g., email, password, etc.).
- **images/**: Contains images used throughout the platform (e.g., logos, icons, etc.).
- **fonts/**: Holds font files used across the platform to ensure a consistent visual style.

### Root Files

- **.gitignore**: Specifies files and folders that should not be tracked by Git. Typically includes IDE configuration files, build directories, and temporary files.
- **.settings/**, **.classpath**, **.project**: These are IDE configuration files for Java projects in Eclipse or similar IDEs.
- **README.md**: This file, providing an overview of the DigiXam project.
  
## How to Set Up and Use

### Prerequisites

1. **Java 8 or higher**: Make sure Java is installed on your machine.
2. **MySQL**: You will need a MySQL server running. Set up the database and tables as per the project requirements.
3. **Maven**: For building and managing dependencies.

### Steps to Run Locally

1. **Clone the repository**:
    ```bash
    git clone https://github.com/Mainak-Das/DigiXam.git
    cd DigiXam
    ```

2. **Backend Setup**:
    - Ensure you have MySQL installed and running.
    - Configure the database connection details in **DatabaseConnection.java**.
    - Build the backend using Maven:
      ```bash
      mvn clean install
      ```

3. **Frontend Setup**:
    - Open the `src/main/webapp/index.html` file in your browser to access the platform’s homepage.

4. **Running the Application**:
    - Start the backend server (e.g., using a servlet container like Tomcat).
    - Access the platform through the browser at `http://localhost:8080` or the relevant port.

## License

This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.


<p align="center"><strong>© Mainak Das | All rights reserved.</strong></p>
