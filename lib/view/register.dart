import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view_model/auth.dart';
import 'login_screen.dart';


class RegisterScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Auth>(
        init: Auth(),
        builder: (controller)=>Scaffold(
      body:  LayoutBuilder(builder:
    (BuildContext context, BoxConstraints constraints) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.purple, Colors.pink],
        ),
      ),
      child: Form(
        key: _formKey,
        child: ListView(
          children:[Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(height: 20,),
              Image.asset('assets/images/log-in.png',width: 200, height: 200,),
              const Text(
                'إنشاء حساب,',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.white),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white),
                      ),

                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                    hintText: 'الاسم',
                    hintStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    prefixIcon: const Icon(
                      Icons.person_outline,
                      color: Colors.white,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'يرجا ملأ الحقل!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.name = value;
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.white),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white),
                      ),

                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                    hintText: 'البريدالالكتروني!',
                    hintStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Colors.white,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'يرجا ملأ الحقل!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.email = value;
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.white),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white),
                      ),

                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                    hintText: 'كلمة المرور',
                    hintStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: Colors.white,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'يرجا ملأ الحقل!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.password = value;
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _formKey.currentState?.save();
                  if (_formKey.currentState!.validate()) {
                    controller.createUserWithEmailAndPassword();}},
                style: ButtonStyle(backgroundColor:   MaterialStateProperty.all( Colors.deepPurple),),
                child: const Text('إنشاء'),
              ),
              const SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  Get.to(LoginScreen());
                },
                child: const Text.rich(
                    TextSpan(text: 'هل لديك حساب بالفعل؟ ',style: TextStyle(color: Colors.white),children: [TextSpan(text: 'سجل الدخول',
                      style: TextStyle(color: Colors.purple),)])

                ),
              ),
            ],
          ),],
        ),
      ),
    );})





    )) ;
  }
}


