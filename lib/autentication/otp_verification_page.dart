import 'dart:convert';

import 'package:absolutemen_app/routes/app_router.dart';
import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:otp_autofill/otp_autofill.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// import 'package:sms_autofill/sms_autofill.dart';

@RoutePage()
class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  // String otpCode = '';
  // String otp = '';
  String? comingSMS = '';
  late OTPTextEditController otpTextEditController;
  late OTPInteractor otpInteractor;

  // Future<void> initSmsListener() async {
  //   String? commingSms = '';
  //   try {
  //     commingSms = await AltSmsAutofill().listenForSms;
  //   } on PlatformException {
  //     commingSms = 'Failed to get Sms.';
  //   }
  //   if (!mounted) return;

  //   setState(() {
  //     comingSMS = commingSms;
  //   });
  // }

  Future<void> verifyOtp(String otp, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.29.238:4000/app/verify-otp'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'otp': otp,

          // Add any other data you want to send in the body
        }),
      );

      if (response.statusCode == 200) {
        // Successful POST request, handle the response here
        final responseData = jsonDecode(response.body);
        print(responseData);

        final sucessSnackbar = SnackBar(
            backgroundColor: Colors.green[400],
            content: Text(
              responseData['msg'],
              style: TextStyle(color: Colors.grey[50]),
            ));

        ScaffoldMessenger.of(context).showSnackBar(sucessSnackbar);
        context.router.popAndPush((HomeRoute()));
      } else if (response.statusCode == 506) {
        final snackbar = SnackBar(content: Text("invalid otp"));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      } else {
        // result = '';

        // If the server returns an error response, throw an exception
        throw Exception('Failed to post data');
      }
    } catch (e) {
      final error = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(error);
    }
  }

  @override
  void initState() {
    // initSmsListener();
    super.initState();
    initInteractor();
    otpTextEditController = OTPTextEditController(
      codeLength: 4,
      onCodeReceive: (code) => print('Your Application receive code - $code'),
      otpInteractor: otpInteractor,
    )..startListenUserConsent(
        (code) {
          final exp = RegExp(r'(\d{4})');
          return exp.stringMatch(code ?? '') ?? '';
        },
      );
  }

  Future<void> initInteractor() async {
    otpInteractor = OTPInteractor();

    // You can receive your app signature by using this method.
    final appSignature = await otpInteractor.getAppSignature();

    if (kDebugMode) {
      print('Your app signature: $appSignature');
    }
  }

  @override
  void dispose() {
    // SmsAutoFill().unregisterListener();
    // AltSmsAutofill().unregisterListener();
    otpTextEditController.stopListen();
    print('Unregistered Listener');
    super.dispose();
  }

  // void _listenOtp() async {
  //   // await SmsAutoFill().listenForCode();
  //   print("OTP Listen is called");
  // }

  @override
  Widget build(BuildContext context) {
    // TextEditingController otpcode = TextEditingController(text: comingSMS);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Verification Code",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'We send OTP code to your mobile number',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: PinCodeTextField(
                autoFocus: true,
                appContext: context,
                length: 4,
                pastedTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  selectedFillColor: Colors.blue,
                  inactiveColor: Colors.grey,
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10),
                  fieldHeight: 50,
                  fieldWidth: 50,
                  activeFillColor: Colors.blue,
                ),
                cursorColor: Colors.black,
                animationDuration: const Duration(milliseconds: 300),
                controller: otpTextEditController,
              ),
            ),
            // TextField(
            //   controller: otpTextEditController,
            // ),
            // PinFieldAutoFill(
            //   currentCode: otpCode,
            //   decoration: BoxLooseDecoration(
            //       radius: Radius.circular(12),
            //       strokeColorBuilder: FixedColorBuilder(Color(0xFF8C4A52))),
            //   codeLength: 6,
            //   onCodeChanged: (code) {
            //     print("OnCodeChanged : $code");
            //     otpCode = code.toString();
            //   },
            //   onCodeSubmitted: (val) {
            //     print("OnCodeSubmitted : $val");
            //   },
            // ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                  style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.symmetric(
                      vertical: 14,
                    )),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0Xff2556B9)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23.0))),
                  ),
                  onPressed: () {
                    verifyOtp(otpTextEditController.text, context);
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
