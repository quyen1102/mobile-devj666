# Phase 2: Legacy Icons Cleanup

## Context Links
- **Tệp cấu hình**: [pubspec.yaml](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/pubspec.yaml)

## Overview
- **Độ ưu tiên**: Trung bình
- **Trạng thái hiện tại**: Hoàn thành
- **Mô tả**: Xóa bỏ các tệp định nghĩa icon cũ (`lichess_icons.dart`, `social_icons.dart`), các tệp font tùy chỉnh không còn sử dụng và dọn dẹp cấu hình trong `pubspec.yaml`.

## Key Insights
- Không còn bất cứ class hoặc widget nào tham chiếu tới `LichessIcons` hay `SocialIcons` sau Phase 1.
- Xóa các asset tĩnh này sẽ giúp giảm bớt kích thước file bundle và làm gọn cấu trúc cây thư mục dự án.

## Requirements
- Xóa bỏ hoàn toàn các tệp định nghĩa Dart của các bộ icon cũ.
- Xóa bỏ font tùy chỉnh `SocialIcons.ttf` và gỡ khai báo khỏi `pubspec.yaml`.
- Xóa tệp cấu hình sinh font `fluttericon.json`.

## Architecture
- Dọn dẹp tài nguyên thừa, nâng cao khả năng bảo trì.

## Related Code Files
- [DELETE] [lichess_icons.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/styles/lichess_icons.dart)
- [DELETE] [social_icons.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/styles/social_icons.dart)
- [DELETE] [fluttericon.json](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/fluttericon.json)
- [DELETE] `assets/fonts/SocialIcons.ttf`
- [MODIFY] [pubspec.yaml](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/pubspec.yaml)

## Implementation Steps
1. Xóa các tệp Dart:
   - `lib/src/styles/lichess_icons.dart`
   - `lib/src/styles/social_icons.dart`
2. Xóa tệp cấu hình `fluttericon.json`.
3. Xóa tệp font vật lý `assets/fonts/SocialIcons.ttf` và cả thư mục `assets/fonts/` nếu trống.
4. Cập nhật [pubspec.yaml](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/pubspec.yaml): Gỡ bỏ phần cấu hình đăng ký font `SocialIcons`.
5. Chạy `flutter pub get` để đồng bộ.
6. Chạy `flutter analyze` để đảm bảo dự án sạch lỗi.

## Todo List
- [x] Xóa tệp `lichess_icons.dart`
- [x] Xóa tệp `social_icons.dart`
- [x] Xóa tệp `fluttericon.json`
- [x] Xóa font `SocialIcons.ttf`
- [x] Cập nhật `pubspec.yaml`
- [x] Chạy `flutter pub get` và `flutter analyze` kiểm thử tĩnh

## Success Criteria
- Thư mục `assets/fonts/` được dọn dẹp sạch sẽ.
- Cấu hình fonts trong `pubspec.yaml` không còn chứa `SocialIcons`.
- Dự án compile hoàn toàn bình thường mà không có lỗi.

## Risk Assessment
- Không có rủi ro lớn.

## Security Considerations
- Không có.

## Next Steps
- Hoàn thành toàn bộ tiến trình tối ưu hóa icon.
