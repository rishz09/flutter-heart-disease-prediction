//ignore_for_file: prefer_const_constructors
class Detail {
  int? _id;
  late int _age,
      _sex,
      _chestPainType,
      _fastingBS,
      _restingECG,
      _exerciseAngina,
      _stSlope;
  late double _restingBP, _fastingBSTemp, _cholesterol, _maxHR, _oldpeak, _pred;
  late String _date, _title;

  Detail(
      this._age,
      this._sex,
      this._chestPainType,
      this._fastingBS,
      this._fastingBSTemp,
      this._restingECG,
      this._exerciseAngina,
      this._stSlope,
      this._restingBP,
      this._cholesterol,
      this._maxHR,
      this._oldpeak,
      this._pred,
      this._date,
      this._title);

  int? get id => _id;
  int get age => _age;
  int get sex => _sex;
  int get chestPainType => _chestPainType;
  int get fastingBS => _fastingBS;
  double get fastingBSTemp => _fastingBSTemp;
  int get restingECG => _restingECG;
  int get exerciseAngina => _exerciseAngina;
  int get stSlope => _stSlope;
  double get restingBP => _restingBP;
  double get cholesterol => _cholesterol;
  double get maxHR => _maxHR;
  double get oldpeak => _oldpeak;
  double get pred => _pred;
  String get date => _date;
  String get title => _title;

  set id(int? newId) => this._id = id;
  set age(int newAge) => this._age = newAge;
  set sex(int newSex) => this._sex = newSex;
  set chestPainType(int newChestPainType) =>
      this._chestPainType = newChestPainType;

  set fastingBS(int newFastingBS) => this._fastingBS = newFastingBS;
  set fastingBSTemp(double newFastingBSTemp) =>
      this._fastingBSTemp = newFastingBSTemp;
  set restingECG(int newRestingECG) => this._restingECG = newRestingECG;
  set exerciseAngina(int newExerciseAngina) =>
      this._exerciseAngina = newExerciseAngina;
  set stSlope(int newStSlope) => this._stSlope = newStSlope;
  set restingBP(double newRestingBP) => this._restingBP = newRestingBP;
  set cholesterol(double newCholesterol) => this._cholesterol = newCholesterol;
  set maxHR(double newMaxHR) => this._maxHR = newMaxHR;
  set oldpeak(double newOldpeak) => this._oldpeak = newOldpeak;
  set pred(double newPred) => this._pred = newPred;
  set date(String newDate) => this._date = newDate;
  set title(String newTitle) => this._title = newTitle;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }

    map['age'] = _age;
    map['sex'] = _sex;
    map['chestPainType'] = _chestPainType;
    map['fastingBS'] = _fastingBS;
    map['fastingBSTemp'] = _fastingBSTemp;
    map['restingECG'] = _restingECG;
    map['exerciseAngina'] = _exerciseAngina;
    map['stSlope'] = _stSlope;
    map['restingBP'] = _restingBP;
    map['cholesterol'] = _cholesterol;
    map['maxHR'] = _maxHR;
    map['oldpeak'] = _oldpeak;
    map['pred'] = _pred;
    map['date'] = _date;
    map['title'] = _title;

    return map;
  }

  Detail.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._age = map['age'];
    this._sex = map['sex'];
    this._chestPainType = map['chestPainType'];
    this._fastingBS = map['fastingBS'];
    this._fastingBSTemp = map['fastingBSTemp'];
    this._restingECG = map['restingECG'];
    this._exerciseAngina = map['exerciseAngina'];
    this._stSlope = map['stSlope'];
    this._restingBP = map['restingBP'];
    this._cholesterol = map['cholesterol'];
    this._maxHR = map['maxHR'];
    this._oldpeak = map['oldpeak'];
    this._pred = map['pred'];
    this._date = map['date'];
    this._title = map['title'];
  }
}
