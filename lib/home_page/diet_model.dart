class Something {
  int? gym;
  int? branch;
  String? name;
  String? description;
  List<Days>? days;

  Something({this.gym, this.branch, this.name, this.description, this.days});

  Something.fromJson(Map<String, dynamic> json) {
    gym = json['gym'];
    branch = json['branch'];
    name = json['name'];
    description = json['description'];
    if (json['days'] != null) {
      days = <Days>[];
      json['days'].forEach((v) {
        days!.add(new Days.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gym'] = this.gym;
    data['branch'] = this.branch;
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.days != null) {
      data['days'] = this.days!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Days {
  String? day;
  List<Timingss>? timings;

  Days({this.day, this.timings});

  Days.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    if (json['timings'] != null) {
      timings = <Timingss>[];
      json['timings'].forEach((v) {
        timings!.add(new Timingss.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    if (this.timings != null) {
      data['timings'] = this.timings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Timingss {
  String? time;
  String? itemName;
  bool? isDone;
  String? description;

  Timingss({this.time, this.itemName, this.isDone, this.description});

  Timingss.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    itemName = json['item_name'];
    isDone = json['is_done'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['item_name'] = this.itemName;
    data['is_done'] = this.isDone;
    data['description'] = this.description;
    return data;
  }
}