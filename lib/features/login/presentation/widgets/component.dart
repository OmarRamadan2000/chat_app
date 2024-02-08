import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RowBeforeTextField extends StatelessWidget {
  const RowBeforeTextField({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              label,
              style:
                  TextStyle(fontWeight: FontWeight.w500, color: AppColors.grey),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}

Widget defualtTextFormField({
  required controller,
  required type,
  Function? onSubmit,
  String? hint,
  ispassword = false,
  Widget? prefix,
  Widget? suffix,
  bool readonly = false,
  FocusNode? focusNode,

  // ignore: non_constant_identifier_names
  Function? suffix_pressed,
  // ignore: non_constant_identifier_names
  required String? Function(String?)? validate,
  Function()? ontap,
}) =>
    Container(
      //height: 50,
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        controller: controller,

        keyboardType: type,
        // onFieldSubmitted: (s) {
        //  on_Submit!(s);
        // },
        focusNode: focusNode,
        validator: validate,
        readOnly: readonly,
        onTap: ontap,
        obscureText: ispassword,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: const EdgeInsets.all(15),
          suffixIcon: suffix,
          suffixIconColor: AppColors.grey,
          prefixIcon: prefix,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );

Widget defualtButton({
  required String text,
  required Function()? function,
  bool loading = false,
  IconData? icon,
}) =>
    SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: function,
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: loading
                  ? const CircularProgressIndicator()
                  : Text(text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black)),
            ),
          ],
        ),
      ),
    );

class Name extends StatelessWidget {
  const Name({super.key, required this.name, required this.bottomHint});
  final String name;
  final String bottomHint;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.displayMedium,
              maxLines: 1,
            ),
            Text(
              bottomHint,
              style: Theme.of(context).textTheme.titleSmall,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ImageAvatar extends StatelessWidget {
  ImageAvatar(
      {super.key, required this.size, required this.image, this.profileImage});
  final double size;
  final String image;
  File? profileImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size * 2,
      height: size * 2,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey,
      ),
      child: ClipOval(
          child: profileImage != null
              ? Image.file(profileImage!, fit: BoxFit.cover)
              : CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: image,
                  placeholder: (context, url) => const ShimmerImage(size: 55),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )),
    );
  }
}

class ShimmerImage extends StatelessWidget {
  const ShimmerImage({super.key, required this.size});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[500]!,
        highlightColor: Colors.grey[400]!,
        child: CircleAvatar(
          backgroundColor: Colors.grey,
          radius: size,
        ));
  }
}

void navigateAndFinish(context, widget) =>
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return widget;
        },
      ),
      (_) => false,
    );
void navigateAndFinishNavBar(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );
void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
