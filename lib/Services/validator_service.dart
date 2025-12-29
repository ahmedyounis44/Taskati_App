class ValidatorService{


 static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Email';
    }
    // A basic regex for email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid Email';
    }
    return null;
  }
 static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Password';
    }
    if (value.length<7) {
      return 'Please make the Password length at least 8 character';
    }
    return null;
  }
 static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your name';
    }
    final nameRegex = RegExp(r"^[a-zA-Z\s]+$");
    if (!nameRegex.hasMatch(value)) {
      return 'Name can only contain letters and spaces';
    }
    return null;
  }
 static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your phone number';
    }

    // This regex allows an optional '+' at the beginning followed by 7-15 digits.
    final phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');

    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }


static String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter title';
    }
    final nameRegex = RegExp(r"^[a-zA-Z\s]+$");
    if (!nameRegex.hasMatch(value)) {
      return 'Title can only contain letters and spaces';
    }
    return null;
  }


static String? validateDes(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter descrption';
    }
    final nameRegex = RegExp(r"^[a-zA-Z1-9\s]+$");
    if (!nameRegex.hasMatch(value)) {
      return 'Descrption can only contain letters,Numbers and spaces';
    }
    return null;
  }

}