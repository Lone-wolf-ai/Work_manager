import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../core/utils/validators/validation.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm(
      {super.key,
      required this.username,
      required this.email,
      required this.password,
      required this.confirmpassword,
      required this.phonenumber,
      this.obscurepass = true,
      this.obscureconfirmpass = true,
      required this.obscurepassfunc,
      required this.obscureconfirmpassfunc,
      required this.address, required this.fullname});
  final TextEditingController fullname;
  final TextEditingController username;
  final TextEditingController email;
  final TextEditingController phonenumber;
  final TextEditingController password;
  final TextEditingController confirmpassword;
  final TextEditingController address;
  final bool obscurepass;
  final bool obscureconfirmpass;
  final VoidCallback obscurepassfunc;
  final VoidCallback obscureconfirmpassfunc;
  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: fullname,
            validator: (value) =>
                Validator.validateEmptyText("Full Name", value),
            decoration: const InputDecoration(
              labelText: "Full Name",

              prefixIcon: Icon(Icons.person),
              labelStyle: TextStyle(
                color: Vx.gray500,
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: username,
            validator: (value) =>
                Validator.validateEmptyText("Username", value),
            decoration: const InputDecoration(
              labelText: 'Username',
              prefixIcon: Icon(Icons.person),
              labelStyle: TextStyle(
                color: Vx.gray500,
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: email,
            validator: (value) => Validator.validateEmail(value),
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.mail),
              labelStyle: TextStyle(
                color: Vx.gray500,
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: address,
            validator: (value) => Validator.validateEmptyText("Address", value),
            decoration: const InputDecoration(
              labelText: 'Address',
              prefixIcon: Icon(Icons.mail),
              labelStyle: TextStyle(
                color: Vx.gray500,
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: phonenumber,
            validator: (value) => Validator.validatePhoneNumber(value),
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              prefixIcon: Icon(Iconsax.call),
              labelStyle: TextStyle(
                color: Vx.gray500,
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: password,
            validator: (value) => Validator.validatePassword(value),
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                  onPressed: obscurepassfunc,
                  icon: obscurepass
                      ? const Icon(Iconsax.eye)
                      : const Icon(Iconsax.eye_slash)),
              labelStyle: const TextStyle(
                color: Vx.gray500,
                fontWeight: FontWeight.bold,
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
            obscureText: obscurepass,
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: confirmpassword,
            validator: (value) => Validator.validatePassword(value),
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                  onPressed: obscureconfirmpassfunc,
                  icon: obscureconfirmpass
                      ? const Icon(Iconsax.eye)
                      : const Icon(Iconsax.eye_slash)),
              labelStyle: const TextStyle(
                color: Vx.gray500,
                fontWeight: FontWeight.bold,
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
            obscureText: obscureconfirmpass,
          ),
        ],
      ),
    );
  }
}
