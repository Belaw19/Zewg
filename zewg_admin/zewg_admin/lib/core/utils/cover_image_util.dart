import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// Portable cover storage: assets paths, app-relative files, or `b64:` payloads for API sync.
class CoverImageUtil {
  static const b64Prefix = 'b64:';

  static Future<String?> encodePickedImage(XFile file) async {
    final bytes = await file.readAsBytes();
    if (bytes.isEmpty) return null;
    return '$b64Prefix${base64Encode(bytes)}';
  }

  static Widget build(String? source, {double? height, double? width, BoxFit fit = BoxFit.cover}) {
    if (source == null || source.isEmpty) {
      return _placeholder(height: height, width: width);
    }

    if (source.startsWith(b64Prefix)) {
      try {
        final bytes = base64Decode(source.substring(b64Prefix.length));
        return Image.memory(bytes, height: height, width: width, fit: fit);
      } catch (_) {
        return _placeholder(height: height, width: width);
      }
    }

    if (source.startsWith('assets/')) {
      return Image.asset(source, height: height, width: width, fit: fit);
    }

    final file = File(source);
    if (file.existsSync()) {
      return Image.file(file, height: height, width: width, fit: fit);
    }

    return _placeholder(height: height, width: width);
  }

  static Widget _placeholder({double? height, double? width}) {
    return Container(
      height: height,
      width: width,
      color: const Color(0xFFE8E8E8),
      alignment: Alignment.center,
      child: const Icon(Icons.image_outlined, size: 48, color: Color(0xFF9E9E9E)),
    );
  }
}
