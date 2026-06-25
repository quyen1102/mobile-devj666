# Phase 2: Dọn dẹp mã nguồn cờ vua & Tái cấu trúc Core

## Context Links
- **Tệp khởi chạy chính**: [main.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/main.dart)
- **Tệp ứng dụng chính**: [app.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/app.dart)
- **Tệp cấu hình khởi tạo**: [init.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/init.dart)
- **Hộp dựng giao diện chính**: [tab_scaffold.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/tab_scaffold.dart)
- **Báo cáo dò tìm (Scout)**: [scout-260625-1640-extract-base-app.md](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/plans/reports/scout-260625-1640-extract-base-app.md)

## Overview
- **Độ ưu tiên**: Cao
- **Trạng thái hiện tại**: Đang thực hiện
- **Mô tả**: Xóa bỏ các file và folder liên quan cờ vua không sử dụng, giải quyết các import bị lỗi, thay thế các service đặc thù của Lichess bằng bản giả lập/phương thức rỗng chung để ứng dụng có thể biên dịch sạch sẽ.

## Key Insights
- **Thư viện sinh mã**: Riverpod & Freezed sẽ báo lỗi nếu còn bất cứ file nào không biên dịch được. Phải dọn dẹp triệt để các file chứa import lỗi (`dartchess`, `chessground`, các model cờ cũ) trước khi chạy thành công `build_runner`.
- **Dịch vụ âm thanh và phản hồi**: `move_feedback.dart` sẽ bị xóa hoàn toàn. `sound_service.dart` sẽ được viết lại thành dạng mock/empty player để loại bỏ package `sound_effect` đã gỡ khỏi `pubspec.yaml`.
- **Dịch vụ liên kết ngoài (App Links & Quick Actions)**: `quick_actions.dart` và `app_links_service.dart` chứa nhiều luồng xử lý cờ vua (seeks, puzzle, analysis). Sẽ được tái cấu trúc thành các bộ khung cấu hình rỗng chung để lập trình viên sau này cấu hình theo nghiệp vụ mới.
- **Preferences**: Xóa tệp `board_preferences.dart` và cấu hình liên quan trong `app.dart` cùng với `theme.dart`.

## Requirements
- Xóa bỏ hoàn toàn mã nguồn cờ vua.
- Sửa đổi các file bị lỗi import để đảm bảo không còn lỗi phân tích tĩnh.
- Biên dịch dự án Flutter thành công sau khi chạy `dart run build_runner build`.

## Architecture
- Tinh giản kiến trúc ứng dụng thành một Base App gọn nhẹ:
  ```
  App Startup (main.dart) -> AppInitScreen (init.dart) -> Application (app.dart) -> MainTabScaffold (tab_scaffold.dart)
  ```
- Dịch vụ nền tảng dùng chung (Shared Services):
  - `AppLogService`: Ghi log.
  - `NotificationService`: Nhận thông báo Firebase/Local (Mock token post).
  - `AppLinksService`: Phân tích deep link (Khung mẫu).
  - `SoundService`: Phát âm thanh mẫu (Mock rỗng).

## Related Code Files
- [DELETE] `lib/src/model/chat/` (Dịch vụ chat game cờ vua)
- [DELETE] `lib/src/model/common/service/move_feedback.dart` (Phản hồi rung/âm thanh khi đi quân cờ)
- [DELETE] `lib/src/shared_pgn_service.dart` (Nhập PGN cờ vua từ nguồn ngoài)
- [DELETE] `lib/src/widgets/material_diff.dart` (Widget so sánh quân cờ)
- [DELETE] `lib/src/widgets/side_indicator.dart` (Widget hiển thị bên đi cờ)
- [DELETE] `lib/src/model/settings/board_preferences.dart` (Cấu hình bàn cờ & quân cờ)
- [MODIFY] [app.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/app.dart) (Gỡ bỏ code cờ và board preferences)
- [MODIFY] [theme.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/theme.dart) (Loại bỏ board preferences và board theme seed)
- [MODIFY] [init.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/init.dart) (Không tải pieces/images)
- [MODIFY] [tab_scaffold.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/tab_scaffold.dart) (Sửa tab rỗng)
- [MODIFY] `lib/src/quick_actions.dart` (Mock các shortcut)
- [MODIFY] `lib/src/app_links_service.dart` (Khung deeplink rỗng)
- [MODIFY] `lib/src/model/common/service/sound_service.dart` (Mock rỗng, bỏ sound_effect plugin)
- [MODIFY] `lib/src/widgets/misc.dart` (Bỏ LichessMessage và AppBarLichessTitle)
- [MODIFY] `lib/src/view/message/conversation_screen.dart` (Bỏ ChatBubbleContextMenu)

