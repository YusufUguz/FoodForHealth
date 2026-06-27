class AiPrompts {
  static String isFoodGoodOrNotForUser(String ings, String diseases, String foodName) {
    if (diseases == "" || diseases == "[]") {
      return "İçerisinde $ings olan $foodName adlı ürün hastalığı olmayan biri için uygun mudur?Cevabın yalnızca Bu ürün sizi için uygundur. veya Bu ürün sizin için uygun değildir. şeklinde olsun.Uygunluk açısından çok katı davranma.";
    } else {
      return "İçerisinde $ings olan $foodName adlı ürün $diseases hastalıkları olan biri için uygun mudur?Cevabın yalnızca Bu ürün sizi için uygundur veya Bu ürün sizin için uygun değildir şeklinde olsun.";
    }
  }

  static String foodEvaluation(String ings, String diseases, String foodName) {
    if (diseases == "" || diseases == "[]") {
      return "İçerisinde $ings olan $foodName adlı ürünü hastalığı olmayan biri tüketebilir mi?Kişiyi sağlığı açısından bilgilendirecek çokta uzun olmayan bir metin yaz.";
    } else {
      return "İçerisinde $ings olan $foodName adlı ürün $diseases hastalıkları olan biri tüketebilir mi?Kişiyi sağlığı açısından bilgilendirecek çokta uzun olmayan bir metin yaz.";
    }
  }
}
