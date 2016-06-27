Pod::Spec.new do |spec|
  spec.name = "QRCodeCapturer"
  spec.version = "1.0.0"
  spec.summary = "Provides preview layer and ability to setup a delegate to obtain scanned text"
  spec.homepage = "https://github.com/yukas/QRCodeCapturer"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "Yuri Kaspervich" => 'ykas.gg@gmail.com' }
  spec.social_media_url = "https://medium.com/@yukas"

  spec.platform = :ios, "9.1"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/yukas/QRCodeCapturer.git", tag: "v#{spec.version}", submodules: true }
  spec.source_files = "QRCodeCapturer/**/*.{h,swift}"
end