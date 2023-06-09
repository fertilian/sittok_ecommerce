import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: HelpCenter(),
));

class HelpCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Help Center',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Text(
          'Selamat datang di Help Center kami.'
              'Kami di sini untuk membantu Anda menemukan solusi dan jawaban atas pertanyaan dan masalah yang Anda hadapi'
          'Help Center kami dirancang untuk memberikan panduan yang jelas dan mendalam mengenai produk dan layanan kami.'
          'Silakan temukan jawaban yang Anda cari dengan menjelajahi berbagai topik yang tersedia.'
              'Jika Anda tidak menemukan jawaban yang Anda cari di Help Center kami, jangan ragu untuk menghubungi tim dukungan kami. Anda dapat menghubungi kami melalui [0897654321] atau melalui formulir kontak yang tersedia di Help Center.',
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 1.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
