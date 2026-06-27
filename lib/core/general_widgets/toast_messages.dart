import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastMessages {
  ToastificationItem showErrorToast(BuildContext context, String description) {
    return toastification.show(
      context: context,
      alignment: const Alignment(0, 0.8),
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(milliseconds: 3500),
      type: ToastificationType.error,
      closeButtonShowType: CloseButtonShowType.none,
      showProgressBar: false,
      title: const Text(
        "Hata!",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      description: Text(
        description,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  ToastificationItem showSuccessToast(BuildContext context, String description) {
    return toastification.show(
      context: context,
      alignment: const Alignment(0, 0.8),
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(milliseconds: 3500),
      type: ToastificationType.success,
      closeButtonShowType: CloseButtonShowType.none,
      showProgressBar: false,
      title: const Text(
        "Başarılı!",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      description: Text(
        description,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
