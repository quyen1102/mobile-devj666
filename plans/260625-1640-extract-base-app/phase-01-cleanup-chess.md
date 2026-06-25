# Phase 1: Dọn dẹp tài nguyên và phụ thuộc cờ vua

## Context Links
- **Báo cáo brainstorm**: [brainstormer-260625-1638-extract-base-app.md](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/plans/reports/brainstormer-260625-1638-extract-base-app.md)
- **Tệp cấu hình**: [pubspec.yaml](file:///Users/devj666/Documents/WorkPlace/Personal/pubspec.yaml)

## Overview
- **Độ ưu tiên**: Cao
- **Trạng thái hiện tại**: Hoàn thành
- **Mô tả**: Loại bỏ các thư viện cờ vua khỏi `pubspec.yaml` và xóa các file tài nguyên cờ vua trong thư mục `assets/` để giảm kích thước ứng dụng và loại bỏ sự phụ thuộc không cần thiết.

## Key Insights
- Việc xóa các thư viện như `chessground` và `dartchess` sẽ gây ra lỗi biên dịch tức thời trong phần mã nguồn Dart. Ta cần xóa dependencies và assets trước, sau đó giải quyết lỗi biên dịch ở Phase 2.
- Giữ lại cấu hình i18n (`intl`, `l10n_esperanto` hoặc cấu hình sinh ngôn ngữ tự động) vì đây là thành phần cốt lõi của hệ thống đa ngôn ngữ.

## Requirements
- Loại bỏ hoàn toàn các dependencies liên quan đến cờ vua khỏi `pubspec.yaml`.
- Xóa các assets cờ vua bao gồm hình ảnh quân cờ, cơ sở dữ liệu khai cuộc, tệp JSON cờ thế và font chữ cờ.

## Architecture
- Không ảnh hưởng cấu trúc hệ thống, giảm tải tài nguyên tĩnh (Assets) giúp ứng dụng nhẹ hơn.

## Related Code Files
- [MODIFY] [pubspec.yaml](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/pubspec.yaml)
- [DELETE] `assets/chess_openings.db`
- [DELETE] `assets/positions.json`
- [DELETE] `assets/endgames.json`
- [DELETE] `assets/fonts/ChessSansPiratf.ttf`
- [DELETE] `assets/fonts/PuzzleIcons.ttf`
- [DELETE] `assets/fonts/LichessIcons.ttf`
- [DELETE] `assets/images/stockfish/`
- [DELETE] `assets/board-thumbnails/`

## Implementation Steps
1. Mở [pubspec.yaml](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/pubspec.yaml) và xóa các dòng sau:
   - `chessground`
   - `dartchess`
   - `multistockfish`
   - `sound_effect` (hoặc giữ lại nếu cần dùng sfx chung)
2. Cập nhật phần `flutter -> assets` và `flutter -> fonts` trong [pubspec.yaml](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/pubspec.yaml) để xóa các khai báo liên quan đến cờ vua.
3. Thực hiện xóa các file tài nguyên vật lý trong thư mục `assets/` như danh sách file liên quan.
4. Chạy lệnh `flutter pub get` để cập nhật lại cấu hình dependencies.

## Todo List
- [x] Cập nhật dependencies trong `pubspec.yaml`
- [x] Gỡ bỏ khai báo assets cờ vua trong `pubspec.yaml`
- [x] Xóa vật lý các file assets cờ vua trong thư mục `assets/`
- [x] Chạy `flutter pub get` kiểm tra tải dependencies thành công

## Success Criteria
- Lệnh `flutter pub get` chạy thành công mà không báo lỗi thiếu thư viện hoặc xung đột phiên bản.
- Kích thước thư mục `assets/` giảm đáng kể và không còn chứa tài nguyên cờ vua.

## Risk Assessment
- Xóa assets khi code vẫn còn gọi tới sẽ gây lỗi compile hoặc crash khi runtime.
- *Biện pháp giảm thiểu*: Sẽ dọn dẹp toàn bộ tham chiếu code tại Phase 2 ngay sau đó.

## Security Considerations
- Không có.

## Next Steps
- Chuyển sang **Phase 2** để dọn dẹp mã nguồn Dart bị lỗi biên dịch sau khi gỡ bỏ dependencies.