## Implementation Steps
1. Xóa các tệp tin và folder mồ côi đã liệt kê trong phần `Related Code Files`.
2. Viết lại `sound_service.dart` để chỉ khai báo các phương thức rỗng của `SoundService`, gỡ bỏ import `package:sound_effect/sound_effect.dart` và `lichess_mobile/src/model/common/chess.dart`.
3. Cập nhật `conversation_screen.dart`: Loại bỏ import `chat_context_menu.dart`, thay thế `ChatBubbleContextMenu` bằng `GestureDetector` có tính năng sao chép tin nhắn vào Clipboard (`Clipboard.setData`).
4. Cập nhật `quick_actions.dart`: Sửa `QuickActionService` để khởi tạo các shortcut mẫu chung (ví dụ: "Mở ứng dụng") thay vì các shortcut tìm trận đấu hay giải đố cờ vua.
5. Cập nhật `app_links_service.dart`: Chuyển đổi phương thức `resolveAppLinkUri` và `handleAppLink` thành khung xương mẫu nhận diện URL chung mà không gọi tới các màn hình cờ vua.
6. Cấu hình lại `app.dart`:
   - Gỡ bỏ import các service cờ.
   - Xóa `_screenSizeBasedInitialization` gọi tới analysis/study/broadcast preferences.
   - Xóa lắng nghe và đồng bộ dữ liệu `boardPreferencesProvider` và `correspondenceServiceProvider`.
   - Cập nhật hàm gọi `makeAppTheme` để không truyền biến `boardPrefs`.
7. Cấu hình lại `theme.dart`: Thay thế logic của `makeAppTheme` để không phụ thuộc vào `boardPreferencesProvider`, gỡ bỏ `lichessCustomColors` nếu không cần hoặc giữ lại cấu hình màu mặc định.
8. Chạy `dart run build_runner build --delete-conflicting-outputs` để tái sinh các file model và cấu hình Riverpod.
9. Thực hiện `flutter analyze lib/` để kiểm tra lỗi tĩnh cho toàn bộ mã nguồn Dart.

## Todo List
- [ ] Xóa bỏ các tệp tin cờ mồ côi (`material_diff.dart`, `side_indicator.dart`, `move_feedback.dart`, `shared_pgn_service.dart`, `chat/`)
- [ ] Refactor `sound_service.dart` thành mock service
- [ ] Refactor `conversation_screen.dart` để bỏ ChatBubbleContextMenu
- [ ] Refactor `quick_actions.dart` thành template mẫu chung
- [ ] Refactor `app_links_service.dart` để bỏ logic điều phối cờ vua
- [ ] Cập nhật `app.dart` loại bỏ references cờ vua
- [ ] Cập nhật `theme.dart` loại bỏ board preferences
- [ ] Chạy code generation bằng `build_runner`
- [ ] Kiểm tra phân tích tĩnh dự án bằng `flutter analyze lib/`

## Success Criteria
- Mã nguồn Dart biên dịch thành công, không còn lỗi import/syntax trong thư mục `lib/`.
- Phân tích tĩnh của Flutter báo cáo dự án sạch sẽ không lỗi.
- Code sinh ra bởi `build_runner` hoàn thành 100% không có lỗi xung đột.
