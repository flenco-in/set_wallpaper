import 'set_wallpaper_platform_interface.dart';
import 'package:flutter/services.dart';

enum WallpaperType {
  system, // Both home and lock screen
  home, // Only home screen
  lock // Only lock screen
}

class SetWallpaper {
  static const MethodChannel _channel = MethodChannel('set_wallpaper');
  Future<String?> getPlatformVersion() {
    return SetWallpaperPlatform.instance.getPlatformVersion();
  }

  static Future<bool> setWallpaper({
    required String imagePath,
    WallpaperType wallpaperType = WallpaperType.system,
  }) async {
    try {
      final int wallpaperFlag = _getWallpaperFlag(wallpaperType);
      final bool success = await _channel.invokeMethod('setWallpaper', {
        'imagePath': imagePath,
        'wallpaperType': wallpaperFlag,
      });
      return success;
    } catch (e) {
      rethrow;
    }
  }

  static int _getWallpaperFlag(WallpaperType type) {
    switch (type) {
      case WallpaperType.system:
        return 1; // WallpaperManager.FLAG_SYSTEM
      case WallpaperType.home:
        return 2; // WallpaperManager.FLAG_SYSTEM
      case WallpaperType.lock:
        return 3; // WallpaperManager.FLAG_LOCK
    }
  }
}
