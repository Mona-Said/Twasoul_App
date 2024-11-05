import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultButton({
  Color color = Colors.blueAccent,
  double width = double.infinity,
  required String text,
  required VoidCallback function,
}) =>
    SizedBox(
      width: width,
      height: 50.0,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: MaterialButton(
          color: color,
          onPressed: function,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );

Widget textButton({
  required String text,
  required VoidCallback function,
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );

Widget formField({
  required TextEditingController controller,
  required String label,
  required IconData prefix,
  IconData? suffix,
  required TextInputType type,
  required String? Function(String?)? function,
  String? Function(String?)? submit,
  String? Function(String?)? onChanged,
  VoidCallback? pressed,
  VoidCallback? onTap,
  bool isClickable = true,
  bool isPassword = false,
}) =>
    Container(
      width: double.infinity,
      height: 60.0,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(40.0),
            ),
          ),
          labelText: label,
          prefixIcon: Icon(
            prefix,
          ),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: pressed,
                  icon: Icon(
                    suffix,
                  ),
                )
              : null,
        ),
        keyboardType: type,
        style: const TextStyle(fontSize: 15.0),
        obscureText: isPassword,
        validator: function,
        onTap: onTap,
        enabled: isClickable,
        onFieldSubmitted: submit,
        onChanged: onChanged,
      ),
    );

PreferredSize defaultAppBar({
  required BuildContext context,
  String? label,
  List<Widget>? actions,
}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(kToolbarHeight),
    child: AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          IconlyBroken.arrowLeft2,
        ),
      ),
      title: Text(
        label ?? '',
        style: const TextStyle(fontSize: 23.0),
      ),
      actions: actions,
      titleSpacing: 0.0,
    ),
  );
}

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 30.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false);

void itemToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseColorToast(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { success, warning, error }

Color chooseColorToast(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
  }
  return color;
}
