import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_text_styles.dart';

/// Custom text field widget with validation support
/// Provides consistent text input styling across the application
class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final String? helperText;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function()? onTap;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconTap;
  final bool showPasswordToggle;
  final FocusNode? focusNode;
  final bool autofocus;

  const CustomTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.helperText,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.showPasswordToggle = false,
    this.focusNode,
    this.autofocus = false,
  });

  /// Email text field with email keyboard and validation
  const CustomTextField.email({
    super.key,
    this.controller,
    this.label = 'Email',
    this.hint = 'Enter your email',
    this.errorText,
    this.helperText,
    this.enabled = true,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.autofocus = false,
  })  : obscureText = false,
        readOnly = false,
        maxLines = 1,
        minLines = null,
        maxLength = null,
        keyboardType = TextInputType.emailAddress,
        textInputAction = TextInputAction.next,
        inputFormatters = null,
        onTap = null,
        prefixIcon = Icons.email_outlined,
        suffixIcon = null,
        onSuffixIconTap = null,
        showPasswordToggle = false;

  /// Password text field with obscure text and toggle visibility
  const CustomTextField.password({
    super.key,
    this.controller,
    this.label = 'Password',
    this.hint = 'Enter your password',
    this.errorText,
    this.helperText,
    this.enabled = true,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.autofocus = false,
  })  : obscureText = true,
        readOnly = false,
        maxLines = 1,
        minLines = null,
        maxLength = null,
        keyboardType = TextInputType.visiblePassword,
        textInputAction = TextInputAction.done,
        inputFormatters = null,
        onTap = null,
        prefixIcon = Icons.lock_outlined,
        suffixIcon = null,
        onSuffixIconTap = null,
        showPasswordToggle = true;

  /// Multiline text field for longer text input
  const CustomTextField.multiline({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.helperText,
    this.enabled = true,
    this.maxLines = 5,
    this.minLines = 3,
    this.maxLength,
    this.validator,
    this.onChanged,
    this.focusNode,
    this.autofocus = false,
  })  : obscureText = false,
        readOnly = false,
        keyboardType = TextInputType.multiline,
        textInputAction = TextInputAction.newline,
        inputFormatters = null,
        onSubmitted = null,
        onTap = null,
        prefixIcon = null,
        suffixIcon = null,
        onSuffixIconTap = null,
        showPasswordToggle = false;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  void didUpdateWidget(CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.obscureText != oldWidget.obscureText) {
      _obscureText = widget.obscureText;
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          obscureText: _obscureText,
          maxLines: _obscureText ? 1 : widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          inputFormatters: widget.inputFormatters,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          onTap: widget.onTap,
          style: AppTextStyles.bodyMedium,
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hint,
            errorText: widget.errorText,
            helperText: widget.helperText,
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon)
                : null,
            suffixIcon: _buildSuffixIcon(),
            counterText: widget.maxLength != null ? null : '',
          ),
        ),
      ],
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.showPasswordToggle) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          semanticLabel: _obscureText ? 'Show password' : 'Hide password',
        ),
        onPressed: _togglePasswordVisibility,
      );
    }

    if (widget.suffixIcon != null) {
      return IconButton(
        icon: Icon(widget.suffixIcon),
        onPressed: widget.onSuffixIconTap,
      );
    }

    return null;
  }
}
