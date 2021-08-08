import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/country_code_picker.dart';
import 'package:country_calling_code_picker/functions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:pixelegram/application/telegram_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Country? _country;
  late TextEditingController _editingController;

  bool isSending = false;
  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController();
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Phone'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: [
            Column(
              children: [
                TextButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    Country? country = await showCountryPickerSheet(context);
                    if (country != null) {
                      setState(() {
                        _country = country;
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.only(bottom: 6, top: 12),
                    child: Row(children: _countryWidget()),
                  ),
                ),
                Container(height: 0.5, color: Colors.grey),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            TextField(
              controller: _editingController,
              textInputAction: TextInputAction.send,
              decoration: InputDecoration(
                hintText: 'Please enter your phone number',
                hintStyle: TextStyle(fontSize: 18),
                contentPadding: const EdgeInsets.only(left: 10),
              ),
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue,
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              'Please confirm your contry code and enter your phone number.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            sendPhone();
          },
          child: !isSending
              ? Icon(Icons.forward, color: Colors.white)
              : SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(color: Colors.white))),
    );
  }

  List<Widget> _countryWidget() {
    return _country == null
        ? [
            Text('Please choose your country',
                style: TextStyle(fontSize: 16, color: Colors.grey))
          ]
        : <Widget>[
            Image.asset(_country!.flag,
                package: countryCodePackageName, width: 32),
            SizedBox(width: 16),
            Expanded(
                child: Text('${_country!.callingCode} ${_country!.name}',
                    style: TextStyle(fontSize: 18))),
          ];
  }

  sendPhone() async {
    if (isSending) {
      return;
    }
    String? errorMsg;
    if (_country == null) {
      errorMsg = 'Please Choose Your Country';
    } else if (_editingController.text.trim().isEmpty) {
      errorMsg = 'Please Enter Your Phone Number';
    }
    if (errorMsg != null) {
      Fluttertoast.showToast(msg: errorMsg, gravity: ToastGravity.CENTER);
      return;
    }

    setState(() {
      isSending = true;
    });

    await GetIt.I<TelegramService>().setAuthenticationPhoneNumber(
        '${_country!.callingCode}${_editingController.text.trim()}');
  }
}
