class StringManager {
  static double screenHeight = 844;
  static double screenWidth = 390;
  static const String onboarding1 = "Consult Specialist Doctors\n"
      " Securely & Private\n";
  static const String onBoarding2 =
      "\tCancer Care First Steps with Highlights \n"
      "\t\tThe app’s Role in Providing Care&Support \n"
      "\t\t\t\tFor Skin Cancer prevention.\n";
  static const String getStarted = "Get Started";
  static const String welcomeMessage = "Welcome to our app!";
  static const String choseUser = '\tSelect\n'
      'You will log in as';
  static const String patient = "Patient";
  static const String doctor = "Doctor";
  static const String signIn = "Sign In";
  static const String signUp = "Sing Up";
  static const String authfuntext = "Let’s go to enjoy the features we’ve\n"
      "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tprovided for you!";
  static const String ortext = "Or";
  static const String donetHaveAccount = "Don’t have an account? ";
  static const String doneDaliog = "Yup ! Welcome Back";
  static const String forgetPassword = "Forget your password ?";
  static const String forgetPasssword2 =
      "Please enter your Email or your phone\n"
      "number, we will send you confirmation code.";
  static const String sendCode = "Send code";
  static const String checkemail = "Please check your email";
  static const String testmail = "We’ve sent a code to ****@gmail.com";
  static const String verify = "Verify";
  static const String restPassword = "Reset password";
  static const String restpassword2 = "please type password you’ll  remember";
  static const String haveAccount = "Already have an account";
  static const String youShouldSignIn = "You Should SignIn again";
  static const String addClinic = "Add Clinic";
  static const String finddoctortext = "Discuss your skin \n"
      "concerns with a trusted \n"
      "skin specialist";
  static const String testAI = "Test Your skin lesion \n"
      "with AI";
  static const String textAI2 = "Get a first look with our\n"
      "machine Learning"
      "model";
  static const String whatskin = "What is Skin Caner?";
  static const String whatskin2 = "All you need to know about\n"
      "the basics of skin cancer";
  static const String paymobApiKey =
      "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2T0RneE9UazVMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuMTVYRjdYd0ItUElrQWZkUkZOX1FvSTZCZmJLZVBDaHpaUWI5R3pXbG1TaUxXUzRIVlhfbFVSMGlMcGIwUHA3bG1xejB3NWxIUFBwNFE5cDh4a0U0anc=";
  //payment constent
  //https://accept.paymob.com/api/auth/tokens
  static const String visaImage =
      "https://cdn-icons-png.flaticon.com/128/349/349221.png";
  static const String refCodeImage =
      "https://cdn-icons-png.flaticon.com/128/4090/4090458.png";
  static const String baseApiPayment = "https://accept.paymob.com/api";
  static const String getAuthToken = "/auth/tokens";
  static const String paymentAPIkey =
      'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2T1RZd05ESTRMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuemNhOUMwd0dMaWVud211dXZrcDhrbW4yc2dPaFZ3VWVOVkVFMzJ0TjFtUUNaQUtma29TRi1kaHlVZUUxVk91TDNiVnhVaWJkWk1GSzZEYUMxNjVTZGc=';
  static const String getOrderId = "/ecommerce/orders";
  static const String paymentKeyRequeset = "/acceptance/payment_keys";
  static const String getRefCode = "/acceptance/payments/pay";
  static String paymentFirstToken = "";
  static String paymentOrderId = "";
  static String paymentIntegrationCardId = "4487449";
  static String paymentIntegrationKisokId = "4487460";
  static String finalToken = " ";
  static String refCode = "";
  static String visaUrl =
      'https://accept.paymob.com/api/acceptance/iframes/782498?payment_token=ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SjFjMlZ5WDJsa0lqb3hOVFUwTmpBd0xDSmhiVzkxYm5SZlkyVnVkSE1pT2pFd01Dd2lZM1Z5Y21WdVkza2lPaUpGUjFBaUxDSnBiblJsWjNKaGRHbHZibDlwWkNJNk5ERXhOVFV6TWl3aWIzSmtaWEpmYVdRaU9qRTBOalEwTlRjeE9Td2lZbWxzYkdsdVoxOWtZWFJoSWpwN0ltWnBjbk4wWDI1aGJXVWlPaUpEYkdsbVptOXlaQ0lzSW14aGMzUmZibUZ0WlNJNklrNXBZMjlzWVhNaUxDSnpkSEpsWlhRaU9pSkZkR2hoYmlCTVlXNWtJaXdpWW5WcGJHUnBibWNpT2lJNE1ESTRJaXdpWm14dmIzSWlPaUkwTWlJc0ltRndZWEowYldWdWRDSTZJamd3TXlJc0ltTnBkSGtpT2lKS1lYTnJiMnh6YTJsaWRYSm5hQ0lzSW5OMFlYUmxJam9pVlhSaGFDSXNJbU52ZFc1MGNua2lPaUpEVWlJc0ltVnRZV2xzSWpvaVkyeGhkV1JsZEhSbE1EbEFaWGhoTG1OdmJTSXNJbkJvYjI1bFgyNTFiV0psY2lJNklpczROaWc0S1RreE16VXlNVEEwT0RjaUxDSndiM04wWVd4ZlkyOWtaU0k2SWpBeE9EazRJaXdpWlhoMGNtRmZaR1Z6WTNKcGNIUnBiMjRpT2lKT1FTSjlMQ0pzYjJOclgyOXlaR1Z5WDNkb1pXNWZjR0ZwWkNJNlptRnNjMlVzSW1WNGRISmhJanA3ZlN3aWMybHVaMnhsWDNCaGVXMWxiblJmWVhSMFpXMXdkQ0k2Wm1Gc2MyVXNJbVY0Y0NJNk1UWTVNekl4TmpFNU15d2ljRzFyWDJsd0lqb2lNVFUwTGpFNE1pNDJPUzR5TlRJaWZRLmhuUXVhUF9wNkx6NDktZ0NhZVlTdkdpeWtnd1M4eTBUZDJIWUx4THhudi1keTlkQy0tQ1lqenZVOGhoMXFEblNlbEJFTl9xZXUtRURBQTd0NDNsRjdR';
  static String visaUrl2 =
      '$baseApiPayment/acceptance/iframes/782498?payment_token=$finalToken';
  static String visaurl3 =
      "https://accept.paymob.com/api/acceptance/iframes/825680?payment_token=$finalToken";
}
