import 'package:flutter/material.dart';

class FormInput extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final Widget suffixIcon;
  final TextInputType keyboardType;
  final bool bottom;
  final TextCapitalization textCapitalization;
  final bool enabled;
  final bool readOnly;
  final Function onTap;
  final Function onChanged;
  final Function(String value) validator;
  final TextInputAction textInputAction;
  final String initialValue;
  final bool autoValidate;
  FormInput({
    this.controller,
    this.onChanged,
    this.hintText,
    this.icon,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.bottom = true,
    this.textCapitalization = TextCapitalization.none,
    this.enabled = true,
    this.readOnly = false,
    this.validator,
    this.autoValidate = false,
    this.textInputAction,
    this.initialValue,
    this.onTap,
  });

  @override
  _FormInputState createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  TextStyle _textStyle() {
    return TextStyle(
      fontFamily: "WorkSansSemiBold",
      fontSize: 16.0,
      color: Colors.black,
    );
  }

  InputDecoration _decoration() {
    return InputDecoration(
      border: InputBorder.none,
      icon: Icon(
        widget.icon,
        color: Colors.black,
      ),
      hintText: widget.hintText,
      hintStyle: TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 16.0),
      suffixIcon: widget.suffixIcon,
    );
  }

  EdgeInsets _padding() {
    return EdgeInsets.only(
      top: 10.0,
      bottom: 10.0,
      left: 25.0,
      right: 25.0,
    );
  }

  Widget _bottom() {
    return Container(
      width: 250.0,
      height: 1.0,
      color: Colors.grey[400],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: _padding(),
          child: InkWell(
            onTap: widget.onTap,
            child: TextFormField(
              initialValue: widget.initialValue,
              onChanged: widget.onChanged,
              autovalidate: widget.autoValidate,
              validator: widget.validator,
              controller: widget.controller,
              readOnly: widget.readOnly,
              enabled: widget.enabled,
              obscureText: widget.obscureText,
              keyboardType: widget.keyboardType,
              textCapitalization: widget.textCapitalization,
              style: _textStyle(),
              decoration: _decoration(),
            ),
          ),
        ),
        widget.bottom ? _bottom() : Container()
      ],
    );
  }
}
