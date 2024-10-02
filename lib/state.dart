class QuizState {
  final List<Map<String, dynamic>> questions;
  final int correctAnswers;
  final int currentQuestionIndex;

  QuizState({
    required this.questions,
    this.correctAnswers = 0,
    this.currentQuestionIndex = 0,
  });

  QuizState copyWith({
    int? correctAnswers,
    int? currentQuestionIndex,
  }) {
    return QuizState(
      questions: this.questions,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
    );
  }
}