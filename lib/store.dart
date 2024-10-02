import 'package:redux/redux.dart';
import 'state.dart';
import 'reducer.dart';

final Store<QuizState> store = Store<QuizState>(
  quizReducer,
  initialState: QuizState(
    questions: [
      {"question": "Apakah Flutter menggunakan bahasa Dart?", "answer": true},
      {"question": "Apakah Flutter framework untuk backend?", "answer": false},
      {"question": "Apakah YES berarti YA?", "answer": true},
    ],
  ),
);