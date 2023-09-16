
class SliderModel {
  final int id ;
  final String titleArabic;
  final String titleEnglish;
  final String textArabic;
  final String textEnglish;
  final String image;

  SliderModel(
      {
        required this.id,
        required this.titleEnglish,
        required this.image,
        required this.textArabic,
        required this.titleArabic,
        required this.textEnglish
      }
      );
  factory SliderModel.fromJson( Map<String ,dynamic> json) {
    return SliderModel(id: json["id"],
        titleArabic: json["title"],
        titleEnglish: json["title_en"],
        textArabic: json["text"],
        textEnglish: json["text_en"],
      image: json["image"]
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