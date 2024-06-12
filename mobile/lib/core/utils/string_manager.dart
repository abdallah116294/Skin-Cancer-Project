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
  static const String choseUser = 'Select your section';
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
  static const String alreadyHaveAccount = "Already have an account?";
  static const String userIdKey =
      "http://schemas.microsoft.com/ws/2008/06/identity/claims/primarysid";
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
  static const List<Map<String, String>> diseaes = [
    {
      "name": "Actinic Keratosis",
      "description":
          "Actinic keratosis is a rough, scaly patch on the skin that develops from years of exposure to the sun. It is also known as solar keratosis. These patches are often found on the face, lips, ears, back of the hands, forearms, scalp, or neck. They can be a precursor to skin cancer, making it important to monitor and treat them.",
      "symptoms":
          "Rough, dry or scaly patch of skin less than 1 inch in diameter; flat to slightly raised patch or bump on the top layer of skin; in some cases, a hard, wart-like surface; color variations from pink to red to brown; itching or burning in the affected area."
    },
    {
      "name": "Basal Cell Carcinoma",
      "description":
          "Basal cell carcinoma (BCC) is the most common form of skin cancer, arising from the basal cells in the skin's lowest layer. It often develops on areas of the skin that receive the most sun exposure, such as the face, ears, neck, scalp, shoulders, and back. BCC grows slowly and rarely metastasizes (spreads) to other parts of the body but can cause significant local damage if not treated.",
      "symptoms":
          "Raised, smooth, pearly bump on sun-exposed skin; small blood vessels may be visible within the tumor; a sore that heals and then reopens; a reddish patch or irritated area; a shiny bump or nodule that is pearly or translucent and is often pink, red, or white; a white, yellow, or waxy scar-like area."
    },
    {
      "name": "Dermatofibroma",
      "description":
          "Dermatofibroma is a common benign fibrous nodule that most often appears on the skin of the lower legs. They are typically harmless and can develop from a minor injury, such as a bug bite or a thorn prick. Dermatofibromas are firm to the touch and can vary in color.",
      "symptoms":
          "Firm, small, raised nodule that may be red, brown, or purple; usually found on the legs; can be tender, itchy, or asymptomatic; often dimple inward when pinched."
    },
    {
      "name": "Melanoma",
      "description":
          "Melanoma is the most serious type of skin cancer, originating in the melanocytes, the cells that produce the pigment melanin. It can develop in an existing mole or appear as a new dark spot on the skin. Early detection and treatment are crucial as melanoma can spread rapidly to other parts of the body.",
      "symptoms":
          "New, unusual growth or a change in an existing mole; can appear as a large brownish spot with darker speckles; a mole that changes in color, size or feel or that bleeds; a small lesion with an irregular border and portions that appear red, white, blue or blue-black; dark lesions on the palms, soles, fingertips, or toes, or on mucous membranes lining the mouth, nose, vagina or anus."
    },
    {
      "name": "Nevus",
      "description":
          "A nevus (plural nevi), commonly known as a mole, is a benign growth on the skin that develops when melanocytes grow in clusters. Moles can appear anywhere on the skin, alone or in groups, and they usually appear before adulthood.",
      "symptoms":
          "Small, dark brown spots caused by clusters of pigmented cells; can be flesh-colored, pink, red, blue, or black; usually round or oval and can be flat or raised; may have hair growing from them."
    },
    {
      "name": "Pigmented Benign Keratosis",
      "description":
          "Pigmented benign keratosis, also known as seborrheic keratosis, is a non-cancerous skin growth that often appears in middle-aged and older adults. These growths are typically brown, black, or light tan and have a slightly elevated, waxy, or scaly appearance.",
      "symptoms":
          "Often appears as a black, brown, or tan growth; can have a waxy, scaly, slightly elevated appearance; common in older adults; can appear singly or in clusters; typically found on the head, neck, chest, or back."
    },
    {
      "name": "Seborrheic Keratosis",
      "description":
          "Seborrheic keratosis is a common non-cancerous skin growth that tends to appear in older adults. These growths are usually brown, black, or light tan and have a waxy, scaly, slightly elevated appearance. They can appear anywhere on the body but are most common on the face, chest, shoulders, or back.",
      "symptoms":
          "Waxy, scaly, slightly elevated appearance; can vary in color from light tan to black; round or oval in shape; well-defined edges; looks like it's stuck onto the skin; can appear singly or in clusters."
    },
    {
      "name": "Squamous Cell Carcinoma",
      "description":
          "Squamous cell carcinoma (SCC) is a common form of skin cancer that arises from the squamous cells in the outer layer of the skin. It often develops on areas of the body exposed to the sun, such as the face, ears, neck, lips, and backs of the hands. SCC can grow and spread to other parts of the body if not treated promptly.",
      "symptoms":
          "Firm, red nodule; flat sore with a scaly crust; new sore or raised area on an old scar or ulcer; rough, scaly patch on the lip that may evolve to an open sore; red sore or rough patch inside your mouth; a red, raised patch or wart-like sore on or in the anus or on your genitals."
    },
    {
      "name": "Vascular Lesion",
      "description":
          "Vascular lesions are abnormalities of the skin and underlying tissues that result from blood vessel irregularities. They can appear at birth (congenital) or develop later in life (acquired). These lesions can vary greatly in appearance and can be harmless or signify a more serious condition.",
      "symptoms":
          "Can appear as a red, blue, or purple mark; may be flat or raised; can vary in size and shape; commonly found on the face, neck, and chest; types include hemangiomas, port-wine stains, and cherry angiomas."
    },
    {
      "name": "Melanocytic Nevi",
      "description":
          "Melanocytic nevi, commonly known as moles, are benign growths of melanocytes, the cells that produce pigment in the skin. They are very common and can appear anywhere on the skin. Most people have between 10 and 40 moles. While most moles are harmless, some can develop into melanoma, a serious form of skin cancer.",
      "symptoms":
          "Small, dark brown spots caused by clusters of pigmented cells; can be flesh-colored, pink, red, blue, or black; usually round or oval and can be flat or raised; may have hair growing from them; changes in color, size, or shape should be monitored."
    },
    {
     "name":"Couldn't identify lesion",
     "description":"",
     "symptoms":""
    },
    {
      "name": "Seborrheic Keratoses",
      "description":
      "Seborrheic keratoses are common, noncancerous skin growths that appear as waxy, brown, black, or tan growths. They often appear on the chest, back, shoulders, or face. Seborrheic keratoses are harmless and typically do not require treatment unless they cause discomfort or cosmetic concerns.",
      "symptoms":
      "Waxy, wart-like growths that are light tan, brown, or black; slightly raised with a well-defined edge; appear 'stuck on' the skin surface; can be rough or slightly scaly; may itch or cause irritation, especially if rubbed by clothing."
    }
  ];
}
