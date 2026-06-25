# Brainstorming: Trích xuất Base App từ Lichess Mobile

## 1. Problem Statement & Requirements
- **Goal**: Trích xuất bộ khung (Base App/Boilerplate) từ dự án `lichess_mobile` để tái sử dụng cho các dự án Flutter khác.
- **Requirements**:
  - Loại bỏ hoàn toàn mã nguồn, tài nguyên và thư viện phụ thuộc liên quan đến cờ vua (Chess, Stockfish, Chessground).
  - Giữ lại cấu hình hạ tầng cốt lõi: Riverpod 3.x + Freezed, i18n (XML -> ARB), Theme (Dynamic Colors, Light/Dark Mode), Sqflite, Secure Storage và Firebase Integration.
  - Đảm bảo app chạy được ngay lập tức sau khi chạy code generator.

## 2. Evaluated Approaches
### Option 1: Starter Template Repository (Fork/Clone & Clean) - **RECOMMENDED & CHOSEN**
- **Pros**:
  - Tạo ra một repo độc lập hoàn toàn, dễ dàng clone/tạo dự án mới qua GitHub Template.
  - Không ảnh hưởng đến dự án gốc `lichess_mobile`.
  - Cấu trúc đơn giản, quen thuộc với mọi Flutter Developer.
- **Cons**:
  - Khi có cập nhật ở core của `lichess_mobile`, phải cập nhật thủ công sang template repo này.
  
### Option 2: Dart Workspace / Monorepo (Melos)
- **Pros**:
  - Giúp quản lý nhiều ứng dụng có chung lõi core trong một kho lưu trữ duy nhất.
  - Chia sẻ mã nguồn dễ dàng, nâng cấp package core sẽ cập nhật cho toàn bộ ứng dụng.
- **Cons**:
  - Cấu hình phức tạp hơn với Melos.
  - Phù hợp khi phát triển hệ sinh thái app cùng một tổ chức, ít tối ưu nếu phát triển các dự án outsource độc lập.

### Option 3: Base Package Extraction
- **Pros**:
  - Đóng gói lõi thành một thư viện dùng chung `app_base` và import qua pubspec.yaml.
- **Cons**:
  - Khó tùy biến giao diện/navigation đặc thù của từng app nếu đóng gói quá chặt.
  - Cấu hình assets và script i18n rất khó đóng gói dạng package.

---

## 3. Final Recommended Solution
**Lựa chọn**: **Option 1: Starter Template Repository (Fork/Clone & Clean)**.
**Lý do**:
- Đáp ứng tối đa tiêu chí "phát triển nhanh ứng dụng khác" của người dùng.
- Giữ lại tính linh hoạt cao nhất cho phần giao diện chính (Tab Scaffold, Navigation) mà không bị bó buộc bởi cấu trúc package cứng nhắc.

---

## 4. Key Infrastructure to Keep vs. Chess Components to Remove
### Keep (Hạ tầng giữ lại)
- **State Management**: Riverpod 3.x + Freezed annotations.
- **Localization System**: Quy trình dịch qua file XML nguồn, tự động biên dịch sang `.arb` và generate code Dart qua script `./scripts/gen-translations.sh`.
- **Database & Storage**:
  - `sqflite` (SQLite) cho local data cache.
  - `flutter_secure_storage` cho lưu trữ token bảo mật.
  - `shared_preferences` cho cài đặt người dùng.
- **Theme & UI**: Hệ thống dynamic system colors (Material 3), dark mode, typography tùy biến dựa trên màn hình.
- **Firebase**: Crashlytics và Cloud Messaging (FCM).
- **App Links**: Deep linking.

### Remove (Thành phần loại bỏ)
- **Dependencies**: `chessground`, `dartchess`, `multistockfish`, `sound_effect` (hoặc giữ lại sfx cơ bản nếu cần).
- **Models & Views liên quan cờ vua**: Xóa bỏ toàn bộ thư mục `lib/src/model/{game, puzzle, analysis, board_editor, tv, clock, explorer...}` và `lib/src/view/{game, puzzle, analysis, board_editor...}`.
- **Assets**: Xóa các file `.db` cờ thế, hình ảnh quân cờ, âm thanh di chuyển quân cờ, và font chữ cờ vua.
- **Native Extension**: Xóa `ios/LichessWidgets/` (iOS Home Screen Widget Kit Extension) vì nó chứa logic hiển thị Daily Puzzle.

---

## 5. Implementation Steps
1. **Copy codebase**: Nhân bản thư mục dự án sang một thư mục base mới.
2. **Purge Chess Assets**:
   - Xóa `assets/chess_openings.db`, `assets/images/stockfish/`, `assets/board-thumbnails/`, `assets/positions.json`, `assets/endgames.json`.
   - Cập nhật `pubspec.yaml` để loại bỏ khai báo assets và fonts cờ vua.
3. **Clean Dependencies**:
   - Xóa các thư viện cờ vua khỏi `pubspec.yaml`.
4. **Purge Code**:
   - Xóa các model và view liên quan cờ vua trong `lib/src/model/` và `lib/src/view/`.
   - Giữ lại `lib/src/model/settings`, `lib/src/model/log`, `lib/src/model/notifications`, `lib/src/model/auth` (chuyển thành cấu trúc Auth mẫu).
5. **Refactor App Entry & Scaffold**:
   - Cập nhật `lib/src/app.dart` và `lib/src/init.dart` để loại bỏ các service cờ vua hoặc Lichess-specific checks.
   - Thiết lập `lib/src/tab_scaffold.dart` với các Tab trống cơ bản (Home, Settings, Account).
6. **Update Localization Scripts**:
   - Điều chỉnh file XML nguồn trong `translation/source/` để chỉ giữ lại các chuỗi cơ bản (Đăng nhập, Cài đặt, Thông báo, Lỗi...).
   - Chạy script `./scripts/gen-translations.sh` để sinh file ngôn ngữ mới.
7. **Test & Validate**:
   - Chạy `flutter pub get` và `dart run build_runner build`.
   - Chạy thử ứng dụng trên Simulator/Emulator để kiểm tra xem base có khởi chạy thành công hay không.

## 6. Success Metrics & Validation
- **Compilation**: Dự án compile thành công mà không có bất kỳ lỗi cú pháp hoặc cảnh báo nghiêm trọng từ `flutter analyze`.
- **Startup**: Ứng dụng khởi động mượt mà vượt qua Splash Screen mà không crash.
- **State & Storage**: Đăng nhập mock/local hoạt động, lưu trữ cấu hình trong Shared Preferences và SQLite hoạt động tốt.
- **Cleanliness**: Không còn bất kỳ file hoặc thư viện nào liên quan tới cờ vua hoặc lichess API trong mã nguồn.

## 7. Next Steps & Risks
- **Risk**: Một số service (như `NotificationService`, `AccountService`) có kết nối chặt chẽ tới Lichess API qua WebSockets.
  - *Mitigation*: Cần rewrite Socket client thành lớp WebSocket chung (Generic WebSocket Client) hoặc tạm thời tắt kết nối WebSocket trong bản base.
- **Next Step**: Tiến hành viết tài liệu hướng dẫn nhanh cho Base App sau khi trích xuất.
