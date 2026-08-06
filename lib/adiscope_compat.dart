/// Adiscope 호환 레이어.
///
/// 기존 `adiscope_flutter_plugin`을 사용 중인 퍼블리셔가 앱 코드를 수정하지 않고
/// Revup SDK로 전환할 수 있도록, 예전 이름(`AdiscopeFlutterPlugin`, `AdiscopeListener`)
/// 그대로 API를 제공합니다. 내부 동작은 전부 [RevupFlutterPlugin] / [RevupListener]로 위임됩니다.
///
/// 사용법 — pubspec 의존성을 `revup_flutter_plugin`으로 바꾸고 import만 아래로 변경하면 됩니다.
/// ```dart
/// // 변경 전
/// import 'package:adiscope_flutter_plugin/adiscope_flutter_plugin.dart';
/// // 변경 후
/// import 'package:revup_flutter_plugin/adiscope_compat.dart';
/// ```
///
/// 신규 개발에는 이 파일 대신 `package:revup_flutter_plugin/revup_flutter_plugin.dart`를
/// 사용하세요. 이 레이어는 마이그레이션 편의를 위해서만 유지됩니다.
///
/// **주의:** Revup SDK는 Offerwall(오퍼월)을 제공하지 않으므로
/// `showOfferwall`, `showOfferwallDetail`, `showOfferwallDetailFromUrl`,
/// `setupOfferwallListener`는 제공되지 않습니다.
library adiscope_compat;

import 'package:flutter/services.dart';

import 'revup_flutter_plugin.dart';

/// [RevupFlutterPlugin]의 Adiscope 호환 이름.
class AdiscopeFlutterPlugin {
  final RevupFlutterPlugin _plugin = RevupFlutterPlugin();

  /// Initialize adiscope with [mediaid, mediasecret, callbackTag, childYN].
  Future<bool?> initialize(
      [String mediaId = "",
      String mediaSecret = "",
      String callbackTag = "",
      String childYN = ""]) {
    return _plugin.initialize(mediaId, mediaSecret, callbackTag, childYN);
  }

  /// User information settings
  Future<bool?> setUserId(String userId) {
    return _plugin.setUserId(userId);
  }

  /// User, Child information settings
  Future<bool?> setUserIdChild(String userId, int child) {
    return _plugin.setUserIdChild(userId, child);
  }

  /// Add Rewarded Callback
  Future<bool?> setRewardedCheckParam(String param) {
    return _plugin.setRewardedCheckParam(param);
  }

  /// Check initialize
  Future<bool?> isInitialized() {
    return _plugin.isInitialized();
  }

  /// Check sdk version
  Future<String?> getSDKVersion() {
    return _plugin.getSDKVersion();
  }

  /// Check the versions of third-party networks
  Future<String?> getNetworkVersions() {
    return _plugin.getNetworkVersions();
  }

  /// Check unit status of rewardedvideo with [unitId]
  Future<Map?> getUnitStatus(String unitId) {
    return _plugin.getUnitStatus(unitId);
  }

  /// Max Mediation Debugger
  Future<bool?> showMaxMediationDebugger() {
    return _plugin.showMaxMediationDebugger();
  }

  /// Admob Mediation Debugger
  Future<bool?> showAdmobMediationDebugger() {
    return _plugin.showAdmobMediationDebugger();
  }

  /// Adjust advertising sound with [isOn]
  Future<bool?> setVolumeOff(bool isOn) {
    return _plugin.setVolumeOff(isOn);
  }

  Future<bool?> setShowWithLoad2BackgroundColor(
      String red, String green, String blue, String alpha) {
    return _plugin.setShowWithLoad2BackgroundColor(red, green, blue, alpha);
  }

  Future<bool?> setShowWithLoad2IndicatorStyle(bool isMedium, bool isHidden) {
    return _plugin.setShowWithLoad2IndicatorStyle(isMedium, isHidden);
  }

  Future<bool?> setShowWithLoad2ErrorAlert(String msg, bool isHidden) {
    return _plugin.setShowWithLoad2ErrorAlert(msg, isHidden);
  }

