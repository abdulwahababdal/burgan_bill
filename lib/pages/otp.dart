import 'package:burgan_bill/main.dart';
import 'package:burgan_bill/provider/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class OtpPage extends StatefulWidget {
  final String email;

  const OtpPage({Key? key, required this.email}) : super(key: key);

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
              onPressed: () async {
                String otp = otpControllers
                    .map((element) => element.text)
                    .toList()
                    .fold('', (sum, o) => sum + o);
                try {
                  await Provider.of<AuthProvider>(context, listen: false).otp(
                    email: widget.email,
                    otp: otp,
                  );
                  context.go('/dashboard');
                } on DioException catch (e) {
                  if (e.response != null && e.response!.data != null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(e.response!.data['message'] ??
                            "Unexpected error")));
                  }
                }

                print(otp);
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
