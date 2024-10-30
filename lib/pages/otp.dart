import 'package:burgan_bill/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OtpPage extends StatefulWidget {
  @override
  OtpPageState createState() => OtpPageState();
}

class OtpPageState extends State<OtpPage> {
  final List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Email Verification')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: SizedBox(
                    width: 40,
                    child: TextField(
                      controller: otpControllers[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 5) {
                          FocusScope.of(context).nextFocus();
                        }
                        if (value.isEmpty && index > 0) {
                          FocusScope.of(context).previousFocus();
                        }
                      },
                      decoration: const InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(curve: Easing.linear)
                    .slideY(delay: (150 + (index * 50)).milliseconds);
              }),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String otp = otpControllers
                    .map((element) => element.text)
                    .toList()
                    .fold('', (sum, o) => o + sum);
                print(otp);
                //   var otpCode = '';
                //   otpCode += otpControllers[0].text;
                //   otpCode += otpControllers[1].text;
                //   otpCode += otpControllers[2].text;
                //   otpCode += otpControllers[3].text;
                //   otpCode += otpControllers[4].text;
                //   otpCode += otpControllers[5].text;

                //   print(otpCode);
              },
              child: const Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}

List<String> pricesStr = [
  "12",
  "8",
  "10",
];
