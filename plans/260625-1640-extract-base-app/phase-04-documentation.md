# Phase 4: Tạo tài liệu hướng dẫn chi tiết cho AI

## Context Links
- **Thư mục tài liệu hiện tại**: [docs](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/docs)
- **Tài liệu coding style hiện tại**: [coding_style.md](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/docs/coding_style.md)
- **Tài liệu dịch thuật hiện tại**: [internationalisation.md](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/docs/internationalisation.md)

## Overview
- **Độ ưu tiên**: Trung bình - Cao
- **Trạng thái hiện tại**: Chưa bắt đầu
- **Mô tả**: Biên soạn các tài liệu đặc tả cấu trúc của Base App mới, lưu trữ dưới dạng markdown trong `./docs/`. Các tài liệu này được thiết kế tối ưu cho AI (LLMs) đọc và hiểu nhanh nhất cấu trúc của dự án, quy trình làm việc, thiết lập cơ sở dữ liệu, quản lý trạng thái, i18n để phát triển tính năng mới mà không cần lục lọi mã nguồn.

## Key Insights
- LLMs đọc tốt nhất các hướng dẫn ngắn gọn, phân tách rõ ràng theo concerns (Separation of Concerns).
- Tài liệu cần có các đoạn mã mẫu (code snippets) thực tế của Base App để AI copy-paste hoặc cấu trúc theo đúng coding standard của dự án.
- Cần dọn dẹp các tài liệu cũ chỉ dành cho Lichess và viết lại toàn bộ theo giao diện mẫu mới.

## Requirements
- Tạo mới/Cập nhật các tệp tin tài liệu `.md` trong `./docs/`.
- Nội dung phải dễ hiểu cho cả con người và AI.
- Cung cấp hướng dẫn đầy đủ về: Quản lý trạng thái, Đa ngôn ngữ, Database, Theme, iOS Widget.

## Architecture
- Hệ thống tài liệu phân tầng trong thư mục `./docs/`:
  - `docs/project-overview-pdr.md`: Khái quát kiến trúc Base App.
  - `docs/state-management.md`: Riverpod 3.x + Freezed.
  - `docs/internationalisation.md`: Hướng dẫn XML-to-ARB.
  - `docs/theme-styling.md`: Dynamic color theme và thiết kế thích ứng (Responsive design).
  - `docs/database-storage.md`: SQLite & Secure Storage.
  - `docs/ios-widgets.md`: Hướng dẫn iOS WidgetKit & App Groups.

## Related Code Files
- [NEW] `docs/project-overview-pdr.md`
- [NEW] `docs/state-management.md`
- [MODIFY] [internationalisation.md](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/docs/internationalisation.md) (Cập nhật để hướng dẫn theo cấu hình base mới)
- [NEW] `docs/theme-styling.md`
- [NEW] `docs/database-storage.md`
- [NEW] `docs/ios-widgets.md`

## Implementation Steps
1. Biên soạn `docs/project-overview-pdr.md`:
   - Trình bày sơ đồ cấu trúc thư mục `lib/src/`.
   - Các lệnh chạy quan trọng (`flutter pub get`, `build_runner`, `flutter analyze`).
2. Biên soạn `docs/state-management.md`:
   - Hướng dẫn dùng Riverpod 3.x (AsyncNotifier, Notifier, Mutation).
   - Cách tạo Freezed classes và cấu hình build_runner.
3. Cập nhật `docs/internationalisation.md`:
   - Quy trình thêm chuỗi dịch mới vào file XML nguồn trong `translation/source/`.
   - Cách chạy script biên dịch và sử dụng class `AppLocalizations` sinh ra trong Dart.
4. Biên soạn `docs/theme-styling.md`:
   - Cách cấu hình dynamic system color, dark theme.
   - Các utility đo kích thước màn hình và responsive design.
5. Biên soạn `docs/database-storage.md`:
   - Cách viết DB migrations, định nghĩa schema bằng sqflite.
   - Cách đọc/ghi dữ liệu nhạy cảm bằng Secure Storage.
6. Biên soạn `docs/ios-widgets.md`:
   - Cách đăng ký App Group trên Apple Developer Portal và cấu hình trong Xcode.
   - Cách gửi dữ liệu từ Flutter qua `home_widget` và nhận trong SwiftUI Widget.

## Todo List
- [ ] Tạo file `project-overview-pdr.md`
- [ ] Tạo file `state-management.md`
- [ ] Cập nhật file `internationalisation.md`
- [ ] Tạo file `theme-styling.md`
- [ ] Tạo file `database-storage.md`
- [ ] Tạo file `ios-widgets.md`

## Success Criteria
- Tất cả các file tài liệu được tạo thành công trong `./docs/`.
- Các đường dẫn liên kết giữa các tài liệu hoạt động chính xác.

## Risk Assessment
- Tài liệu bị lạc hậu so với code thực tế của base.
- *Biện pháp giảm thiểu*: Viết tài liệu song song hoặc ngay sau khi hoàn thành code của từng phase để đảm bảo độ chính xác 100%.

## Security Considerations
- Nhắc nhở lập trình viên trong tài liệu database về việc không lưu thông tin nhạy cảm ở dạng plaintext trong SQLite, mà phải dùng Secure Storage hoặc mã hóa.

## Next Steps
- Hoàn thành toàn bộ kế hoạch và gửi cho người dùng phê duyệt trước khi chuyển sang giai đoạn thực thi (Execution).
