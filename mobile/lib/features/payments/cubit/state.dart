abstract class PaymentStates {}

class PaymentInitialStates extends PaymentStates {}

class PaymentAuthLoadingStates extends PaymentInitialStates {}

class PaymentAuthSuccessStates extends PaymentInitialStates {}

class PaymentAuthErrorStates extends PaymentInitialStates {
  final String error;
  PaymentAuthErrorStates(this.error);
}

class PaymentOrderIdLoadingStates extends PaymentInitialStates {}

class PaymentOrderIdSuccessStates extends PaymentInitialStates {}

class PaymentOrderIdErrorStates extends PaymentInitialStates {
  final String error;
  PaymentOrderIdErrorStates(this.error);
}

class PaymentRequestTokenLoadingStates extends PaymentInitialStates {}

class PaymentRequestTokenSuccessStates extends PaymentInitialStates {}

class PaymentRequestTokenErrorStates extends PaymentInitialStates {
  final String error;
  PaymentRequestTokenErrorStates(this.error);
}

class PaymentRefCodeLoadingStates extends PaymentInitialStates {}

class PaymentRefCodeSuccessStates extends PaymentInitialStates {}

class PaymentRefCodeErrorStates extends PaymentInitialStates {
  final String error;
  PaymentRefCodeErrorStates(this.error);
}
