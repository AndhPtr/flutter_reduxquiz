import 'state.dart' ;
import 'action.dart';

QuizState quizReducer(QuizState state, dynamic action) {
  if (action is AnswerQuestionAction) {
    bool isCorrect = action.isCorrect == state.questions[state.currentQuestionIndex]['answer'];
    return state.copyWith(
      correctAnswers: isCorrect ? state.correctAnswers + 1 : state.correctAnswers,
      currentQuestionIndex: state.currentQuestionIndex + 1,
    );
  } else if (action is ResetQuizAction) {
    return QuizState(
      questions: state.questions,
    );
  }
  return state;
}