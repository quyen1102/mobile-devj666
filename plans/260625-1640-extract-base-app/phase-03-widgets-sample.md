# Phase 3: Chuyển đổi iOS Widget Kit thành dạng Sample

## Context Links
- **Cấu hình App Group của Widget**: [LichessAppGroup.swift](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/ios/LichessWidgets/LichessAppGroup.swift)
- **Tập hợp Widgets iOS**: [LichessWidgetsBundle.swift](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/ios/LichessWidgets/LichessWidgetsBundle.swift)
- **Đường dẫn mục tiêu**: `ios/LichessWidgets/`

## Overview
- **Độ ưu tiên**: Trung bình
- **Trạng thái hiện tại**: Chưa bắt đầu
- **Mô tả**: Chuyển đổi phần iOS Widget Extension (`ios/LichessWidgets`) từ các widget cờ vua và tin tức của Lichess thành các widget mẫu chung (Sample Widgets), loại bỏ hoàn toàn các logic đặc thù, giữ lại khung Swift để lập trình viên sau này tham khảo làm widget.

## Key Insights
- Cần đổi tên các tệp tin và các class widget cờ vua của Lichess (như `DailyPuzzleWidget`, `BroadcastWidget`, `CommunityBlogWidget`) thành một widget chung duy nhất: `SampleDataWidget`.
- Giữ nguyên cấu trúc Target trong Xcode (`LichessWidgets`) nhưng chỉnh sửa code Swift bên trong để tránh làm hỏng file cấu hình `.pbxproj`.
- Đồng bộ cơ chế truyền nhận dữ liệu qua App Group bằng cách sử dụng gói `home_widget` ở phía Flutter để ghi dữ liệu, và phía iOS Widget sử dụng `UserDefaults` để đọc.

## Requirements
- Loại bỏ hoàn toàn các thư viện cờ vua của iOS như `ChessgroundAssets` trong Xcode nếu có.
- Viết lại [LichessAppGroup.swift](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/ios/LichessWidgets/LichessAppGroup.swift) thành `AppGroup.swift` dùng chung cho các ứng dụng khác.
- Widget mẫu (`SampleDataWidget`) hiển thị thông tin chung như: Tên đăng nhập (username), thời gian cập nhật cuối cùng (lastUpdatedTime).

## Architecture
- Sử dụng App Group để chia sẻ dữ liệu giữa Flutter và iOS Native Extension:
  ```
  [Flutter App] -> HomeWidget.saveWidgetData('username', value) -> [Shared UserDefaults (App Group)] -> [iOS Widget] Swift reads & renders.
  ```

## Related Code Files
- [MODIFY] [LichessAppGroup.swift](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/ios/LichessWidgets/LichessAppGroup.swift) (Đổi tên & cấu trúc thành mẫu chung)
- [MODIFY] [LichessWidgetsBundle.swift](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/ios/LichessWidgets/LichessWidgetsBundle.swift) (Chỉ khai báo `SampleDataWidget`)
- [NEW] `ios/LichessWidgets/SampleDataWidget.swift` (Widget mẫu hiển thị dữ liệu chung)
- [DELETE] Thư mục `ios/LichessWidgets/Daily Puzzle Widget/`
- [DELETE] Thư mục `ios/LichessWidgets/Broadcasts Widget/`
- [DELETE] Thư mục `ios/LichessWidgets/Blog Feed Widget/`

## Implementation Steps
1. Xóa các thư mục Widget cờ vua và blog của Lichess trong `ios/LichessWidgets/`.
2. Tạo file `ios/LichessWidgets/SampleDataWidget.swift` với:
   - Một `TimelineProvider` cơ bản đọc dữ liệu từ `AppGroup`.
   - Một `SimpleEntry` chứa thông tin `username` và `lastUpdated`.
   - Một SwiftUI View vẽ giao diện thẻ (card) đơn giản với thông báo: "Xin chào [username]" và "Cập nhật lúc: [time]".
3. Cập nhật `LichessAppGroup.swift` thành `AppGroup.swift`:
   - Định nghĩa App Group ID mặc định dạng mẫu: `group.com.example.app.widgets`.
   - Khai báo các key dữ liệu dùng chung như `usernameKey`, `lastUpdatedKey`.
4. Cập nhật [LichessWidgetsBundle.swift](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/ios/LichessWidgets/LichessWidgetsBundle.swift) để chỉ khởi tạo `SampleDataWidget`.
5. Đồng bộ cấu hình ở phía Flutter ([app.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/app.dart)): Cập nhật `home_widget` để gửi dữ liệu dạng mẫu thay vì gửi theme cờ vua.

## Todo List
- [ ] Xóa các folder widget cờ vua
- [ ] Tạo file widget mẫu `SampleDataWidget.swift`
- [ ] Chỉnh sửa `AppGroup.swift` và cấu hình App Group ID giả lập
- [ ] Cập nhật `LichessWidgetsBundle.swift` để đăng ký widget mới
- [ ] Đồng bộ code gửi dữ liệu widget trong `lib/src/app.dart`

## Success Criteria
- Mã nguồn iOS Widget build thành công trong Xcode.
- Swift code sạch, không chứa bất kỳ API Lichess, URL Lichess hay logic cờ thế nào.

## Risk Assessment
- File `.pbxproj` trong Flutter rất dễ bị lỗi nếu ta xóa file Swift thủ công mà không cập nhật Xcode.
- *Biện pháp giảm thiểu*: Chỉ xóa nội dung các file hoặc xóa file thông qua VS Code/Xcode và đảm bảo giữ cấu hình Target nguyên vẹn.

## Security Considerations
- Thay thế App Group ID sang dạng placeholder để đảm bảo nhà phát triển sau này sẽ tạo App Group ID của riêng họ trên Apple Developer Portal.

## Next Steps
- Chuyển sang **Phase 4** để xây dựng tài liệu hướng dẫn cho AI.
