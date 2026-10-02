#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint revup_flutter_plugin.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'revup_flutter_plugin'
  s.version          = '1.0.5'
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
  # 하드핀(= 1.1.9)이 아니라 범위로 둔다. REVUP 의 각 subspec 은 자기 버전과 같은
  # REVUP/Core (= X) 를 요구하므로, 코어를 한 버전에 못박으면 매체가 LuckyEvent 나
  # 미디에이션 subspec 만 상위 패치로 올릴 때 해석이 실패한다.
  # 하한 1.1.9 = LuckyEvent 테마(setLuckyEventUserInterfaceStyle:) 가 들어간 버전이자
  # 결함이 있는 1.1.1 / 1.1.2 를 배제하는 선. 상한은 1.2.0 미만.
  s.dependency 'REVUP/Core', '~> 1.1.9'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
