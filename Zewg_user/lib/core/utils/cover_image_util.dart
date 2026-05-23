import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class CoverImageUtil {
  static const b64Prefix = 'b64:';

  static Widget build(String? source, {double? height, double? width, BoxFit fit = BoxFit.cover}) {
    if (source == null || source.trim().isEmpty) {
      return _placeholder(height: height, width: width);
    }

    final value = source.trim();

    if (value.startsWith(b64Prefix)) {
      try {
        final bytes = base64Decode(value.substring(b64Prefix.length));
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.memory(bytes, height: height, width: width, fit: fit),
        );
      } catch (_) {
        return _placeholder(height: height, width: width);
      }
    }

    if (value.startsWith('http://') || value.startsWith('https://')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          value,
          height: height,
          width: width,
          fit: fit,
          errorBuilder: (_, __, ___) => _placeholder(height: height, width: width),
        ),
      );
    }

    if (value.startsWith('assets/')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(value, height: height, width: width, fit: fit),
      );
    }

    final file = File(value);
    if (file.existsSync()) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(file, height: height, width: width, fit: fit),
      );
    }

    return _placeholder(height: height, width: width);
  }

  static Widget _placeholder({double? height, double? width}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: const Color(0xFFE8E8E8),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: const Icon(Icons.image_outlined, size: 40, color: Color(0xFF9E9E9E)),
    );
  }
}
