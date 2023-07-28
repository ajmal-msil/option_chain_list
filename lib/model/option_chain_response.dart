class OptionChainResponse {
  List<Strike> strikes;

  OptionChainResponse({required this.strikes});

  factory OptionChainResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> strikesJson = json['strikes'];
    List<Strike> strikes = strikesJson.map((strikeJson) => Strike.fromJson(strikeJson)).toList();
    return OptionChainResponse(strikes: strikes);
  }
}

class Strike {
  String value;
  OptionData put;
  OptionData call;

  Strike({required this.value, required this.put, required this.call});

  factory Strike.fromJson(Map<String, dynamic> json) {
    return Strike(
      value: json['value'],
      put: OptionData.fromJson(json['put']),
      call: OptionData.fromJson(json['call']),
    );
  }
}

class OptionData {
  String ltp;
  String oi;
  String change;

  OptionData({required this.ltp, required this.oi, required this.change});

  factory OptionData.fromJson(Map<String, dynamic> json) {
    return OptionData(
      ltp: json['LTP'],
      oi: json['OI'],
      change: json['Change'],
    );
  }
}
