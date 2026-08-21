import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:revup_flutter_plugin/revup_flutter_plugin.dart';
import 'ri_custom_popup_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var logCount = 0;
  var mediaId;
  var mediaSecret;
  var userId;
  var customdata;
  var subDomain;
  var luckyEventAppId;
  var luckyEventPubId;
  var rvUnitId;
  var itUnitId;
  var riUnitId1;
  var riUnitId2;
  var riUnitId3;
  var riUnitId4;
  var riUnitId5;
  var isStyleMedium = false;
  var isStyleHidden = false;
  var isAlertHidden = false;
  var isRiCustomPopupEnabled = false;

  final _navigatorKey = GlobalKey<NavigatorState>();
  final _revupFlutterPlugin = RevupFlutterPlugin();
  final _mediaIdController = new TextEditingController();
  final _userIdController = new TextEditingController();
  final _childController = new TextEditingController();
  final _customdataController = new TextEditingController();
  final _callbackTagController = new TextEditingController();
  final _childYNController = new TextEditingController();
  final _unitIdController = new TextEditingController();
  final _luckyEventAppIdController = new TextEditingController();
  final _luckyEventPubIdController = new TextEditingController();
  final _rvUnitIdController = new TextEditingController();
  final _itUnitIdController = new TextEditingController();
  final _riUnitIdController = new TextEditingController();
  final _riUnitId1Controller = new TextEditingController();
  final _riUnitId2Controller = new TextEditingController();
  final _riUnitId3Controller = new TextEditingController();
  final _riUnitId4Controller = new TextEditingController();
  final _riUnitId5Controller = new TextEditingController();
  final _showWithLoadBackgroundRedController = new TextEditingController();
  final _showWithLoadBackgroundGreenController = new TextEditingController();
  final _showWithLoadBackgroundBlueController = new TextEditingController();
  final _showWithLoadBackgroundAlphaController = new TextEditingController();
  final _showWithLoadAlertMsgController = new TextEditingController();
  String _logResult = "";

  @override
  void initState() {
    super.initState();

    userId = "Flutter_Tester_User";
    subDomain = "link";
    if (Platform.isAndroid) {
      // 아래 값은 Revup 담당자를 통해 발급받아 기입하세요.
      mediaId = "";
      mediaSecret = "";
      luckyEventAppId = "";
      luckyEventPubId = "";
      rvUnitId = "ADMOB";
      itUnitId = "INTER_TEST";
      riUnitId1 = "RI_TEST";
      riUnitId2 = "RI_TEST1";
      riUnitId3 = "RI_TEST2";
      riUnitId4 = "RI_TEST3";
      riUnitId5 = "RI_TEST4";
    } else if (Platform.isIOS) {
      // 아래 값은 Revup 담당자를 통해 발급받아 기입하세요.
      mediaId = "";
      mediaSecret = "";
      luckyEventAppId = "";
      luckyEventPubId = "";
      rvUnitId = "MAX";
      itUnitId = "INTER_TEST";
      riUnitId1 = "RI_TEST_IOS";
      riUnitId2 = "RI_TEST1_IOS";
      riUnitId3 = "RI_TEST2_IOS";
      riUnitId4 = "RI_TEST3_IOS";
      riUnitId5 = "RI_TEST4_IOS";
    }

    _userIdController.text = userId;
    _luckyEventAppIdController.text = luckyEventAppId;
    _luckyEventPubIdController.text = luckyEventPubId;
    _rvUnitIdController.text = rvUnitId;
    _itUnitIdController.text = itUnitId;
    _riUnitIdController.text = riUnitId1;
    _riUnitId1Controller.text = riUnitId1;
    _riUnitId2Controller.text = riUnitId2;
    _riUnitId3Controller.text = riUnitId3;
    _riUnitId4Controller.text = riUnitId4;
    _riUnitId5Controller.text = riUnitId5;
    _showWithLoadBackgroundRedController.text = "0";
    _showWithLoadBackgroundGreenController.text = "0";
    _showWithLoadBackgroundBlueController.text = "0";
    _showWithLoadBackgroundAlphaController.text = "0.0";
    _showWithLoadAlertMsgController.text = "잠시 후 다시 시도해 주세요.";

    RevupListener.setupLuckyEventListener(
    luckyEventWebViewNavigated: (url) {
      pushLog("luckyEventWebViewNavigated => $url");
    });

    RevupListener.setupRewardedVideoListener(
    onRewardedVideoAdLoaded: (unitId) {
      pushLog("onRewardedVideoAdLoaded => $unitId");
    }, onRewardedVideoAdFailedToLoad: (unitId, errorCode, errorDescription, errorXB3TraceID) {
      pushLog("onRewardedVideoAdFailedToLoad => $unitId, $errorCode, $errorDescription, $errorXB3TraceID");
    }, onRewardedVideoAdOpened: (unitId) {
      pushLog("onRewardedVideoAdOpened => $unitId");
    }, onRewardedVideoAdClosed: (unitId) {
      pushLog("onRewardedVideoAdClosed => $unitId");
    }, onRewarded: (unitId, currencyUnit, amount) {
      pushLog("onRewarded => $unitId, $currencyUnit, $amount");
    }, onRewardedVideoAdFailedToShow: (unitId, errorCode, errorDescription, errorXB3TraceID) {
      pushLog("onRewardedVideoAdFailedToShow => $unitId, $errorCode, $errorDescription, $errorXB3TraceID");
    });

    RevupListener.setupInterstitialListener(
    onInterstitialAdLoaded: (unitId) {
      pushLog("onInterstitialAdLoaded => $unitId");
    }, onInterstitialAdFailedToLoad: (unitId, errorCode, errorDescription, errorXB3TraceID) {
      pushLog("onInterstitialAdFailedToLoad => $unitId, $errorCode, $errorDescription, $errorXB3TraceID");
    }, onInterstitialAdOpened: (unitId) {
      pushLog("onInterstitialAdOpened => $unitId");
    }, onInterstitialAdClosed: (unitId) {
      pushLog("onInterstitialAdClosed => $unitId");
    }, onInterstitialAdFailedToShow: (unitId, errorCode, errorDescription, errorXB3TraceID) {
      pushLog("onInterstitialAdFailedToShow => $unitId, $errorCode, $errorDescription, $errorXB3TraceID");
    });

    RevupListener.setupRewardedInterstitialListener(
    onRewardedInterstitialAdLoaded: (unitId) {
      pushLog("onRewardedInterstitialAdLoaded => $unitId");
    }, onRewardedInterstitialAdFailedToLoad: (unitId, errorCode, errorDescription, errorXB3TraceID) {
      pushLog("onRewardedInterstitialAdFailedToLoad => $unitId, $errorCode, $errorDescription, $errorXB3TraceID");
    }, onRewardedInterstitialAdSkip: (unitId) {
      pushLog("onRewardedInterstitialAdSkip => $unitId");
    }, onRewardedInterstitialAdOpened: (unitId) {
      pushLog("onRewardedInterstitialAdOpened => $unitId");
    }, onRewardedInterstitialAdClosed: (unitId) {
      pushLog("onRewardedInterstitialAdClosed => $unitId");
    }, onRewardedInterstitialRewarded: (unitId, currencyUnit, amount) {
      pushLog("onRewardedInterstitialRewarded => $unitId, $currencyUnit, $amount");
    }, onRewardedInterstitialAdFailedToShow: (unitId, errorCode, errorDescription, errorXB3TraceID) {
      pushLog("onRewardedInterstitialAdFailedToShow => $unitId, $errorCode, $errorDescription, $errorXB3TraceID");
    });
  }

  Future<void> pushLog(String log) async {
    setState(() {
      if (_logResult.isEmpty) {
        _logResult = "$logCount " + log;
      } else {
        _logResult = "$logCount " + log + "\n" + _logResult;
      }
      logCount++;
    });
  }

  Future<void> initialize() async {
    bool result = false;
    try {
      result = await _revupFlutterPlugin.initialize() ?? false;
    } on PlatformException {
      result = false;
    }
    if (!mounted) return;
    pushLog("Initialize => $result");

    if (result && !_userIdController.text.isEmpty) {
      setUserId(_userIdController.text);
    }
  }

  Future<void> initialize1(String callbackTag) async {
    bool result = false;
    try {
      result = await _revupFlutterPlugin.initialize("", "", callbackTag, "") ?? false;
    } on PlatformException {
      result = false;
    }
    if (!mounted) return;
    pushLog("Initialize => $result");

    if (result && !_userIdController.text.isEmpty) {
      setUserId(_userIdController.text);
    }
  }

  Future<void> initialize2(String callbackTag, String childYN) async {
    bool result = false;
    try {
      result = await _revupFlutterPlugin.initialize("", "", callbackTag, childYN) ?? false;
    } on PlatformException {
      result = false;
    }
    if (!mounted) return;
    pushLog("Initialize => $result");

    if (result && !_userIdController.text.isEmpty) {
      setUserId(_userIdController.text);
    }
  }

  Future<void> initialize3(String mediaId, String mediaSecret) async {
    bool result = false;
    try {
      result = await _revupFlutterPlugin.initialize(mediaId, mediaSecret, "", "") ?? false;
    } on PlatformException {
      result = false;
    }
    if (!mounted) return;
    pushLog("Initialize => $result");

    if (result && !_userIdController.text.isEmpty) {
      setUserId(_userIdController.text);
    }
  }

  Future<void> initialize4(String mediaId, String mediaSecret, String callbackTag) async {
    bool result = false;
    try {
      result = await _revupFlutterPlugin.initialize(mediaId, mediaSecret, callbackTag, "") ?? false;
    } on PlatformException {
      result = false;
    }
    if (!mounted) return;
    pushLog("Initialize => $result");

    if (result && !_userIdController.text.isEmpty) {
      setUserId(_userIdController.text);
    }
  }

  Future<void> initialize5(String mediaId, String mediaSecret, String callbackTag, String childYN) async {
    bool result = false;
    try {
      result = await _revupFlutterPlugin.initialize(mediaId, mediaSecret, callbackTag, childYN) ?? false;
    } on PlatformException {
      result = false;
    }
    if (!mounted) return;
    pushLog("Initialize => $result");

    if (result && !_userIdController.text.isEmpty) {
      setUserId(_userIdController.text);
    }
  }

  Future<void> setUserId(String userId) async {
    bool result = false;
    try {
      result = await _revupFlutterPlugin.setUserId(userId) ?? false;
    } on PlatformException {
      result = false;
    }
    if (!mounted) return;
    pushLog("Set User ID => $result / $userId");
  }

  Future<void> setUserIdChild(String userId, int child) async {
    bool result = false;
    try {
      result = await _revupFlutterPlugin.setUserIdChild(userId, child) ?? false;
    } on PlatformException {
      result = false;
    }
    if (!mounted) return;
    pushLog("Set User ID & Child => $result / $userId / $child");
  }

  Future<void> showLuckyEvent() async {
    bool result = false;
    try {
      result = await _revupFlutterPlugin.showLuckyEvent() ?? false;
    } on PlatformException {
      result = false;
    }
    if (!mounted) return;
    pushLog("showLuckyEvent => $result");
  }

  Future<void> setLuckyEventAppId(String eventId, String pid) async {
    bool result = false;
    try {
      result = await _revupFlutterPlugin.setLuckyEventAppId(eventId, pid) ?? false;
    } on PlatformException {
      result = false;
    }
    if (!mounted) return;
    pushLog("setLuckyEventAppId => $result / $eventId / $pid");
  }

  Future<void> setLuckyEventUseSafeAreaWebView(bool useSafeArea) async {
    bool result = false;
    try {
      result = await _revupFlutterPlugin.setLuckyEventUseSafeAreaWebView(useSafeArea) ?? false;
    } on PlatformException {
      result = false;
    }
    if (!mounted) return;
    pushLog("setLuckyEventAppId => $result / $useSafeArea");
  }

  Future<void> setLuckyEventEdgeGesture(bool isEdgeGesture) async {
    bool result = false;
    try {
      result = await _revupFlutterPlugin.setLuckyEventEdgeGesture(isEdgeGesture) ?? false;
    } on PlatformException {
      result = false;
    }
    if (!mounted) return;
    pushLog("setLuckyEventEdgeGesture => $result / $isEdgeGesture");
  }

  Future<void> setLuckyEventHashMark(String hashMark) async {
    bool result = false;
    try {
      result = await _revupFlutterPlugin.setLuckyEventHashMark(hashMark) ?? false;
    } on PlatformException {
      result = false;
    }
    if (!mounted) return;
    pushLog("setLuckyEventAppId => $result / $hashMark");
  }

  Future<void> setLuckyEventBaseUrl(String baseUrl) async {
    bool result = false;
    try {
      result = await _revupFlutterPlugin.setLuckyEventBaseUrl(baseUrl) ?? false;
    } on PlatformException {
      result = false;
    }
    if (!mounted) return;
    pushLog("setLuckyEventAppId => $result / $baseUrl");
  }

  Future<void> setLuckyEventExtraParam(String key, String value) async {
    bool result = false;
    try {
      result = await _revupFlutterPlugin.setLuckyEventExtraParam(key, value) ?? false;
    } on PlatformException {
      result = false;
    }
    if (!mounted) return;
    pushLog("setLuckyEventAppId => $result / $key / $value");
  }

  Future<void> setLuckyEventTheme(RevupLuckyEventTheme theme) async {
    bool result = false;
    try {
      result = await _revupFlutterPlugin.setLuckyEventTheme(theme) ?? false;
    } on PlatformException {
      result = false;
    }
    if (!mounted) return;
    pushLog("setLuckyEventTheme => $result / ${theme.value}");
  }

  Future<void> setRewardedCheckParam(String param) async {
    try {
      await _revupFlutterPlugin.setRewardedCheckParam(param);
    } on PlatformException {
    }
    if (!mounted) return;
    pushLog("CustomData => $param");
  }

  Future<void> isInitialized() async {
    bool result = false;
    try {
      result = await _revupFlutterPlugin.isInitialized() ?? false;
    } on PlatformException {
      result = false;
    }
    if (!mounted) return;
    pushLog("Initialized Flag => $result");
  }

  Future<void> getSDKVersion() async {
    String result = "";
    try {
      result = await _revupFlutterPlugin.getSDKVersion() ?? "";
    } on PlatformException {
      result = "";
    }
    if (!mounted) return;
    pushLog("SDK Version => $result");
  }

  Future<void> getNetworkVersions() async {
    String result = "";
    try {
      result = await _revupFlutterPlugin.getNetworkVersions() ?? "";
    } on PlatformException {
      result = "";
    }
    if (!mounted) return;
    pushLog("Network Versions => $result");
  }

  Future<void> getUnitStatus(String unitId) async {
    if (unitId.isEmpty) {
      pushLog("Not Found UnitID => $unitId");
      return;
    }

    Map result = {};
    try {
      result = await _revupFlutterPlugin.getUnitStatus(unitId) ?? {};
    } on PlatformException {
      result = {};
    }
    if (!mounted) return;
    pushLog("$unitId UnitID Status => $result");
  }

  Future<void> showMaxMediationDebugger() async {
    try {
      await _revupFlutterPlugin.showMaxMediationDebugger();
    } on PlatformException {
    }
    if (!mounted) return;
    pushLog("Show Max Mediation Debugger");
  }

  Future<void> showAdmobMediationDebugger() async {
    try {
      await _revupFlutterPlugin.showAdmobMediationDebugger();
    } on PlatformException {
    }
    if (!mounted) return;
    pushLog("Show Admob Mediation Debugger");
  }

  Future<void> setVolumeOff(isOn) async {
    try {
      await _revupFlutterPlugin.setVolumeOff(isOn);
    } on PlatformException {
    }
    if (!mounted) return;
    if (isOn) {
      pushLog("Ad Sound Off");
    } else {
      pushLog("Ad Sound On");
    }
  }

  Future<void> setShowWithLoad2BackgroundColor(red, green, blue, alpha) async {
    try {
      await _revupFlutterPlugin.setShowWithLoad2BackgroundColor(red, green, blue, alpha);
    } on PlatformException {
    }
    if (!mounted) return;
    pushLog("ShowWithLoad2BackgroundColor");
  }

  Future<void> setShowWithLoad2IndicatorStyle(isMedium, isHidden) async {
    try {
      await _revupFlutterPlugin.setShowWithLoad2IndicatorStyle(isMedium, isHidden);
    } on PlatformException {
    }
    if (!mounted) return;
    pushLog("setShowWithLoad2IndicatorStyle");
  }

  Future<void> setShowWithLoad2ErrorAlert(msg, isHidden) async {
    try {
      await _revupFlutterPlugin.setShowWithLoad2ErrorAlert(msg, isHidden);
    } on PlatformException {
    }
    if (!mounted) return;
    pushLog("setShowWithLoad2ErrorAlert");
  }

  Future<void> rewardedVideoShowWithLoad(String unitId) async {
    if (unitId.isEmpty) {
      pushLog("Not Found UnitID => $unitId");
      return;
    }

    bool result = false;
    try {
      result = await _revupFlutterPlugin.rewardedVideoShowWithLoad(unitId) ?? false;
    } on PlatformException {
      result = false;
    }
    if (!mounted) return;
    pushLog("Click RewardedVideo ShowWithLoad => $result");
  }

  Future<void> rewardedVideoLoad(String unitId) async {
    if (unitId.isEmpty) {
      pushLog("Not Found UnitID => $unitId");
      return;
    }

    bool result = false;
    try {
      result = await _revupFlutterPlugin.rewardedVideoLoad(unitId) ?? false;
    } on PlatformException {
      result = false;
    }
    if (!mounted) return;
    pushLog("Click RewardedVideo Load => $result");
  }

  Future<void> rewardedVideoIsLoad(String unitId) async {
    if (unitId.isEmpty) {
      pushLog("Not Found UnitID => $unitId");
      return;
    }

    bool result = false;
    try {
      result = await _revupFlutterPlugin.rewardedVideoIsLoad(unitId) ?? false;
    } on PlatformException {
      result = false;
    }
    if (!mounted) return;
    pushLog("RewardedVideo IsLoad => $result");
  }

  Future<void> rewardedVideoShow() async {
    bool result = false;
    try {
      result = await _revupFlutterPlugin.rewardedVideoShow() ?? false;
    } on PlatformException {
      result = false;
    }
    if (!mounted) return;
    pushLog("RewardedVideo Show => $result");
  }

  Future<void> interstitialShowWithLoad(String unitId) async {
    if (unitId.isEmpty) {
      pushLog("Not Found UnitID => $unitId");
      return;
    }

    bool result = false;
    try {
      result = await _revupFlutterPlugin.interstitialShowWithLoad(unitId) ?? false;
    } on PlatformException {
      result = false;
    }
    if (!mounted) return;
    pushLog("Click Interstitial ShowWithLoad => $result");
  }

  Future<void> interstitialLoad(String unitId) async {
    if (unitId.isEmpty) {
      pushLog("Not Found UnitID => $unitId");
      return;
    }

    bool result = false;
    try {
      result = await _revupFlutterPlugin.interstitialLoad(unitId) ?? false;
    } on PlatformException {
      result = false;
    }
    if (!mounted) return;
    pushLog("Click Interstitial Load => $result");
  }

  Future<void> interstitialIsLoad(String unitId) async {
    if (unitId.isEmpty) {
      pushLog("Not Found UnitID => $unitId");
      return;
    }

    bool result = false;
    try {
      result = await _revupFlutterPlugin.interstitialIsLoad(unitId) ?? false;
    } on PlatformException {
      result = false;
    }
    if (!mounted) return;
    pushLog("Interstitial IsLoad => $result");
  }

  Future<void> interstitialShow() async {
    bool result = false;
    try {
      result = await _revupFlutterPlugin.interstitialShow() ?? false;
    } on PlatformException {
      result = false;
    }
    if (!mounted) return;
    pushLog("Interstitial Show => $result");
  }

  Future<void> getUnitStatusRewardedInterstitial(String unitId) async {
    if (unitId.isEmpty) {
      pushLog("Not Found UnitID => $unitId");
      return;
    }

    Map result = {};
    try {
      result = await _revupFlutterPlugin.getUnitStatusRewardedInterstitial(unitId) ?? {};
    } on PlatformException {
      result = {};
    }
    if (!mounted) return;
    pushLog("RewardedInterstitial Unit Status => $result");
  }

  Future<void> preLoadAllRewardedInterstitial() async {
    bool result = false;
    try {
      result = await _revupFlutterPlugin.preLoadAllRewardedInterstitial() ?? false;
    } on PlatformException {
      result = false;
    }
    if (!mounted) return;
    pushLog("Click PreLoad All RewardedInterstitial => $result");
  }

  Future<void> preLoadRewardedInterstitial(List<String>? unitIds) async {
    bool result = false;
    try {
      result = await _revupFlutterPlugin.preLoadRewardedInterstitial(unitIds) ?? false;
    } on PlatformException {
      result = false;
    }
    if (!mounted) return;
    pushLog("Click PreLoad UnitIDs RewardedInterstitial => $result");
  }

  Future<void> loadRewardedInterstitial(String unitId) async {
    if (unitId.isEmpty) {
      pushLog("Not Found UnitID => $unitId");
      return;
    }

    bool result = false;
    try {
      result = await _revupFlutterPlugin.loadRewardedInterstitial(unitId) ?? false;
    } on PlatformException {
      result = false;
    }
    if (!mounted) return;
    pushLog("RewardedInterstitial Load => $result");
  }

  Future<void> rewardedInterstitiaIsLoad(String unitId) async {
    if (unitId.isEmpty) {
      pushLog("Not Found UnitID => $unitId");
      return;
    }

    bool result = false;
    try {
      result = await _revupFlutterPlugin.rewardedInterstitialIsLoad(unitId) ?? false;
    } on PlatformException {
      result = false;
    }
    if (!mounted) return;
    pushLog("Interstitial IsLoad => $result");
  }

  Future<void> showRewardedInterstitial(String unitId) async {
    bool result = false;
    try {
      result = await _revupFlutterPlugin.showRewardedInterstitial(unitId) ?? false;
    } on PlatformException {
      result = false;
    }
    if (!mounted) return;
    pushLog("RewardedInterstitial Show => $result");
  }

  Future<void> showWithPopupRewardedInterstitial(String unitId) async {
    bool result = false;
    try {
      result = await _revupFlutterPlugin.showWithPopupRewardedInterstitial(unitId) ?? false;
    } on PlatformException {
      result = false;
    }
    if (!mounted) return;
    pushLog("RewardedInterstitial Show => $result");
  }

  Future<void> handleShowRewardedInterstitial(String unitId) async {
    if (isRiCustomPopupEnabled) {
      bool result = await _revupFlutterPlugin.rewardedInterstitialIsLoad(unitId) ?? false;
      if (!result) {
        pushLog("not call showRewardedInterstitial => $unitId unit is not loaded (don't show popup)");
        return;
      }

      final shouldShow = await showDialog<bool>(
        context: _navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (context) => RiCustomPopupDialog(unitId: unitId),
      );
      if (shouldShow == true) {
        showRewardedInterstitial(unitId);
      }
    } else {
      showRewardedInterstitial(unitId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Revup Example App'),
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                height: 1.0,
                width: double.infinity,
                color:Colors.black,
              ),
              Container(
                color: Colors.white,
                child: SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      primary: false,
                      scrollDirection: Axis.vertical,
                      child: Text('$_logResult'),
                    ),
                  ),
                ),
              ),
              Container(
                height: 1.0,
                width: double.infinity,
                color:Colors.black,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(5),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      SizedBox( height: 10,),
                      Row(
                        children: [
                          Text("Media ID"),
                          SizedBox( width: 10,),
                          Flexible(
                            child: SizedBox(
                              height: 30,
                              child: TextField(
                                controller: _mediaIdController,
                                textAlignVertical: TextAlignVertical.center,
                                enabled: false,
                                decoration: InputDecoration(
                                  labelText: mediaId,
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox( height: 5,),
                      SizedBox(
                        height: 38,
                        child: TextField(
                          controller: _userIdController,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            border: InputBorder.none,
                            labelText: 'User ID',
                          ),
                        ),
                      ),
                      SizedBox( height: 5,),
                      Container(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () { setUserId(_userIdController.text); },
                          child: Text("Set User ID")
                        ),
                      ),
                      SizedBox( height: 5,),
                      SizedBox(
                        height: 38,
                        child: TextField(
                          controller: _childController,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            border: InputBorder.none,
                            labelText: 'Child (0:None, 1:Adult, 2:Child")',
                          ),
                        ),
                      ),
                      SizedBox( height: 5,),
                      Container(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () { setUserIdChild(_userIdController.text, int.parse(_childController.text)); },
                          child: Text("Set User ID & Child")
                        ),
                      ),
                      SizedBox( height: 10,),
                      SizedBox(
                        height: 38,
                        child: TextField(
                          controller: _callbackTagController,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            border: InputBorder.none,
                            labelText: 'Callback Tag',
                          ),
                        ),
                      ),
                      SizedBox( height: 5,),
                      SizedBox(
                        height: 38,
                        child: TextField(
                          controller: _childYNController,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            border: InputBorder.none,
                            labelText: 'Child YN',
                          ),
                        ),
                      ),
                      SizedBox( height: 10,),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () { initialize(); },
                                child: Text("Initializ()")
                              ),
                            ),
                          ),
                          SizedBox( width: 5,),
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () { initialize1(_callbackTagController.text); },
                                child: Text("Initializ(callbackTag)")
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox( height: 5,),
                      Container(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () { initialize2(_callbackTagController.text, _childYNController.text); },
                          child: Text("Initializ(callbackTag, childYN)")
                        ),
                      ),
                      SizedBox( height: 5,),
                      Container(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            initialize3(mediaId, mediaSecret);
                          },
                          child: Text("Initializ(mediaId, mediaSecret)")
                        ),
                      ),
                      SizedBox( height: 5,),
                      Container(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            initialize4(mediaId, mediaSecret, _callbackTagController.text);
                          },
                          child: Text("Initializ(mediaId, mediaSecret, callbackTag)")
                        ),
                      ),
                      SizedBox( height: 5,),
                      Container(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            initialize5(mediaId, mediaSecret, _callbackTagController.text, _childYNController.text);
                          },
                          child: Text("Initializ(mediaId, mediaSecret, callbackTag, childYN)")
                        ),
                      ),
                      SizedBox( height: 5,),
                      Container(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () { isInitialized(); },
                          child: Text("isInitialized")
                        ),
                      ),
                      SizedBox( height: 20,),
                      Text(
                        "Other",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox( height: 5,),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: _customdataController,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            border: InputBorder.none,
                            labelText: 'CustomData',
                          ),
                        ),
                      ),
                      SizedBox( height: 5,),
                      Container(
                        width: double.infinity,
                        child: OutlinedButton(
                            onPressed: () { setRewardedCheckParam(_customdataController.text); },
                            child: Text("CustomData")
                        ),
                      ),
                      SizedBox( height: 5,),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () { getSDKVersion(); },
                                child: Text("Print SDK Version")
                              ),
                            ),
                          ),
                          SizedBox( width: 5,),
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () { getNetworkVersions(); },
                                child: Text("Print Network Version")
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox( height: 5,),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: _unitIdController,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            border: InputBorder.none,
                            labelText: 'Unit ID',
                          ),
                        ),
                      ),
                      SizedBox( height: 5,),
                      Container(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () { getUnitStatus(_unitIdController.text); },
                          child: Text("Get UnitID Status")
                        ),
                      ),
                      SizedBox( height: 10,),
                      Container(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () { showMaxMediationDebugger(); },
                          child: Text("Show Max Mediation Debugger - 앱 구동 후 첫 진입 시 5초간 대기 후 화면 터치 가능")
                        ),
                      ),
                      SizedBox( height: 5,),
                      Container(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () { showAdmobMediationDebugger(); },
                          child: Text("Show Admob Mediation Debugger - 미동작 시 애드몹 물량 로드 후 진입 가능 (이니셜라이즈 필요)")
                        ),
                      ),
                      SizedBox( height: 10,),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () { setVolumeOff(false); },
                                child: Text("Ad Sound On")
                              ),
                            ),
                          ),
                          SizedBox( width: 5,),
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () { setVolumeOff(true); },
                                child: Text("Ad Sound Off")
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox( height: 20,),
                      Text(
                        "Lucky Event",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox( height: 5,),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: _luckyEventAppIdController,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            border: InputBorder.none,
                            labelText: 'App ID',
                          ),
                        ),
                      ),
                      SizedBox( height: 5,),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: _luckyEventPubIdController,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            border: InputBorder.none,
                            labelText: 'Pub ID',
                          ),
                        ),
                      ),
                      SizedBox( height: 5,),
                      Container(
                        width: double.infinity,
                        child: OutlinedButton(
                            onPressed: () { setLuckyEventAppId(_luckyEventAppIdController.text, _luckyEventPubIdController.text); },
                            child: Text("Set Lucky Event")
                        ),
                      ),
                      SizedBox( height: 5,),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () { setLuckyEventEdgeGesture(true); },
                                child: Text("Edge Gesture On (iOS)")
                              ),
                            ),
                          ),
                          SizedBox( width: 5,),
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () { setLuckyEventEdgeGesture(false); },
                                child: Text("Edge Gesture Off (iOS)")
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox( height: 5,),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () { setLuckyEventTheme(RevupLuckyEventTheme.light); },
                                child: Text("Theme Light")
                              ),
                            ),
                          ),
                          SizedBox( width: 5,),
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () { setLuckyEventTheme(RevupLuckyEventTheme.dark); },
                                child: Text("Theme Dark")
                              ),
                            ),
                          ),
                          SizedBox( width: 5,),
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () { setLuckyEventTheme(RevupLuckyEventTheme.system); },
                                child: Text("Theme System")
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox( height: 5,),
                      Container(
                        width: double.infinity,
                        child: OutlinedButton(
                            onPressed: () { showLuckyEvent(); },
                            child: Text("Show Lucky Event")
                        ),
                      ),
                      SizedBox( height: 20,),
                      Text(
                        "Rewarded Video",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox( height: 5,),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: _rvUnitIdController,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            border: InputBorder.none,
                            labelText: 'Unit ID',
                          ),
                        ),
                      ),
                      SizedBox( height: 5,),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () { rewardedVideoLoad(_rvUnitIdController.text); },
                                child: Text("Load")
                              ),
                            ),
                          ),
                          SizedBox( width: 5,),
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () { rewardedVideoIsLoad(_rvUnitIdController.text); },
                                child: Text("IsLoaded")
                              ),
                            ),
                          ),
                          SizedBox( width: 5,),
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () { rewardedVideoShow(); },
                                child: Text("Show")
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox( height: 5,),
                      Container(
                        width: double.infinity,
                        child: OutlinedButton(
                            onPressed: () { rewardedVideoShowWithLoad(_rvUnitIdController.text); },
                            child: Text("Show With Load")
                        ),
                      ),
                      SizedBox( height: 20,),
                      Text(
                        "Interstitial",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox( height: 5,),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: _itUnitIdController,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            border: InputBorder.none,
                            labelText: 'Unit ID',
                          ),
                        ),
                      ),
                      SizedBox( height: 5,),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () { interstitialLoad(_itUnitIdController.text); },
                                child: Text("Load")
                              ),
                            ),
                          ),
                          SizedBox( width: 5,),
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () { interstitialIsLoad(_itUnitIdController.text); },
                                child: Text("IsLoaded")
                              ),
                            ),
                          ),
                          SizedBox( width: 5,),
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () { interstitialShow(); },
                                child: Text("Show")
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox( height: 5,),
                      Container(
                        width: double.infinity,
                        child: OutlinedButton(
                            onPressed: () { interstitialShowWithLoad(_itUnitIdController.text); },
                            child: Text("Show With Load")
                        ),
                      ),
                      SizedBox( height: 20,),
                      Text(
                        "RewardedVideo Interstitial",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox( height: 5,),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: _riUnitId1Controller,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            border: InputBorder.none,
                            labelText: 'RI Unit ID1',
                          ),
                        ),
                      ),
                      SizedBox( height: 5,),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: _riUnitId2Controller,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            border: InputBorder.none,
                            labelText: 'RI Unit ID2',
                          ),
                        ),
                      ),
                      SizedBox( height: 5,),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: _riUnitId3Controller,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            border: InputBorder.none,
                            labelText: 'RI Unit ID3',
                          ),
                        ),
                      ),
                      SizedBox( height: 5,),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: _riUnitId4Controller,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            border: InputBorder.none,
                            labelText: 'RI Unit ID4',
                          ),
                        ),
                      ),
                      SizedBox( height: 5,),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: _riUnitId5Controller,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            border: InputBorder.none,
                            labelText: 'RI Unit ID5',
                          ),
                        ),
                      ),
                      SizedBox( height: 5,),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () { preLoadAllRewardedInterstitial(); },
                                child: Text("PreLoad All")
                              ),
                            ),
                          ),
                          SizedBox( width: 5,),
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () {
                                  var item = List<String>.empty(growable : true);
                                  if (_riUnitId1Controller.text.isNotEmpty) {
                                    item.add(_riUnitId1Controller.text);
                                  }
                                  if (_riUnitId2Controller.text.isNotEmpty) {
                                    item.add(_riUnitId2Controller.text);
                                  }
                                  if (_riUnitId3Controller.text.isNotEmpty) {
                                    item.add(_riUnitId3Controller.text);
                                  }
                                  if (_riUnitId4Controller.text.isNotEmpty) {
                                    item.add(_riUnitId4Controller.text);
                                  }
                                  if (_riUnitId5Controller.text.isNotEmpty) {
                                    item.add(_riUnitId5Controller.text);
                                  }
                                  preLoadRewardedInterstitial(item.cast<String>());
                                },
                                child: Text("PreLoad UnitIDs")
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox( height: 5,),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: _riUnitIdController,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            border: InputBorder.none,
                            labelText: 'RI Unit ID',
                          ),
                        ),
                      ),
                      SizedBox( height: 5,),
                      Container(
                        width: double.infinity,
                        child: OutlinedButton(
                            onPressed: () { loadRewardedInterstitial(_riUnitIdController.text); },
                            child: Text("Load")
                        ),
                      ),
                      SizedBox( height: 5,),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                  onPressed: () { rewardedInterstitiaIsLoad(_riUnitIdController.text); },
                                  child: Text("IsLoaded")
                              ),
                            ),
                          ),
                          SizedBox( width: 5,),
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                  onPressed: () { getUnitStatusRewardedInterstitial(_riUnitIdController.text); },
                                  child: Text("GetUnitStatus")
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox( height: 5,),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () { handleShowRewardedInterstitial(_riUnitIdController.text); },
                                child: Text("Show")
                              ),
                            ),
                          ),
                          SizedBox( width: 5,),
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                  onPressed: () { showWithPopupRewardedInterstitial(_riUnitIdController.text); },
                                  child: Text("ShowWithPopup")
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox( height: 5,),
                      Row(
                        children: [
                          Text("자체 팝업", style: TextStyle(fontSize: 14)),
                          SizedBox(width: 8),
                          Switch(
                            value: isRiCustomPopupEnabled,
                            onChanged: (value) {
                              setState(() { isRiCustomPopupEnabled = value; });
                              pushLog("RI 자체 팝업 ${value ? 'ON' : 'OFF'}");
                            },
                          ),
                          SizedBox(width: 4),
                          Text(isRiCustomPopupEnabled ? "ON" : "OFF",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isRiCustomPopupEnabled ? Colors.green : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox( height: 20,),
                      Text(
                        "ShowWithLoad Background Color",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox( height: 5,),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: _showWithLoadBackgroundRedController,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            border: InputBorder.none,
                            labelText: 'Red',
                          ),
                        ),
                      ),
                      SizedBox( height: 5,),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: _showWithLoadBackgroundGreenController,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            border: InputBorder.none,
                            labelText: 'Green',
                          ),
                        ),
                      ),
                      SizedBox( height: 5,),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: _showWithLoadBackgroundBlueController,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            border: InputBorder.none,
                            labelText: 'Blue',
                          ),
                        ),
                      ),
                      SizedBox( height: 5,),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: _showWithLoadBackgroundAlphaController,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            border: InputBorder.none,
                            labelText: 'Alpha',
                          ),
                        ),
                      ),
                      SizedBox( height: 5,),
                      Container(
                        width: double.infinity,
                        child: OutlinedButton(
                            onPressed: () { setShowWithLoad2BackgroundColor(_showWithLoadBackgroundRedController.text, _showWithLoadBackgroundGreenController.text, _showWithLoadBackgroundBlueController.text, _showWithLoadBackgroundAlphaController.text); },
                            child: Text("Set Show With Load Background Color")
                        ),
                      ),
                      SizedBox( height: 5,),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                  onPressed: () {
                                    isStyleMedium = !isStyleMedium;
                                    setShowWithLoad2IndicatorStyle(isStyleMedium, isStyleHidden);
                                  },
                                  child: Text("Set Show With Load Indicator Style")
                              ),
                            ),
                          ),
                          SizedBox( width: 5,),
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                  onPressed: () {
                                    isStyleHidden = !isStyleHidden;
                                    setShowWithLoad2IndicatorStyle(isStyleMedium, isStyleHidden);
                                  },
                                  child: Text("Set Show With Load Indicator Hidden")
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox( height: 5,),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: _showWithLoadAlertMsgController,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            border: InputBorder.none,
                            labelText: 'Alert Msg',
                          ),
                        ),
                      ),
                      SizedBox( height: 5,),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                  onPressed: () { setShowWithLoad2ErrorAlert(_showWithLoadAlertMsgController.text, isAlertHidden); },
                                  child: Text("Set Show With Load Alert Msg")
                              ),
                            ),
                          ),
                          SizedBox( width: 5,),
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                  onPressed: () {
                                    isAlertHidden = !isAlertHidden;
                                    setShowWithLoad2ErrorAlert(_showWithLoadAlertMsgController.text, isAlertHidden);
                                  },
                                  child: Text("Set Show With Load Alert Hidden")
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox( height: 30,),
                    ],
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
