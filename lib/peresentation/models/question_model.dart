class QuestionModel {


  final int id ;
  final String titleArabic;
  final String titleEnglish;
  final String contentArabic;
  final String contentEnglish;

  QuestionModel(
  {
    required this.id,
    required this.contentArabic,
    required this.contentEnglish,
    required this.titleArabic,
    required this.titleEnglish
}
      );
  factory QuestionModel.fromJson( Map<String ,dynamic> json) {
    return QuestionModel(id: json["id"],
        contentArabic: json["content"],
        contentEnglish: json["content_en"],
        titleArabic: json["title"],
        titleEnglish: json["title_en"]
    );
  }



}
/**{
    "status": 1,
    "data": [
    [
    {
    "id": 1,
    "title": "كيف اتابع حالة طلبي ؟",
    "title_en": "How do I track the status of my application?",
    "content": "<p>يمكن متابعتك حالة طلبك بتسجيل الدخول على حسابك وتصفح البوماتك ومتابعة حالتها او عن طريق&nbsp; الاستعلام عن حالة الطلب بادخال رقم الطلب ومعرف حالته</p>\r\n",
    "content_en": "<p>You can follow up on the status of your order by logging in to your account, browsing your albums and following up on their status, or by inquiring about the status of the order by entering the order number and its status identifier.</p>\r\n",
    "status": 1
    }
    ]
    ]
    }*/