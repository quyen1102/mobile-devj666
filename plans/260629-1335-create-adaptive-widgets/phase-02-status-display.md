# Phase 2: Status & Display Widgets

## Context Links
- **Báo cáo brainstorm**: [brainstormer-260629-1139-future-useful-components.md](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/plans/reports/brainstormer-260629-1139-future-useful-components.md)

## Overview
- **Độ ưu tiên**: Cao
- **Trạng thái hiện tại**: Hoàn thành
- **Mô tả**: Thiết lập các widget phản hồi thông tin trạng thái và hiển thị cấu trúc bố cục đồng bộ.

## Requirements
1. **`EmptyStateWidget`**:
   - Hiển thị hình ảnh hoặc icon, tiêu đề, mô tả và nút hành động tùy chọn khi trang/danh sách không có dữ liệu.
2. **`PlatformLoadingOverlay`**:
   - Một widget Stack phủ toàn màn hình chứa spinner thích ứng, dùng để chặn tương tác khi đang xử lý tác vụ ngầm. Trên iOS có sử dụng hiệu ứng Blur Backdrop Filter.
3. **`PlatformCard`**:
   - Thiết kế card bo góc. Trên iOS phẳng nhạt viền mảnh, trên Android đổ bóng Material.
4. **`PlatformAvatar`**:
   - Avatar hình tròn với fallback là chữ cái viết tắt (Initials), hỗ trợ chấm trạng thái hoạt động (online badge).

## Related Code Files
- [NEW] [empty_state_widget.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/empty_state_widget.dart)
- [NEW] [platform_loading_overlay.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/platform_loading_overlay.dart)
- [NEW] [platform_card.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/platform_card.dart)
- [NEW] [platform_avatar.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/platform_avatar.dart)

## Todo List
- [x] Tạo mới tệp `empty_state_widget.dart`
- [x] Tạo mới tệp `platform_loading_overlay.dart`
- [x] Tạo mới tệp `platform_card.dart`
- [x] Tạo mới tệp `platform_avatar.dart`