  /// Show Lucky Event.
  Future<bool?> showLuckyEvent() {
    return _plugin.showLuckyEvent();
  }

  /// Set Lucky Event of Event AppId & PubId.
  Future<bool?> setLuckyEventAppId(String eventId, String pid) {
    return _plugin.setLuckyEventAppId(eventId, pid);
  }

  /// Set Lucky Event of SafeArea.
  Future<bool?> setLuckyEventUseSafeAreaWebView(bool useSafeArea) {
    return _plugin.setLuckyEventUseSafeAreaWebView(useSafeArea);
  }

  /// Set Lucky Event of HashMark.
  Future<bool?> setLuckyEventHashMark(String hashMark) {
    return _plugin.setLuckyEventHashMark(hashMark);
  }

  /// Set Lucky Event of BaseUrl.
  Future<bool?> setLuckyEventBaseUrl(String baseUrl) {
    return _plugin.setLuckyEventBaseUrl(baseUrl);
  }

  /// Set Lucky Event of ExtraParam.
  Future<bool?> setLuckyEventExtraParam(String key, String value) {
    return _plugin.setLuckyEventExtraParam(key, value);
  }

  /// Show With Load rewardedVideo of [unitId] value.
  Future<bool?> rewardedVideoShowWithLoad(String unitId) {
    return _plugin.rewardedVideoShowWithLoad(unitId);
  }

  /// Load rewardedVideo of [unitId] value.
  Future<bool?> rewardedVideoLoad(String unitId) {
    return _plugin.rewardedVideoLoad(unitId);
  }

  /// Check the Load status of the rewardedVideo of the [unitId] value.
  Future<bool?> rewardedVideoIsLoad(String unitId) {
    return _plugin.rewardedVideoIsLoad(unitId);
  }

  /// Show rewardedVideo.
  Future<bool?> rewardedVideoShow() {
    return _plugin.rewardedVideoShow();
  }

  /// Show With Load interstitial of [unitId] value.
  Future<bool?> interstitialShowWithLoad(String unitId) {
    return _plugin.interstitialShowWithLoad(unitId);
  }

  /// Load interstitial of [unitId] value.
  Future<bool?> interstitialLoad(String unitId) {
    return _plugin.interstitialLoad(unitId);
  }

  /// Check the Load status of the interstitial of the [unitId] value.
  Future<bool?> interstitialIsLoad(String unitId) {
    return _plugin.interstitialIsLoad(unitId);
  }

  /// Show interstitial.
  Future<bool?> interstitialShow() {
    return _plugin.interstitialShow();
  }

  /// Check unit status of RewardedInterstitial with [unitId]
  Future<Map?> getUnitStatusRewardedInterstitial(String unitId) {
    return _plugin.getUnitStatusRewardedInterstitial(unitId);
  }

  /// Loads RewardedInterstitial of [unitId] value.
  Future<bool?> loadRewardedInterstitial(String unitId) {
    return _plugin.loadRewardedInterstitial(unitId);
  }

  /// Loads all units of RewardedInterstitial.
  Future<bool?> preLoadAllRewardedInterstitial() {
    return _plugin.preLoadAllRewardedInterstitial();
  }

  /// Loads the [unitIds] values of RewardedInterstitial.
  Future<bool?> preLoadRewardedInterstitial(List<String>? unitIds) {
    return _plugin.preLoadRewardedInterstitial(unitIds);
  }

  /// Check the Load status of the RewardedInterstitial of the [unitId] value.
  Future<bool?> rewardedInterstitialIsLoad(String unitId) {
    return _plugin.rewardedInterstitialIsLoad(unitId);
  }

  /// Show immediately RewardedInterstitial of [unitId] value. (without popup)
  Future<bool?> showRewardedInterstitial(String unitId) {
    return _plugin.showRewardedInterstitial(unitId);
  }

  /// Show RewardedInterstitial of [unitId] value. (with popup)
  Future<bool?> showWithPopupRewardedInterstitial(String unitId) {
    return _plugin.showWithPopupRewardedInterstitial(unitId);
  }
}

