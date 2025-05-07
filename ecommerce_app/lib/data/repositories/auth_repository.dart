import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  // Khởi tạo FireAuth để dùng phương thức (Đăng ký firebase)
  // Đặt là final vì nó không thay đổi giá trị
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Đăng nhập với email và password
  void dangNhap(String email, String password) {

  }
  
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    /* 1. Hàm Future là gì?
      - Hàm future dùng để chạy bất động bộ (async)
      - Khi có 1 function sẽ chạy không đồng nhất với code ví dụ kết hợp với firebase sẽ trả về chậm
      - Thì ta dùng Future (async và hàm thì thêm await) để chạy hàm bất đồng bộ khi mà có kết quả thì nó sẽ trả về sau (tương lai)
    */

    /* 2. Giá trị trả về của Future
      - Thì nó vẫn sẽ trả về giá trị bình thường được đặt ở trong Future<giá_trị_trả_về>
    */

    /* 3. Khi nào biết trả về gì?
      - Cũng như các hàm khác không biết trả về gì cứ để void
      - Khi nào biết trả về cái gì rồi thì sửa lại 
    */

    /* 4. Tại sao hàm này lại dùng Future và trả về giá trị là User
      - Vì ta biết đăng nhập đang cần lưu vào Firebase nên sẽ có hàm riêng để kết hợp firebase 
      => Bất đồng bộ chỗ hàm Firebase => Dùng hàm Future + async + await

      - User ở đây không phải là model User chúng ta tự viết mà làm User của Firebase nó chứa các thông tin người dùng như email và password

    */

    // signInWithEmailAndPassword(email, password) là hàm có sẵn của firebase_auth (đọc pdf)
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  // Đăng ký
  Future<User?> signUp({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  Future<bool> checkAccountExists(String email) async {
    final methods = await _auth.fetchSignInMethodsForEmail(email);
    return methods.isNotEmpty;
  }
}
