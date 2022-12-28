import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyInfoProvider extends ChangeNotifier {
  String text3 =
      "Biz hamkorlikdagi infratuzilmani yaratish, mintaqaviy va milliy xo'jalik siyosatini o'zgartirishga safarbar qilish, resurslardan (yer, grantlar va kreditlar, tanlovlar va boshqalar) foydalanish imkoniyatlarini oshirish, gender tengligini ta'minlash, ma'lumotlarni birlashtirish va barcha yosh fermerlar baham ko'rishi, o'rganishi va to'planishi mumkin bo'lgan qulayliklarni yaratgan holda birgalikda ishlaymiz.";
  String text2 =
      "Biz yosh fermerlarva fermerlikka qiziqqan yoshlarni qishloq xo'jaligida faoliyatini boshlash va muvaffaqiyatli davom ettirishi yo'lida qulay sharoit va imkoniyatlarni yaratamiz va ularni qo'llab-quvvatlaymiz, ularning ehtiyojlari va talablarini yaxshiroq o'rganish hamda qondirish va himoya qilish uchun intilamiz.";
  String text1 =
      "Biz barcha yosh fermerlar faoliyatini samarali yuritishi imkoniyatini ta'minlash uchun yorqin kelajak barpo etamiz, nomaqbul holatni o'zgartiramiz, tarmoqlarni yaratamiz va biznes xizmatlarini shakllantiramiz.";
  String text =
      "O'zbekiston yosh fermerlari Kengashi Nodavlat va notijorat tashkiloti o‘z oldiga fermerlik faoliyatini keng targ‘ib qilish va rivojlantirish, yoshlar, ayniqsa, uyushmagan yoshlarni fermerlik harakatiga keng jalb etish, yosh fermerlarni ko‘p tarmoqli fermer xo‘jaliklariga aylantirishda ko‘maklashish, shuningdek, yosh fermerlar faoliyatida duch kelinayotgan muammolar va masalalarni birgalikda hal etish, xorijiy ilg‘or tajribalarni o‘rganib, yosh fermerlar faoliyatiga joriy qilishda amaliy yordamlar ko‘rsatishni maqsad qilgan.";

  void launchURL(url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}
