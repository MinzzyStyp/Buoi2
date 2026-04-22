# Máy Tính Nâng Cao (Advanced Calculator) - Lab 3

Bài tập thực hành môn Lập trình ứng dụng di động.

## Thông tin sinh viên
* **Họ và tên:** Trần Văn Luân
* **MSSV:** 2224802010585

## Các tính năng nổi bật
* **Chế độ kép:** Hỗ trợ 2 giao diện máy tính **Basic** (Cơ bản 4 cột) và **Scientific** (Khoa học 6 cột).
* **Giao diện linh hoạt:** Tích hợp tính năng chuyển đổi giao diện **Sáng/Tối (Light/Dark Mode)** mượt mà.
* **Lưu trữ lịch sử:** Tự động lưu lại các phép tính đã thực hiện. Dữ liệu được lưu trữ vĩnh viễn bằng `shared_preferences` (không bị mất khi tắt app). Có tính năng xóa sạch lịch sử khi nhấn giữ nút C.
* **Toán học nâng cao:** Xử lý chính xác các phép toán phức tạp (lượng giác, logarit, lũy thừa, số pi, phần trăm...) áp dụng chuẩn quy tắc toán học nhờ thư viện `math_expressions`.
* **Basic**
<img width="476" height="1032" alt="image" src="https://github.com/user-attachments/assets/a9cf2090-57ed-4435-afcf-1b6dd11605fb" />
**Scientific**
  <img width="483" height="1011" alt="image" src="https://github.com/user-attachments/assets/c53d51ef-0fb1-419e-9716-c6536378e8bf" />
## Công nghệ và Thư viện sử dụng
* **Framework:** Flutter / Dart
* **Quản lý trạng thái (State Management):** `provider`
* **Lưu trữ dữ liệu (Local Storage):** `shared_preferences`
* **Xử lý biểu thức:** `math_expressions`
