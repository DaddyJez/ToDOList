# ToDOList
Test case on Swift
This is a simple ToDoList application developed as part of my learning journey. The app allows users to create, edit, delete, and mark tasks as completed. It also includes a search feature to filter tasks by title or description.

Key Features

Task Management: Create, edit, delete, and mark tasks as completed.
Search: Filter tasks by title or description.
Data Persistence: Tasks are saved using CoreData, ensuring data persistence across app launches.
First Experience with Unit Testing: This project marks my first attempt at writing unit tests for an iOS application.
VIPER Architecture: The app is structured using the VIPER architecture, which separates the code into View, Interactor, Presenter, Entity, and Router components.
Technologies Used

Swift: The primary programming language used for development.
CoreData: For local data storage and persistence.
VIPER Architecture: To organize the codebase and separate concerns.
Unit Testing: XCTest framework for writing unit tests.
Project Structure

The project is organized into the following components:

View: Handles the UI and user interactions (TaskListViewController, EditTaskViewController).
Interactor: Contains the business logic (TaskInteractor).
Presenter: Acts as the middle layer between the View and Interactor (TaskPresenter).
Entity: Represents the data model (Task).
Router: Manages navigation between screens (TaskRouter).
Unit Testing

This project includes unit tests for the following components:

CoreDataManager: Tests for saving, updating, deleting, and fetching tasks.
DataManager: Tests for generating random descriptions and dates.
NetworkManager: Tests for fetching tasks from a remote API.
TaskInteractor: Tests for business logic, such as toggling task completion.
Task: Tests for the data model.
EditTaskViewController: Tests for the task editing logic.
This is my first experience with unit testing, and I aimed to ensure that the core functionality of the app is thoroughly tested.

How to Run the Project

Clone the repository:
bash
Copy
git clone https://github.com/your-username/ToDoList.git
Open the project in Xcode.
Build and run the app on a simulator or a physical device.
Future Improvements

Add more unit tests to cover edge cases.
Implement UI tests using XCTest.
Enhance the user interface with animations and better design.
Add support for task categories and priorities.

Русская Версия

Приложение ToDoList
Это простое приложение ToDoList, разработанное в рамках моего обучения. Приложение позволяет пользователям создавать, редактировать, удалять и отмечать задачи как выполненные. Также в приложении реализована функция поиска для фильтрации задач по названию или описанию.

Основные функции

Управление задачами: Создание, редактирование, удаление и отметка задач как выполненных.
Поиск: Фильтрация задач по названию или описанию.
Сохранение данных: Задачи сохраняются с использованием CoreData, что обеспечивает сохранность данных между запусками приложения.
Первый опыт написания юнит-тестов: Этот проект стал моей первой попыткой написания юнит-тестов для iOS-приложения.
Архитектура VIPER: Приложение структурировано с использованием архитектуры VIPER, которая разделяет код на компоненты View, Interactor, Presenter, Entity и Router.
Используемые технологии

Swift: Основной язык программирования, используемый для разработки.
CoreData: Для локального хранения данных и их сохранения.
Архитектура VIPER: Для организации кодовой базы и разделения ответственности.
Юнит-тестирование: Фреймворк XCTest для написания юнит-тестов.
Структура проекта

Проект организован в следующие компоненты:

View: Отвечает за пользовательский интерфейс и взаимодействие с пользователем (TaskListViewController, EditTaskViewController).
Interactor: Содержит бизнес-логику (TaskInteractor).
Presenter: Выступает в роли промежуточного слоя между View и Interactor (TaskPresenter).
Entity: Представляет модель данных (Task).
Router: Управляет навигацией между экранами (TaskRouter).
Юнит-тестирование

В проект включены юнит-тесты для следующих компонентов:

CoreDataManager: Тесты для сохранения, обновления, удаления и получения задач.
DataManager: Тесты для генерации случайных описаний и дат.
NetworkManager: Тесты для загрузки задач с удаленного API.
TaskInteractor: Тесты для бизнес-логики, например, изменения статуса задачи.
Task: Тесты для модели данных.
EditTaskViewController: Тесты для логики редактирования задач.
Это мой первый опыт написания юнит-тестов, и я стремился обеспечить тщательное тестирование основной функциональности приложения.

Как запустить проект

Клонируйте репозиторий:
bash
Copy
git clone https://github.com/your-username/ToDoList.git
Откройте проект в Xcode.
Соберите и запустите приложение на симуляторе или физическом устройстве.
Планы по улучшению

Добавить больше юнит-тестов для покрытия крайних случаев.
Реализовать UI-тесты с использованием XCTest.
Улучшить пользовательский интерфейс с помощью анимаций и более продуманного дизайна.
Добавить поддержку категорий и приоритетов задач.
