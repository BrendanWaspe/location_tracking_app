/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/Inter_28pt-Bold.ttf
  String get inter28ptBold => 'assets/fonts/Inter_28pt-Bold.ttf';

  /// File path: assets/fonts/Inter_28pt-ExtraBold.ttf
  String get inter28ptExtraBold => 'assets/fonts/Inter_28pt-ExtraBold.ttf';

  /// File path: assets/fonts/Inter_28pt-Light.ttf
  String get inter28ptLight => 'assets/fonts/Inter_28pt-Light.ttf';

  /// File path: assets/fonts/Inter_28pt-Medium.ttf
  String get inter28ptMedium => 'assets/fonts/Inter_28pt-Medium.ttf';

  /// File path: assets/fonts/Inter_28pt-SemiBold.ttf
  String get inter28ptSemiBold => 'assets/fonts/Inter_28pt-SemiBold.ttf';

  /// File path: assets/fonts/Inter_28pt-Thin.ttf
  String get inter28ptThin => 'assets/fonts/Inter_28pt-Thin.ttf';

  /// File path: assets/fonts/SF-Pro-Display-Bold.otf
  String get sFProDisplayBold => 'assets/fonts/SF-Pro-Display-Bold.otf';

  /// File path: assets/fonts/SF-Pro-Display-Heavy.otf
  String get sFProDisplayHeavy => 'assets/fonts/SF-Pro-Display-Heavy.otf';

  /// File path: assets/fonts/SF-Pro-Display-Light.otf
  String get sFProDisplayLight => 'assets/fonts/SF-Pro-Display-Light.otf';

  /// File path: assets/fonts/SF-Pro-Display-Medium.otf
  String get sFProDisplayMedium => 'assets/fonts/SF-Pro-Display-Medium.otf';

  /// File path: assets/fonts/SF-Pro-Display-Regular.otf
  String get sFProDisplayRegular => 'assets/fonts/SF-Pro-Display-Regular.otf';

  /// File path: assets/fonts/SF-Pro-Display-Semibold.otf
  String get sFProDisplaySemibold => 'assets/fonts/SF-Pro-Display-Semibold.otf';

  /// File path: assets/fonts/SF-Pro-Display-Ultralight.otf
  String get sFProDisplayUltralight => 'assets/fonts/SF-Pro-Display-Ultralight.otf';

  /// List of all assets
  List<String> get values => [
        inter28ptBold,
        inter28ptExtraBold,
        inter28ptLight,
        inter28ptMedium,
        inter28ptSemiBold,
        inter28ptThin,
        sFProDisplayBold,
        sFProDisplayHeavy,
        sFProDisplayLight,
        sFProDisplayMedium,
        sFProDisplayRegular,
        sFProDisplaySemibold,
        sFProDisplayUltralight
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/instagram.png
  AssetGenImage get instagram => const AssetGenImage('assets/images/instagram.png');

  /// File path: assets/images/linkedin.png
  AssetGenImage get linkedin => const AssetGenImage('assets/images/linkedin.png');

  /// File path: assets/images/tiktok.png
  AssetGenImage get tiktok => const AssetGenImage('assets/images/tiktok.png');

  /// File path: assets/images/twitter.png
  AssetGenImage get twitter => const AssetGenImage('assets/images/twitter.png');

  /// List of all assets
  List<AssetGenImage> get values => [instagram, linkedin, tiktok, twitter];
}

class Assets {
  const Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const SvgGenImage logo = SvgGenImage('assets/logo.svg');
  static const SvgGenImage logoText = SvgGenImage('assets/logo_text.svg');

  /// List of all assets
  static List<SvgGenImage> get values => [logo, logoText];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ?? (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
