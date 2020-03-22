class QuestionType {
  final int id;
  final String text;

  QuestionType(this.id, this.text);
}

final List<QuestionType> questiontypes = [
  QuestionType(1, "Frage mit \n4 unterschiedlichen Antwortmöglichkeiten "),
  QuestionType(2, "Frage mit \nRichtig und Falsch als Antwortmöglichkeiten "),
];
