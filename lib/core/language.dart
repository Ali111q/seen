import 'package:get/get.dart';

class Language extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'en_Us': {
          'error': "Error",
          'login': 'Login',
          'register': 'Register',
          'email': 'Email',
          'password': 'Password',
          'login_with': 'Login With',
          'forget_password': 'Forget Password?',
          'no_account': 'No Account?',
          'name': 'Name',
          'logout': 'Logout',
          'profile': 'Profile',
          'register_with': 'Register With',
          'contact_us': 'Contact Us',
          'have_account': 'Have Account?',
          'select_image': 'Select Image',
          'comment': 'Comment',
          'delete_account': 'Delete Account',
        },
        'ar_IQ': {
          'error': 'خطأ',
          'login': 'تسجيل الدخول',
          'register': 'تسجيل',
          'email': 'البريد الالكتروني',
          'password': 'كلمة المرور',
          'login_with': 'تسجيل الدخول بواسطة',
          'forget_password': 'نسيت رمز المرور؟',
          'no_account': 'ليس لديك حساب؟',
          'name': 'الاسم',
          'logout': 'تسجيل خروج',
          'profile': 'الحساب الشخصي',
          'contact_us': 'اتصل بنا',
          'register_with': 'تسجيل بواسطة',
          'have_account': 'تمتلك حساب؟',
          'select_image': 'اختيار صورة',
          'comment': 'تعليق',
          'delete_account': 'حذف الحساب',
        },
      };
}
