# Snack Ads

<img height="250" src="https://github.com/snackads/SnackAds/assets/61077215/78b246f9-5391-4edb-9013-984ebed6e316"></img>


> **_Shortform ads like snacks 🍟 🍿, Snack Ads_** <br/><br/>
> **Development Period: 2024.05.02 ~ 2024.06.06**

<br/>

## ⭐️ Project Introduction

You can easily upload a short video (no more than 1 minute) about your favorite restaurant at any time!

Funny short form ads can be liked and shared with your friends!

It's a fun and easy to use short form ad app! 🍟🍿

<br/>

## 📢 🥨 Team SnackAds 🥨 📢

|               PM 김신후                |              UXUI 정재민               |                DEV 김현기                |                      DEV 권세한                      |                DEV 김형진                |
| :------------------------------------: | :------------------------------------: | :--------------------------------------: | :--------------------------------------------------: | :--------------------------------------: |
| [@KSH-KOR](https://github.com/KSH-KOR) | [@woals00](https://github.com/woals00) | [@hgkim215](https://github.com/hgkim215) | [@sehan2709-cmis](https://github.com/sehan2709-cmis) | [@markFT39](https://github.com/markFT39) |

<br/>

## ⚙️ Development Environments

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)

![Firebase](https://img.shields.io/badge/firebase-a08021?style=for-the-badge&logo=firebase&logoColor=ffcd34)
![Figma](https://img.shields.io/badge/figma-%23F24E1E.svg?style=for-the-badge&logo=figma&logoColor=white)
![Visual Studio Code](https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white)

<br/>

## 🌟 Project Key Features

> 🔑 You can sign up and log in via Google Sign-in and email!

<img src="https://user-images.githubusercontent.com/41044154/144353747-ba7d89bc-9385-4e12-ad01-26b10748d32d.png" width=30%><img src="https://user-images.githubusercontent.com/41044154/144353744-529629b3-ba00-4ac8-bc71-cf24adfcd17e.png" width=30%>
<img src="https://user-images.githubusercontent.com/41044154/144353735-ed74ea31-55f7-4ee9-9f77-c24d782e42f2.png" width=30%>

> 1️⃣ Shoot a simple shortform ad in under a minute!

![Capture+_2024-06-06-13-37-22](https://github.com/snackads/SnackAds/assets/64348852/87400302-c3a8-4d7c-acc5-452ddd958667)
<img src="https://user-images.githubusercontent.com/41044154/144346988-2959fe08-ed02-4fd6-963e-276cb143a437.png" width=30%><img src="https://user-images.githubusercontent.com/41044154/144346986-24cb4376-ad4e-4968-9889-3b47c1e38fb6.png" width=30%>

> 📍 Check out the map to see what restaurants are near you!

<img src="https://user-images.githubusercontent.com/41044154/144347899-bab1eae0-a873-456e-9867-f2648195e5e2.png" width=30%><img src="https://user-images.githubusercontent.com/41044154/144347883-2a3b6a40-7625-45b5-9bf6-626d31c37aa7.png" width=30%>

> 👍 If there's a restaurant you want to try, give it a thumbs up!

<img src="https://user-images.githubusercontent.com/41044154/144348144-b5065261-6f42-479d-a067-b2ae5273e122.png" width=23%><img src="https://user-images.githubusercontent.com/41044154/144348142-93849c54-6630-4377-b27a-259d70334aba.png" width=23%>
<img src="https://user-images.githubusercontent.com/41044154/144348136-237c5318-d98e-48e5-8efc-434afeb0c037.png" width=23%><img src="https://user-images.githubusercontent.com/41044154/144348126-31ce1ad8-4ba2-496b-b791-e0dab4604de3.png" width=23%>

> 🤝 If you have a favorite restaurant you'd like to try with your friends, share it!

<img src="https://user-images.githubusercontent.com/41044154/144348644-8154ec56-b467-40f4-af09-46196c67f4d9.png" width=30%><img src="https://user-images.githubusercontent.com/41044154/144348635-e3cc48b8-00a9-4a61-ab61-0e63d97eff57.png" width=30%>

> 👤 You can see the videos you've uploaded and the videos you've liked on Profile!

<img src="https://user-images.githubusercontent.com/41044154/144354057-7ed5c855-f2c4-4916-954e-2ba72fd12aae.png" width=30%><img src="https://user-images.githubusercontent.com/41044154/144354040-71b94fce-d2b1-49b8-ae62-208b4c13f277.png" width=30%>
<img src="https://user-images.githubusercontent.com/41044154/144354050-3ddd21b3-bfef-4c20-98ab-3050d60c7719.png" width=30%>

<br/>

## ⚒ Architecture

### ⏺ MVC Architecture/Design Pattern

<img width="994" alt="2024-06-06_05-12-06" src="https://github.com/snackads/SnackAds/assets/61077215/fe7c8d02-4e0d-4b09-a825-9ee0bdeb54e3">

> **MVC Pattern Description**

- SnackAds is developed using the MVC architecture. This architecture divides the application into three components - Model, View, and Controller - to enable efficient development and maintenance.

- Model manages the shortform (ad video) and user data. The shortform data model includes the shortform's title, description, URL, and number of likes, while the user data model includes the user's profile and the shortforms they have liked. Firebase is responsible for storing and retrieving this data in the database.

- View manages the user interface. The Home screen displays a list of Short Form ads, and the Play Ads screen plays the current turn of ads. The User Profile screen displays the user's information, and the Map screen displays the location of the store currently listed in the app.

<br/>

## 🔥 Managing Tasks within our Development Team

### ⏺ Weekly Scrum

- Last week's work retrospective: Each team member gives a brief description of the work they completed in the past week. This is an opportunity to see how the project is progressing and share the results of the work completed.

- This week's work plan: Each team member shares a list of tasks they'll be focusing on this week. This helps team members understand each other's work and plan for collaboration if needed.

- Share obstacles and find solutions: Team members share any problems or obstacles they've encountered in their work, and work together to find solutions. This is essential for the smooth progress of the project.

### ⏺ Write Backlog

- Gather requirements: Identify the goals and needs of the project. This can be done through customer needs, market research, internal goals, etc.

- Define work items: Based on the requirements gathered, define specific work items. Each item should be small enough that one person or a small team can complete it within one sprint.

- Set priorities: Determine the priority of the work items. This is done by considering the project's goals, customer needs, technical difficulty, etc.

- Organize and update the backlog: Review the backlog regularly as the project progresses and add, modify, or delete items as needed.

### ⏺ Totally Agile

- Iterative and incremental development: Break your project into smaller steps, each of which produces a viable product. This allows for continuous improvement and adaptation.

- Openness to change: Recognize that goals and requirements may change during the course of a project, and have the flexibility to respond.

- Close collaboration among team members: Emphasize communication and cooperation, and clarify the roles and responsibilities of each team member so they can support each other and work toward a common goal.

<br/>

## 🧑‍💻 How to Collaborate by Using Git

- First, we created a Snack Ads Organization and invited everyone on the team to join it.

- Under that organization, we created a Snack Ads flutter project, and each developer forked that project and worked in their own repository. We found that this approach significantly reduced the number of conflicts that arose during collaboration.

- When sending pull requests, we made sure that the other developer reviewed the code and went through a code review process, rather than just merging it themselves. This ensured that the developers were constantly sharing each other's code as they developed.
