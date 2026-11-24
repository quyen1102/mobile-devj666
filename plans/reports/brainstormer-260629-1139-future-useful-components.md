# Brainstorming Report: Đề xuất các Component hữu ích cho Base App (nf_base) trong tương lai

**Date:** 260629
**Time:** 1139
**Task Slug:** future-useful-components
**Skill:** brainstorm

## 1. Phân tích hiện trạng các Component dùng chung
Hiện tại thư mục `lib/src/widgets/` chứa khá nhiều widget cơ bản và một số widget thích ứng (adaptive/platform-aware):
- **Đã tốt**: Đã có `PlatformScaffold`, `PlatformAppBar`, `PlatformWidget`, `PlatformShareIcon` trong `platform.dart`; các dialog thích ứng (`PlatformAlertDialog`, `YesNoDialog`); các widget danh sách (`ListSection`, `PlatformDivider`); bottom sheet/action sheet thích ứng.
- **Điểm yếu**: Còn thiếu các widget nhập liệu thích ứng (forms/fields), các widget hiển thị trạng thái (empty, loading overlay), các widget điều hướng phụ (expansion tile, chips) và hệ thống thông báo nhanh (toasts) đồng bộ.

---

## 2. Đề xuất các Component hữu ích trong tương lai

Dưới đây là các nhóm component chung cực kỳ thiết yếu cho bất kỳ ứng dụng di động dạng tab-based nào được phát triển từ `nf_base`.

### Nhóm 1: Nhập liệu Thích ứng (Adaptive Form Elements)
1. **`PlatformTextField`**:
   - *Mục tiêu*: Thay thế việc sử dụng `TextField` thuần của Material trên iOS.
   - *Thiết kế iOS*: Sử dụng `CupertinoTextField` có bo góc mịn, nền xám nhạt, placeholder mờ và nút "clear" tích hợp bên phải.
   - *Thiết kế Android*: Sử dụng `TextField` có `InputDecoration` mặc định của Material 3 (underline hoặc outlined border).
2. **`PlatformSwitchListTile` / `PlatformCheckbox`**:
   - *Mục tiêu*: Thích ứng hóa các nút bật/tắt cài đặt.
   - *Triển khai*: Sử dụng `CupertinoSwitch` trên iOS và `Switch` của Material trên Android.
3. **`PlatformDatePicker`**:
   - *Mục tiêu*: Chọn ngày giờ thích ứng.
   - *iOS*: Hiển thị một Cupertino bottom sheet chứa `CupertinoDatePicker` dạng cuộn vòng quay.
   - *Android*: Gọi hàm `showDatePicker` dạng hộp thoại lịch của Material.

---

### Nhóm 2: Trạng thái & Phản hồi (State & Feedback Widgets)
4. **`EmptyStateWidget`**:
   - *Mục tiêu*: Hiển thị khi danh sách trống, lỗi kết nối mạng, hoặc tìm kiếm không ra kết quả.
   - *Cấu trúc*: Nhận vào `icon` (hoặc ảnh minh họa), `title`, `description`, và một widget `actionButton` tùy chọn.
   - *Lợi ích*: Tránh việc mỗi màn hình tự vẽ một giao diện trống khác nhau, đảm bảo tính nhất quán (Consistency).
5. **`PlatformLoadingOverlay`**:
   - *Mục tiêu*: Chặn tương tác của người dùng và hiển thị spinner khi đang gọi API/xử lý nghiệp vụ ngầm (ví dụ: đang đăng nhập, đang thanh toán).
   - *Triển khai*: Một widget dạng Stack phủ mờ nền (Blur backdrop filter trên iOS) với spinner thích ứng (`CircularProgressIndicator.adaptive`).
6. **`AppToast` / `FeedbackBanner`**:
   - *Mục tiêu*: Hiển thị các thông báo nhanh (Success, Error, Warning) trượt xuống từ trên đỉnh màn hình hoặc nổi ở đáy.
   - *Triển khai*: Sử dụng thư viện overlay hoặc animate trực tiếp để tạo toast mượt mà, hỗ trợ giao diện tối/sáng và micro-animations.

---

### Nhóm 3: Cấu trúc & Hiển thị thông tin (Layout & Display)
7. **`PlatformCard`**:
   - *Mục tiêu*: Hộp chứa thông tin có bo góc và đổ bóng nhẹ.
   - *iOS*: Phẳng (flat), nền nhạt, có border cực mảnh.
   - *Android*: Đổ bóng (elevation) và bo góc theo Material 3.
8. **`PlatformExpansionTile`**:
   - *Mục tiêu*: Accordion list tile có khả năng mở rộng/thu gọn.
   - *Triển khai*: Thích ứng nút mũi tên xoay và hiệu ứng mở rộng mượt mà.
9. **`PlatformAvatar`**:
   - *Mục tiêu*: Hiển thị avatar người dùng tròn.
   - *Tính năng*: Hỗ trợ ảnh từ mạng (`NetworkImage`), ảnh offline, hiển thị chữ cái đầu (Initials) khi ảnh lỗi, và chấm trạng thái online/offline (Badge).
10. **`PlatformChip` / `FilterChip`**:
    - *Mục tiêu*: Các nhãn (tags) có thể nhấn để lọc danh sách hoặc chọn danh mục.

---

## 3. Đánh giá khả thi & Tiếp cận thực hiện (Implementation Strategy)
- **KISS & YAGNI**: Không nên tạo sẵn tất cả các component này ngay lập tức nếu chưa có màn hình cụ thể nào dùng đến chúng. Thay vào đó, hãy lưu tài liệu này lại làm cẩm nang hướng dẫn.
- **Tập trung tạo trước**: Các widget nhập liệu (`PlatformTextField`) và widget trạng thái (`EmptyStateWidget`) là những thứ xuất hiện trong 99% các màn hình biểu mẫu và danh sách, nên được ưu tiên triển khai trước.
- **Tiêu chuẩn thiết kế**:
  - Luôn tận dụng màu sắc từ theme context (`Theme.of(context).colorScheme`) thay vì hardcode.
  - Sử dụng [AppIcons](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/styles/app_icons.dart) đã cấu hình để đồng bộ các icon điều hướng (như chevron_down, clear, check, v.v.).
