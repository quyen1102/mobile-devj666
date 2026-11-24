# Brainstorming Report: Cấu hình Icon hiện tại và định hướng tối ưu hóa

**Date:** 260629
**Time:** 1107
**Task Slug:** current-icon-configuration
**Skill:** brainstorm

## 1. Hiện trạng cấu hình Icon
Qua khảo sát mã nguồn và tệp cấu hình, dự án hiện đang sử dụng 4 nguồn icon chính:

1. **LichessIcons (Custom Icon Font)**:
   - **Tệp định nghĩa**: [lichess_icons.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/styles/lichess_icons.dart) chứa class `LichessIcons` tham chiếu tới font family `'LichessIcons'`.
   - **Tệp cấu hình FlutterIcon**: [fluttericon.json](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/fluttericon.json) chứa cấu hình mapping, SVG path và mã unicode cho các icon từ các nguồn khác nhau.
   - **Hiện trạng vật lý**: Tệp font `assets/fonts/LichessIcons.ttf` đã bị xóa và khai báo font `LichessIcons` đã bị gỡ khỏi [pubspec.yaml](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/pubspec.yaml) ở Phase 1 (để dọn dẹp các thành phần đặc thù của lichess).
   - **Lỗi hiện tại**: Vẫn còn tham chiếu tới `LichessIcons.arrow_full_upperright` và `LichessIcons.arrow_full_lowerright` trong [progression_widget.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/progression_widget.dart). Khi chạy ứng dụng, các icon này sẽ không hiển thị đúng (fallback thành ký tự hệ thống hoặc ô vuông lỗi).

2. **SocialIcons (Custom Icon Font)**:
   - **Tệp định nghĩa**: [social_icons.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/styles/social_icons.dart) chứa các icon `youtube` và `twitch`.
   - **Đăng ký**: Đăng ký trong [pubspec.yaml](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/pubspec.yaml) dưới family `SocialIcons` và tệp vật lý tồn tại tại `assets/fonts/SocialIcons.ttf`.
   - **Hiện trạng sử dụng**: Không còn tệp mã nguồn Dart nào trong thư mục `lib/` thực tế sử dụng các icon của class `SocialIcons`.

3. **Material Symbols / Material Icons**:
   - Sử dụng gói thư viện `material_symbols_icons: ^4.2928.1` và `uses-material-design: true` trong [pubspec.yaml](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/pubspec.yaml).

4. **Cupertino Icons**:
   - Sử dụng gói thư viện `cupertino_icons: ^1.0.9`.

---

## 2. Phân tích vấn đề & Nhu cầu cấu hình lại
Vì đây là một Base App (`nf_base`) đã được dọn dẹp các tính năng cờ vua đặc thù, việc giữ lại cấu hình lỗi của `LichessIcons` là không hợp lý. Cần cấu hình lại hệ thống icon để đảm bảo:
- **Clean Code**: Không chứa các file cấu hình thừa (`fluttericon.json`), file định nghĩa lỗi (`lichess_icons.dart`), font không sử dụng (`SocialIcons`).
- **Compile & Render sạch**: Tất cả các widget hiển thị đúng icon.
- **Tiêu chuẩn hóa (Standardization)**: Sử dụng một bộ icon chung, dễ mở rộng cho dự án mới.

---

## 3. Các giải pháp đề xuất

### Phương án 1: Loại bỏ hoàn toàn Custom Font, chuyển sang dùng bộ icon hệ thống (Khuyên dùng)
Thay thế toàn bộ tham chiếu custom icon (như trong `progression_widget.dart`) bằng các icon từ thư viện `MaterialSymbols` hoặc `CupertinoIcons`. Xóa bỏ các file cấu hình custom font (`fluttericon.json`, `lichess_icons.dart`, `social_icons.dart` và `SocialIcons.ttf`).
- **Ưu điểm**:
  - Đơn giản nhất (KISS), giảm kích thước ứng dụng vì không phải load thêm file `.ttf` tùy chỉnh.
  - Loại bỏ hoàn toàn nợ kỹ thuật (Technical Debt) liên quan đến LichessIcons và SocialIcons.
  - Phù hợp tuyệt đối với tinh thần của Base App.
- **Nhược điểm**: Một số icon có thể không khớp 100% về mặt thiết kế gốc (như mũi tên nghiêng đặc thù của lichess). Tuy nhiên, Material Symbols và Cupertino có các mũi tên nghiêng tương đương (`north_east` / `south_east`).

### Phương án 2: Tạo lại một bộ Custom Font gọn nhẹ đại diện cho Base App (`BaseIcons` / `AppIcons`)
Đổi tên và xây dựng lại tệp font mới chỉ chứa những icon dùng chung (chẳng hạn như 2 icon mũi tên trong `progression_widget.dart` và các icon mạng xã hội nếu cần).
- **Ưu điểm**: Giữ nguyên được thiết kế pixel-perfect của các icon đặc thù.
- **Nhược điểm**: 
  - Over-engineering (YAGNI): Mất công tạo lại font qua các công cụ online như FlutterIcon/Fontello, đăng ký lại trong `pubspec.yaml`.
  - Phức tạp trong việc bảo trì khi muốn thêm/bớt icon mới.

### Phương án 3: Chuyển các icon đặc thù thành tệp SVG độc lập
Thay vì gom nhóm vào font `.ttf`, lưu các icon đặc thù dưới dạng file `.svg` trong thư mục `assets/images/` và hiển thị bằng thư viện `flutter_svg`.
- **Ưu điểm**: Dễ dàng thêm, sửa hoặc xóa riêng lẻ từng icon mà không ảnh hưởng tới toàn bộ ứng dụng hay cần sinh lại font.
- **Nhược điểm**: Yêu cầu tích hợp thêm thư viện hiển thị SVG (nếu chưa có).

---

## 4. Giải pháp đề xuất cuối cùng
Chọn **Phương án 1 (Loại bỏ hoàn toàn Custom Font, chuyển sang dùng bộ icon hệ thống)** vì:
- Phù hợp với nguyên tắc **KISS** và **YAGNI**. Do app hiện tại hầu như không còn dùng custom icon nào ngoài 2 mũi tên xu hướng trong `ProgressionWidget`.
- 2 mũi tên nghiêng `arrow_full_upperright` và `arrow_full_lowerright` có thể thay thế dễ dàng bằng `MaterialSymbols.north_east` và `MaterialSymbols.south_east`.
- Giảm thiểu việc phân mảnh tài nguyên và dung lượng app.

---

## 5. Các bước thực hiện tiếp theo (Next Steps)
1. **Thay thế code**:
   - Trong [progression_widget.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/progression_widget.dart): Thay thế `LichessIcons.arrow_full_upperright` bằng `MaterialSymbols.north_east` (hoặc tương đương) và `LichessIcons.arrow_full_lowerright` bằng `MaterialSymbols.south_east`.
2. **Dọn dẹp mã nguồn**:
   - Xóa file [lichess_icons.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/styles/lichess_icons.dart).
   - Xóa file [social_icons.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/styles/social_icons.dart).
   - Xóa file [fluttericon.json](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/fluttericon.json).
3. **Dọn dẹp tài nguyên tĩnh & cấu hình**:
   - Xóa thư mục `assets/fonts/` (chứa `SocialIcons.ttf`).
   - Mở [pubspec.yaml](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/pubspec.yaml) và xóa phần khai báo font `SocialIcons`.
4. **Kiểm thử & Xác thực**:
   - Chạy `flutter analyze` để đảm bảo không lỗi biên dịch.
   - Kiểm tra hiển thị của `ProgressionWidget` trên UI.
