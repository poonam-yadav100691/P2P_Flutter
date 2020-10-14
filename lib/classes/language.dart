class Language {
  final int id;
  final String name;
  final String flag;

  final String languageCode;

  Language(this.id, this.name, this.flag, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language(1, 'English', 'assets/images/usa2.png', 'en'),
      Language(2, 'Lao', 'assets/images/lao3.jpg', 'lo'),
    ];
  }
}
