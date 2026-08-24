import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'revup_flutter_plugin_method_channel.dart';
import 'revup_lucky_event_theme.dart';

abstract class RevupFlutterPluginPlatform extends PlatformInterface {
  /// Constructs a RevupFlutterPluginPlatform.
  RevupFlutterPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static RevupFlutterPluginPlatform _instance =
      MethodChannelRevupFlutterPlugin();

  /// The default instance of [RevupFlutterPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelRevupFlutterPlugin].
  static RevupFlutterPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [RevupFlutterPluginPlatform] when
  /// they register themselves.
  static set instance(RevupFlutterPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool?> initialize(
      [String mediaId = "",
      String mediaSecret = "",
      String callbackTag = "",
      String childYN = ""]) {
    throw UnimplementedError('initialize() has not been implemented.');
  }

  Future<bool?> setUserId(String userId) {
    throw UnimplementedError('setUserId() has not been implemented.');
  }

  Future<bool?> setUserIdChild(String userId, int child) {
    throw UnimplementedError('setUserIdChild() has not been implemented.');
  }

  Future<bool?> setRewardedCheckParam(String param) {
    throw UnimplementedError('setRewardedCheckParam() has not been implemented.');
  }

  Future<bool?> isInitialized() {
    throw UnimplementedError('isInitialized() has not been implemented.');
  }

  Future<String?> getSDKVersion() {
    throw UnimplementedError('getSDKVersion() has not been implemented.');
  }

  Future<String?> getNetworkVersions() {
    throw UnimplementedError('getNetworkVersions() has not been implemented.');
  }

  Future<Map?> getUnitStatus(String unitId) {
    throw UnimplementedError('getUnitStatus() has not been implemented.');
  }

  Future<bool?> showMaxMediationDebugger() {
    throw UnimplementedError(
        'showMaxMediationDebugger() has not been implemented.');
  }

  Future<bool?> showAdmobMediationDebugger() {
    throw UnimplementedError(
        'showAdmobMediationDebugger() has not been implemented.');
  }

  Future<bool?> setVolumeOff(bool isOn) {
    throw UnimplementedError('setVolumeOff() has not been implemented.');
  }

  Future<bool?> setShowWithLoad2BackgroundColor(String red, String green, String blue, String alpha) {
    throw UnimplementedError('setShowWithLoad2BackgroundColor() has not been implemented.');
  }

  Future<bool?> setShowWithLoad2IndicatorStyle(bool isMedium, bool isHidden) {
    throw UnimplementedError('setShowWithLoad2IndicatorStyle() has not been implemented.');
  }

  Future<bool?> setShowWithLoad2ErrorAlert(String msg, bool isHidden) {
    throw UnimplementedError('setShowWithLoad2ErrorAlert() has not been implemented.');
  }

  Future<bool?> showLuckyEvent() {
    throw UnimplementedError('showLuckyEvent() has not been implemented.');
  }

  Future<bool?> setLuckyEventAppId(String eventId, String pid) {
    throw UnimplementedError('setLuckyEventAppId() has not been implemented.');
  }

  Future<bool?> setLuckyEventUseSafeAreaWebView(bool useSafeArea) {
    throw UnimplementedError('setLuckyEventUseSafeAreaWebView() has not been implemented.');
  }

  Future<bool?> setLuckyEventEdgeGesture(bool isEdgeGesture) {
    throw UnimplementedError('setLuckyEventEdgeGesture() has not been implemented.');
  }

  Future<bool?> setLuckyEventHashMark(String hashMark) {
    throw UnimplementedError('setLuckyEventHashMark() has not been implemented.');
  }

  Future<bool?> setLuckyEventBaseUrl(String baseUrl) {
    throw UnimplementedError('setLuckyEventBaseUrl() has not been implemented.');
  }

  Future<bool?> setLuckyEventExtraParam(String key, String value) {
    throw UnimplementedError('setLuckyEventExtraParam() has not been implemented.');
  }

  Future<bool?> setLuckyEventTheme(RevupLuckyEventTheme theme) {
    throw UnimplementedError('setLuckyEventTheme() has not been implemented.');
  }

  Future<bool?> rewardedVideoShowWithLoad(String unitId) {
    throw UnimplementedError('rewardedVideoShowWithLoad() has not been implemented.');
  }

  Future<bool?> rewardedVideoLoad(String unitId) {
    throw UnimplementedError('rewardedVideoLoad() has not been implemented.');
  }

  Future<bool?> rewardedVideoIsLoad(String unitId) {
    throw UnimplementedError('rewardedVideoIsLoad() has not been implemented.');
  }

  Future<bool?> rewardedVideoShow() {
    throw UnimplementedError('rewardedVideoShow() has not been implemented.');
  }

  Future<bool?> interstitialShowWithLoad(String unitId) {
    throw UnimplementedError('interstitialShowWithLoad() has not been implemented.');
  }

  Future<bool?> interstitialLoad(String unitId) {
    throw UnimplementedError('interstitialLoad() has not been implemented.');
  }

  Future<bool?> interstitialIsLoad(String unitId) {
    throw UnimplementedError('interstitialIsLoad() has not been implemented.');
  }

  Future<bool?> interstitialShow() {
    throw UnimplementedError('interstitialShow() has not been implemented.');
  }

  Future<Map?> getUnitStatusRewardedInterstitial(String unitId) {
    throw UnimplementedError(
        'getUnitStatusRewardedInterstitial() has not been implemented.');
  }

  Future<bool?> loadRewardedInterstitial(String unitId) {
    throw UnimplementedError(
        'loadRewardedInterstitial() has not been implemented.');
  }

  Future<bool?> preLoadAllRewardedInterstitial() {
    throw UnimplementedError(
        'preLoadAllRewardedInterstitial() has not been implemented.');
  }

  Future<bool?> preLoadRewardedInterstitial(List<String>? unitIds) {
    throw UnimplementedError(
        'preLoadRewardedInterstitial() has not been implemented.');
  }

  Future<bool?> rewardedInterstitialIsLoad(String unitId) {
    throw UnimplementedError(
        'rewardedInterstitialIsLoad() has not been implemented.');
  }

  Future<bool?> showRewardedInterstitial(String unitId) {
    throw UnimplementedError(
        'showRewardedInterstitial() has not been implemented.');
  }

  Future<bool?> showWithPopupRewardedInterstitial(String unitId) {
    throw UnimplementedError(
        'showWithPopupRewardedInterstitial() has not been implemented.');
  }
}
