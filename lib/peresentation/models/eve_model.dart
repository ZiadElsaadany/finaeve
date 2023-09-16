
class EveModel {


  final String titleArabic ;
  final String titleEnglish ;
  final String textArabic;
  final String textEnglish;
  final String image;

  EveModel(
      {

        required this.titleArabic,
        required this.image,
        required this.titleEnglish,
        required this.textArabic,
        required this.textEnglish
      }
      );
  factory EveModel.fromJson( Map<String ,dynamic> json) {
    return EveModel(
      titleArabic: json["title"],

titleEnglish: json["title_en"],
        image: json["image"],
        textArabic: json["text"],
        textEnglish: json["text_en"]
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