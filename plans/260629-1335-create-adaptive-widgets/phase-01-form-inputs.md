# Phase 1: Input & Form Widgets

## Context Links
- **Báo cáo brainstorm**: [brainstormer-260629-1139-future-useful-components.md](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/plans/reports/brainstormer-260629-1139-future-useful-components.md)

## Overview
- **Độ ưu tiên**: Cao
- **Trạng thái hiện tại**: Hoàn thành
- **Mô tả**: Tạo ra các widget nhập liệu thích ứng giúp đồng bộ hóa các form điền thông tin tự nhiên theo hệ điều hành iOS/Android.

## Requirements
1. **`PlatformTextField`**:
   - iOS: Dùng `CupertinoTextField` với padding, placeholderStyle chuẩn Apple. Tự động hỗ trợ nút xóa nhanh (clearButtonMode).
   - Android: Dùng Material `TextField` với decoration.
2. **`PlatformSwitchListTile`**:
   - iOS: Dùng `CupertinoListTile` kết hợp với `CupertinoSwitch` ở phần trailing.
   - Android: Dùng `SwitchListTile` mặc định của Material.
3. **`PlatformDatePicker`**:
   - iOS: Show bottom sheet chứa `CupertinoDatePicker` kiểu Wheel.
   - Android: Show `showDatePicker` Material dialog.

## Related Code Files
- [NEW] [platform_text_field.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/platform_text_field.dart)
- [NEW] [platform_switch_list_tile.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/platform_switch_list_tile.dart)
- [NEW] [platform_date_picker.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/platform_date_picker.dart)

## Todo List
- [x] Tạo mới tệp `platform_text_field.dart` và hiện thực hóa `PlatformTextField`
- [x] Tạo mới tệp `platform_switch_list_tile.dart` và hiện thực hóa `PlatformSwitchListTile`
- [x] Tạo mới tệp `platform_date_picker.dart` và hiện thực hóa `PlatformDatePicker`
