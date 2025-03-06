require("dotenv").config();
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const nodemailer = require("nodemailer");

admin.initializeApp();

const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS,
  },
});

exports.sendOtpEmail = functions.https.onRequest(async (req, res) => {
  try {
    console.log("Nhận yêu cầu gửi OTP:", req.body);
    
    const { email } = req.body;
    if (!email) {
      console.error("Lỗi: Không có email trong request.");
      return res.status(400).json({ success: false, message: "Vui lòng nhập email." });
    }

    try {
      await admin.auth().getUserByEmail(email);
    } catch (error) {
      console.error("Email không tồn tại:", error.message);
      return res.status(400).json({ success: false, message: "Email này chưa được đăng ký!" });
    }

    const otp = Math.floor(100000 + Math.random() * 900000).toString();
    console.log("OTP tạo ra:", otp);

    const mailOptions = {
      from: process.env.EMAIL_USER,
      to: email,
      subject: "Ecommerce App OTP Verification",
      text: `Mã OTP của bạn là: ${otp}. Mã này sẽ hết hạn sau 1 phút.`,
    };

    try {
      const info = await transporter.sendMail(mailOptions);
      console.log("Email đã gửi thành công:", info.response);
      return res.status(200).json({ success: true, otp });
    } catch (emailError) {
      console.error("Lỗi khi gửi email:", emailError.message);
      return res.status(500).json({
        success: false,
        message: "Không thể gửi OTP. Vui lòng thử lại sau.",
        error: emailError.message,
      });
    }
  } catch (error) {
    console.error("Lỗi không xác định:", error);
    return res.status(500).json({
      success: false,
      message: "Lỗi máy chủ nội bộ. Vui lòng thử lại sau.",
      error: error.toString(),
    });
  }
});

    