#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint revup_flutter_plugin.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'revup_flutter_plugin'
  s.version          = '1.0.1'
  s.summary          = 'We provide a plugin so that you can integrate revup while developing with Flutter.'
  s.description      = <<-DESC
Revup SDK for Flutter plugin project.
                       DESC
  s.homepage         = 'https://github.com/revup-tnk/REVUP-Flutter-Plugin'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Revup' => 'revup.ad@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'

  # 플러그인은 코어만 의존한다. 미디에이션 어댑터(REVUP/AdMob, REVUP/Max 등)와
  # REVUP/LuckyEvent는 퍼블리셔가 필요한 것만 자신의 Podfile에 추가한다.
  # (umbrella인 'REVUP'를 그대로 쓰면 default_subspecs로 모든 광고 네트워크 SDK가 딸려온다)
  s.dependency 'REVUP/Core', '1.1.3'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
