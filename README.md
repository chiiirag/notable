# notable

## Setup

1. Clone https://github.com/chiiirag/notable.git to your respective tool (Android studio / VS Code).
2. Checkout to master branch
3. Run flutter clean
4. Run flutter pub get

- Now you all set to run application
- Run flutter run

## State Management

- Used a cubit as a state management for this project.
- Cubit is a state management library provided by the Bloc (Business Logic Component) package.
- Why: BLoC enforces a clear separation between business logic and UI. By isolating the business logic from the UI layer, you ensure that the UI    code only handles the presentation of data, while the BLoC handles state management and business rules.
- How: In BLoC, the business logic is encapsulated in BLoC classes, which are responsible for managing state and processing events. The UI 
  interacts with the BLoC through Streams and Sink, which keeps the UI code clean and focused on rendering views.
