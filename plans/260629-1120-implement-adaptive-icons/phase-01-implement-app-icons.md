# Phase 1: Implement AppIcons & Refactor Widgets

## Context Links
- **Báo cáo brainstorm**: [brainstormer-260629-1115-adaptive-icon-configuration.md](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/plans/reports/brainstormer-260629-1115-adaptive-icon-configuration.md)
- **Tệp cấu hình**: [pubspec.yaml](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/pubspec.yaml)
- **Tệp widget cần sửa**:
  - [progression_widget.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/progression_widget.dart)
  - [list.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/list.dart)

## Overview
- **Độ ưu tiên**: Cao
- **Trạng thái hiện tại**: Hoàn thành
- **Mô tả**: Triển khai tệp định nghĩa `AppIcons` mới với các mapping icon thích ứng theo hệ điều hành (Android/iOS). Cập nhật các widget hiển thị xu hướng và điều hướng sử dụng `AppIcons`.

## Key Insights
- Class `AppIcons` sử dụng `defaultTargetPlatform == TargetPlatform.iOS` giúp tự động chọn `CupertinoIcons` hoặc `Icons` của Material mà không cần phụ thuộc vào `BuildContext`.
- Cần thay thế toàn bộ tham chiếu tới `LichessIcons` và các icon cứng của Material ở các widget danh sách bằng `AppIcons`.

## Requirements
- Tạo mới file `lib/src/styles/app_icons.dart` chứa class `AppIcons`.
- Sửa đổi [progression_widget.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/progression_widget.dart) sử dụng `AppIcons.trendingUp` và `AppIcons.trendingDown`.
- Sửa đổi [list.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/list.dart) sử dụng `AppIcons.chevronRight`.

## Architecture
- Không thay đổi hành vi nghiệp vụ, tách biệt phần định nghĩa Icon sang tệp tài nguyên dùng chung của Base App.

## Related Code Files
- [NEW] [app_icons.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/styles/app_icons.dart)
- [MODIFY] [progression_widget.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/progression_widget.dart)
- [MODIFY] [list.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/list.dart)

## Implementation Steps
1. Tạo tệp [app_icons.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/styles/app_icons.dart) và dán nội dung class `AppIcons` do người dùng cung cấp.
2. Cập nhật [progression_widget.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/progression_widget.dart):
   - Bỏ import `lichess_icons.dart` và import `app_icons.dart`.
   - Thay `LichessIcons.arrow_full_upperright` bằng `AppIcons.trendingUp`.
   - Thay `LichessIcons.arrow_full_lowerright` bằng `AppIcons.trendingDown`.
3. Cập nhật [list.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/list.dart):
   - Import `app_icons.dart`.
   - Thay `Icons.chevron_right` bằng `AppIcons.chevronRight`.

## Todo List
- [x] Tạo mới tệp `app_icons.dart`
- [x] Refactor `progression_widget.dart`
- [x] Refactor `list.dart`

## Success Criteria
- Dự án compile thành công.
- Icon mũi tên tăng giảm trong ProgressionWidget hiển thị đúng trên iOS (mũi tên chéo Cupertino) và Android (Material).
- Nút chevron right trong ListSection hiển thị đúng Cupertino chevron trên iOS.

## Risk Assessment
- Không có rủi ro lớn.

## Security Considerations
- Không có.

## Next Steps
- Chuyển sang Phase 2 để thực hiện dọn dẹp tài nguyên tĩnh và các tệp định nghĩa icon cũ.
