String? validateInput(String value, String fieldType) {
  // Boş değer kontrolü
  if (value.isEmpty) {
    return 'Boş Bırakılamaz!';
  }

  switch (fieldType.toLowerCase()) {
    case 'namesurname':
      String pattern = r"^[a-zA-ZÇĞİıÖŞÜçğöşü\s'-]+$";
      RegExp regex = RegExp(pattern);
      if (value.isEmpty || value == "") {
        return "Boş Bırakılamaz.";
      } else if (!regex.hasMatch(value)) {
        return 'Geçerli bir ad soyad giriniz.';
      } else if (!value.contains(" ")) {
        return 'Ad ve soyadınızın arasına boşluk koyunuz.';
      }
    case 'email':
      final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
      if (!emailRegex.hasMatch(value)) {
        return 'Geçerli bir mail adresi giriniz.';
      }
      break;

    case 'password':
      if (value.length < 6) {
        return "Şifreniz en az 6 karakterli olmalı.";
      } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
        return 'Şifre en az bir büyük harf içermelidir.';
      } else if (!RegExp(r'[a-z]').hasMatch(value)) {
        return 'Şifre en az bir küçük harf içermelidir.';
      } else if (!RegExp(r'[0-9]').hasMatch(value)) {
        return 'Şifre en az bir sayı içermelidir.';
      }
      break;

    case 'phone':
      final phoneRegex = RegExp(r'^5\d{9}$');
      if (!phoneRegex.hasMatch(value)) {
        return 'Geçerli bir Telefon Numarası Giriniz.';
      }
      break;

    default:
      return null;
  }

  return null;
}
