class LoadData {

  var fnlsorular=[];
 /* final String sika;
  final String sikb;
  final String sikc;
  final String sikd;*/

  /*LoadData({this.soru,this.sika, this.sikb, this.sikc, this.sikd});*/
  LoadData({this.fnlsorular});
  factory LoadData.fromJson(Map<String, dynamic> json) {
    return LoadData(
        fnlsorular: json['fnlsorular']
      /* sika: json['sika'],
      sikb: json['sikb'],
      sikc: json['sikc'],
      sikd: json['sikd'],*/
    );
  }
}