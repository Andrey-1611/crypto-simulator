import '../../data/models/app_user.dart';

abstract class Validator {
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Введите имя';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Введите email';
    }
    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
      return 'Неверный формат email';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите пароль';
    }
    if (value.length < 6) {
      return 'Пароль должен быть минимум 6 символов';
    }
    return null;
  }
}

typedef UsersWithCurrentUserId = ({
  List<({AppUser user, double fullBalance})> users,
  String currentUserId,
});
