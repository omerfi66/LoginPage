class UsersModel {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<Data>? data;
  Support? support;

  UsersModel({
    this.page,  
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
    this.support,
  });

  // JSON'dan UsersModel nesnesi oluşturan fromJson fonksiyonu
  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      page: json['page'],
      perPage: json['per_page'],
      total: json['total'],
      totalPages: json['total_pages'],
      data: List<Data>.from(json['data'].map((x) => Data.fromJson(x))),
      support: Support.fromJson(json['support']),
    );
  }
}

class Data {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  Data({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  // JSON'dan Data nesnesi oluşturan fromJson fonksiyonu
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
    );
  }
}

class Support {
  String? url;
  String? text;

  Support({
    this.url,
    this.text,
  });

  // JSON'dan Support nesnesi oluşturan fromJson fonksiyonu
  factory Support.fromJson(Map<String, dynamic> json) {
    return Support(
      url: json['url'],
      text: json['text'],
    );
  }
}
