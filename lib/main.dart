import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

// Import file Redux yang sudah dibuat sebelumnya
import 'state.dart'; // Sesuaikan dengan nama file
import 'action.dart';
import 'store.dart'; // Sesuaikan dengan file Redux

void main() {
  runApp(FigmaToCodeApp());
}

class FigmaToCodeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<QuizState>(
      store: store,
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        home: Scaffold(
          body: ListView(children: [
            QuizPage(),
          ]),
        ),
      ),
    );
  }
}

class QuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 390,
          height: 844,
          padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 191),
          decoration: BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Quizederhana',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 38),
              StoreConnector<QuizState, QuizState>(
                converter: (store) => store.state,
                builder: (context, state) {
                  if (state.currentQuestionIndex < state.questions.length) {
                    final question =
                        state.questions[state.currentQuestionIndex];
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Pertanyaan ${state.currentQuestionIndex + 1}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: 332,
                          height: 117,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28, vertical: 31),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1, color: Color(0xFF2C2C2C)),
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              question['question'],
                              style: TextStyle(
                                color: Color(0xFF1E1E1E),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 38),
                        Text(
                          'Pilih jawaban anda!',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                StoreProvider.of<QuizState>(context)
                                    .dispatch(AnswerQuestionAction(true));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF4287FF),
                              ),
                              child: Text('Benar', style: TextStyle(
                                color: Colors.white
                              ),),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: () {
                                StoreProvider.of<QuizState>(context)
                                    .dispatch(AnswerQuestionAction(false));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFF04646),
                              ),
                              child: Text('Salah', style: TextStyle(
                                color: Colors.white
                              ),),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    // Menampilkan hasil akhir setelah semua soal dijawab
                    final score =
                        (state.correctAnswers / state.questions.length) * 100;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Quiz Selesai!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Nilai anda: ${score.toInt()}',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            StoreProvider.of<QuizState>(context)
                                .dispatch(ResetQuizAction());
                          },
                          child: Text('Ulangi Quiz'),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
