
main() async {
  final List<Question> _questionBank = [
    Question('You can lead a cow down stairs but not up stairs?', false),
    Question('Approximately one quarter of human bones are in the feet?', true),
    Question('A slug\'s blood is green?', true),
  ];
  
  String a = _questionBank[1].questionText;
  var b = _questionBank[1].answerBool;
  print(a); //keluar text
  print(b); //keluar boolean
}

class Question {
  String questionText;
  bool answerBool;

  Question(this.questionText, this.answerBool);
}