/// [RevupListener]의 Adiscope 호환 이름.
class AdiscopeListener {
  /// Register listener channel of luckyEvent
  static MethodChannel get listenerLuckyEventChannel =>
      RevupListener.listenerLuckyEventChannel;

  /// Register listener channel of rewardedVideo
  static MethodChannel get listenerRewardedVideoChannel =>
      RevupListener.listenerRewardedVideoChannel;

  /// Register listener channel of interstitial
  static MethodChannel get listenerInterstitialChannel =>
      RevupListener.listenerInterstitialChannel;

  /// Register listener channel of rewardedInterstitial
  static MethodChannel get listenerRewardedInterstitialChannel =>
      RevupListener.listenerRewardedInterstitialChannel;

  /// Register listener of LuckyEvent
  static Future<void> setupLuckyEventListener({
    Function(String)? luckyEventWebViewNavigated,
  }) {
    return RevupListener.setupLuckyEventListener(
      luckyEventWebViewNavigated: luckyEventWebViewNavigated,
    );
  }

  /// Register listener of rewardedVideo
  static Future<void> setupRewardedVideoListener({
    Function(String)? onRewardedVideoAdLoaded,
    Function(String, int, String, String)? onRewardedVideoAdFailedToLoad,
    Function(String)? onRewardedVideoAdOpened,
    Function(String)? onRewardedVideoAdClosed,
    Function(String, String, int)? onRewarded,
    Function(String, int, String, String)? onRewardedVideoAdFailedToShow,
  }) {
    return RevupListener.setupRewardedVideoListener(
      onRewardedVideoAdLoaded: onRewardedVideoAdLoaded,
      onRewardedVideoAdFailedToLoad: onRewardedVideoAdFailedToLoad,
      onRewardedVideoAdOpened: onRewardedVideoAdOpened,
      onRewardedVideoAdClosed: onRewardedVideoAdClosed,
      onRewarded: onRewarded,
      onRewardedVideoAdFailedToShow: onRewardedVideoAdFailedToShow,
    );
  }

  /// Register listener of interstitial
  static Future<void> setupInterstitialListener({
    Function(String)? onInterstitialAdLoaded,
    Function(String, int, String, String)? onInterstitialAdFailedToLoad,
    Function(String)? onInterstitialAdOpened,
    Function(String)? onInterstitialAdClosed,
    Function(String, int, String, String)? onInterstitialAdFailedToShow,
  }) {
    return RevupListener.setupInterstitialListener(
      onInterstitialAdLoaded: onInterstitialAdLoaded,
      onInterstitialAdFailedToLoad: onInterstitialAdFailedToLoad,
      onInterstitialAdOpened: onInterstitialAdOpened,
      onInterstitialAdClosed: onInterstitialAdClosed,
      onInterstitialAdFailedToShow: onInterstitialAdFailedToShow,
    );
  }

  /// Register listener of rewardedInterstitial
  static Future<void> setupRewardedInterstitialListener({
    Function(String)? onRewardedInterstitialAdLoaded,
    Function(String, int, String, String)? onRewardedInterstitialAdFailedToLoad,
    Function(String)? onRewardedInterstitialAdSkip,
    Function(String)? onRewardedInterstitialAdOpened,
    Function(String)? onRewardedInterstitialAdClosed,
    Function(String, String, int)? onRewardedInterstitialRewarded,
    Function(String, int, String, String)? onRewardedInterstitialAdFailedToShow,
  }) {
    return RevupListener.setupRewardedInterstitialListener(
      onRewardedInterstitialAdLoaded: onRewardedInterstitialAdLoaded,
      onRewardedInterstitialAdFailedToLoad: onRewardedInterstitialAdFailedToLoad,
      onRewardedInterstitialAdSkip: onRewardedInterstitialAdSkip,
      onRewardedInterstitialAdOpened: onRewardedInterstitialAdOpened,
      onRewardedInterstitialAdClosed: onRewardedInterstitialAdClosed,
      onRewardedInterstitialRewarded: onRewardedInterstitialRewarded,
      onRewardedInterstitialAdFailedToShow:
          onRewardedInterstitialAdFailedToShow,
    );
  }
}
