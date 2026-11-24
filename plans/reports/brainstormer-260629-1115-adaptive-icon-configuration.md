# Brainstorming Report: Cấu hình Icon đa nền tảng (Platform-Adaptive Icons)

**Date:** 260629
**Time:** 1115
**Task Slug:** adaptive-icon-configuration
**Skill:** brainstorm

## 1. Vấn đề & Yêu cầu
Hiện tại, dự án `nf_base` đang chuyển đổi thành một Base App đa nền tảng (Android & iOS).
- **Vấn đề**: Các icon trong ứng dụng chưa được tối ưu hóa đồng bộ theo nền tảng. Ví dụ:
  - Một số nơi đang hardcode icon Material (như `Icons.chevron_right` trong [list.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/list.dart)) trên cả iOS.
  - Cách làm hiện tại để adaptive là tạo các class riêng biệt (như `PlatformShareIcon` trong [platform.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/platform.dart)), dẫn đến việc viết quá nhiều boilerplate code cho từng icon.
- **Yêu cầu**:
  - Tự động thay đổi giữa Material (Android) và Cupertino (iOS) một cách tự nhiên (Native-like look and feel).
  - Tránh boilerplate, dễ sử dụng cho lập trình viên (Developer Experience - DX).
  - Tích hợp mượt mà vào hệ thống widget dùng chung hiện tại.

---

## 2. Các phương án thiết kế

### Phương án A: Định nghĩa class token tĩnh chứa hàm ánh xạ `AppIcons`
Tạo một file [app_icons.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/styles/app_icons.dart) cung cấp các phương thức hoặc getter trả về `IconData` dựa trên platform hiện tại của context.
```dart
class AppIcons {
  static IconData share(BuildContext context) =>
      Theme.of(context).platform == TargetPlatform.iOS ? CupertinoIcons.share : Icons.share;
  
  static IconData chevronRight(BuildContext context) =>
      Theme.of(context).platform == TargetPlatform.iOS ? CupertinoIcons.chevron_right : Icons.chevron_right;
}
```
- **Ưu điểm**:
  - Rất rõ ràng, dễ bảo trì và cập nhật tập trung.
  - Sử dụng trực tiếp với widget `Icon` tiêu chuẩn của Flutter (`Icon(AppIcons.share(context))`).
- **Nhược điểm**: Cần truyền `BuildContext` vào mọi hàm lấy icon, làm code hơi rườm rà ở một số chỗ.

---

### Phương án B: Xây dựng Widget `PlatformIcon` dùng chung (Khuyên dùng)
Tạo widget `PlatformIcon` nhận vào cả icon Android và iOS, tự động phân phối theo nền tảng:
```dart
class PlatformIcon extends StatelessWidget {
  const PlatformIcon({
    super.key,
    required this.androidIcon,
    required this.iosIcon,
    this.size,
    this.color,
  });

  final IconData androidIcon;
  final IconData iosIcon;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return Icon(isIOS ? iosIcon : androidIcon, size: size, color: color);
  }
}
```
- **Ưu điểm**:
  - Không cần truyền `BuildContext` thủ công, widget tự giải quyết thông qua `Theme.of(context)`.
  - Cực kỳ linh hoạt khi gọi ad-hoc trong code UI (`PlatformIcon(androidIcon: Icons.share, iosIcon: CupertinoIcons.share)`).
  - Dễ dàng thay thế cho widget `Icon` hiện tại.
- **Nhược điểm**: Có thể lặp lại code khai báo cặp icon ở nhiều nơi khác nhau nếu không kết hợp với một danh sách định nghĩa sẵn.

---

### Phương án C: Tạo enum/class Token tích hợp với Widget `PlatformIcon` (Tối ưu nhất)
Kết hợp hai phương án trên: Định nghĩa danh sách các icon chung của hệ thống dưới dạng enum hoặc class, sau đó truyền Token đó vào `PlatformIcon`.
```dart
enum AppIconToken {
  share,
  chevronRight,
  settings,
  arrowTrendUp,
  arrowTrendDown,
}

class PlatformIcon extends StatelessWidget {
  const PlatformIcon(this.token, {super.key, this.size, this.color});

  final AppIconToken token;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final iconData = _getIconData(token, isIOS);
    return Icon(iconData, size: size, color: color);
  }

  IconData _getIconData(AppIconToken token, bool isIOS) {
    switch (token) {
      case AppIconToken.share:
        return isIOS ? CupertinoIcons.share : Icons.share;
      case AppIconToken.chevronRight:
        return isIOS ? CupertinoIcons.chevron_right : Icons.chevron_right;
      case AppIconToken.settings:
        return isIOS ? CupertinoIcons.settings : Icons.settings;
      case AppIconToken.arrowTrendUp:
        return isIOS ? CupertinoIcons.arrow_up_right : Icons.north_east;
      case AppIconToken.arrowTrendDown:
        return isIOS ? CupertinoIcons.arrow_down_right : Icons.south_east;
    }
  }
}
```
- **Ưu điểm**:
  - Quản lý tập trung toàn bộ icon hệ thống (Single Source of Truth).
  - Cú pháp gọn gàng (`PlatformIcon(AppIconToken.share)`).
  - Bảo vệ dự án khỏi các thay đổi trong tương lai (nếu muốn đổi từ Material Icons sang Material Symbols hoặc font tùy chỉnh khác, chỉ cần thay đổi trong `_getIconData`).
- **Nhược điểm**: Cần khai báo token mới trong enum khi mở rộng icon.

---

## 3. Giải pháp khuyến nghị
Chọn **Phương án C (PlatformIcon sử dụng AppIconToken)** kết hợp với việc cho phép override thủ công (để linh hoạt khi cần sử dụng một icon ad-hoc):
```dart
class PlatformIcon extends StatelessWidget {
  const PlatformIcon({
    super.key,
    this.token,
    this.androidIcon,
    this.iosIcon,
    this.size,
    this.color,
  }) : assert(token != null || (androidIcon != null && iosIcon != null),
            'Phải cung cấp token hoặc cả hai androidIcon và iosIcon');

  final AppIconToken? token;
  final IconData? androidIcon;
  final IconData? iosIcon;
  final double? size;
  final Color? color;
  ...
}
```
Thiết kế này vừa đảm bảo tính nhất quán (Consistency) vừa cung cấp sự linh hoạt (Flexibility) tối đa.

---

## 4. Kế hoạch triển khai & Next Steps
1. **Tạo cấu trúc dữ liệu**:
   - Thêm enum `AppIconToken` và widget `PlatformIcon` vào [platform.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/platform.dart).
2. **Refactor mã nguồn**:
   - Thay thế các class đơn lẻ như `PlatformShareIcon` bằng cách sử dụng `PlatformIcon`.
   - Cập nhật [list.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/list.dart) sử dụng `PlatformIcon(AppIconToken.chevronRight)`.
   - Cập nhật [progression_widget.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/progression_widget.dart) sử dụng `PlatformIcon(AppIconToken.arrowTrendUp)` và `PlatformIcon(AppIconToken.arrowTrendDown)`.
3. **Dọn dẹp**: Gỡ bỏ các tệp font/icon cũ lỗi thời.
