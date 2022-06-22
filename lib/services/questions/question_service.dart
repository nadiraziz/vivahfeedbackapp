import 'package:vivah/services/questions/models/question.dart';

class QuestionService {
  int _questionNumber = 0;

  // list of the question
  List<Question> questions = [
    Question(
      questionText: 'Rate about our Collection',
      notRate: false,
      questionOption: [],
    ),
    Question(
      questionText: 'Which is your favourite Collection?',
      notRate: true,
      questionOption: [
        'Antique',
        'Handicraft',
        'Signity',
        'Apoorva',
        'Turkish'
      ],
    ),
    Question(
      questionText: 'Are your satisfied with pricing?',
      notRate: true,
      questionOption: ['Satisfied', 'Not Satisfied'],
    ),
    Question(
      questionText: 'Rate about our staff appearance',
      notRate: false,
      questionOption: [],
    ),
    Question(
      questionText: 'Overall rating',
      notRate: false,
      questionOption: [],
    ),
  ];

  bool notRate() {
    return questions[_questionNumber].notRate;
  }

  List optionList() {
    return questions[_questionNumber].questionOption;
  }

  // question to be reset
  void reset() {
    _questionNumber = 0;
  }
}
