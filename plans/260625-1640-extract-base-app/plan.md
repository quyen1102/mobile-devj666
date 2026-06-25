---
title: "Trích xuất Base App từ Lichess Mobile"
description: "Tạo Starter Template từ dự án Lichess Mobile bằng cách loại bỏ các thành phần cờ vua, giữ lại lõi hạ tầng, cấu hình iOS Widget thành mẫu chung và viết tài liệu hướng dẫn cho AI."
status: "completed"
priority: "high"
effort: "medium"
branch: "feature/extract-base-app"
tags: ["starter-template", "cleanup", "refactoring", "base-app"]
created: "2026-06-25"
---

# Kế hoạch trích xuất Base App

Dự án này nhằm trích xuất một Starter Template sạch từ codebase `lichess_mobile` để làm cơ sở phát triển nhanh cho các ứng dụng Flutter khác.

## Các giai đoạn triển khai (Phases)

1. **[Phase 1: Dọn dẹp tài nguyên và phụ thuộc cờ vua](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/plans/260625-1640-extract-base-app/phase-01-cleanup-chess.md)** - *Hoàn thành*
   - Gỡ bỏ dependencies cờ vua trong `pubspec.yaml`.
   - Xóa bỏ tài nguyên hình ảnh quân cờ, font chữ cờ, cơ sở dữ liệu cờ trong `assets/`.
2. **[Phase 2: Dọn dẹp mã nguồn cờ vua & Tái cấu trúc Core](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/plans/260625-1640-extract-base-app/phase-02-refactor-core.md)** - *Hoàn thành*
   - Xóa các module chess-specific trong `lib/src/model/` và `lib/src/view/`.
   - Cấu hình lại `app.dart`, `init.dart`, `quick_actions.dart`, `app_links_service.dart`, và `tab_scaffold.dart` làm giao diện mẫu.
   - Giải quyết toàn bộ 45 lỗi static analysis và compile.
3. **[Phase 3: Chuyển đổi iOS Widget Kit thành dạng Sample](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/plans/260625-1640-extract-base-app/phase-03-widgets-sample.md)** - *Hoàn thành*
   - Giữ lại code Swift của WidgetKit nhưng chuyển đổi sang dạng Sample Widget đọc dữ liệu chung từ UserDefaults.
   - Kết nối `AccountService` của Flutter để tự động đồng bộ hóa thông tin user và last updated timestamp thông qua App Group.
4. **[Phase 4: Tạo tài liệu hướng dẫn chi tiết cho AI](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/plans/260625-1640-extract-base-app/phase-04-documentation.md)** - *Hoàn thành*
   - Tạo các tài liệu hướng dẫn trong thư mục `./docs/` để AI đọc hiểu nhanh cấu trúc core (`theme-styling.md`, `database-storage.md`, `ios-widgets.md`, `state-management.md`, `project-overview-pdr.md`, `internationalisation.md`).

## Ràng buộc & Dependencies
- Code đã biên dịch hoàn toàn sạch sẽ (`flutter analyze` trả về 0 errors).
- Code sinh ra bởi `build_runner` hoàn thành 100% không gặp lỗi xung đột.
- Tham chiếu: **[Scout Report](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/plans/reports/scout-260625-1640-extract-base-app.md)**.
