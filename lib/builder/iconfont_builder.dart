// ignore: depend_on_referenced_packages
import 'package:build/build.dart';
import 'dart:convert';

/// `build_runner` 识别的 Builder
Builder iconFontBuilder(BuilderOptions options) => IconFontBuilder();

/// 基于 `assets/fonts/iconfont.json` 生成 `components/icon_font.dart`
class IconFontBuilder implements Builder {
  @override
  final buildExtensions = const {
    'assets/fonts/iconfont.json': ['lib/gen/icon_font.gen.dart'],
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    final inputId = buildStep.inputId;
    final outputId = AssetId(
      buildStep.inputId.package,
      'lib/gen/icon_font.gen.dart',
    );

    if (!await buildStep.canRead(inputId)) {
      log.warning('⚠️ iconfont.json 文件未找到，跳过生成');
      return;
    }

    final jsonString = await buildStep.readAsString(inputId);
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);

    final String fontFamily = jsonData["font_family"] ?? "IconFont";
    final List<dynamic> glyphs = jsonData["glyphs"] ?? [];

    final buffer =
        StringBuffer()
          ..writeln("// 该文件由 build_runner 自动生成，请勿手动修改")
          ..writeln("import 'package:flutter/widgets.dart';")
          ..writeln("")
          ..writeln("class IconFont {")
          ..writeln("  static const String _fontFamily = '$fontFamily';")
          ..writeln("");

    for (var glyph in glyphs) {
      final String name = glyph["name"].replaceAll('-', '_');
      final String unicode = glyph["unicode"];
      buffer.writeln(
        "  static const IconData $name = IconData(0x$unicode, fontFamily: _fontFamily);",
      );
    }

    buffer.writeln("}");

    await buildStep.writeAsString(outputId, buffer.toString());
  }
}
