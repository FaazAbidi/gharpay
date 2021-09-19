class Session {
  DateTime createdAt;
  String accessToken;

  Session({this.createdAt, this.accessToken});
}

enum Status { inProgress, successful, failed, cancelled }

class Transaction {
  String senderUserId;
  String receiverUserId;
  String senderName;
  String receiverName;
  String senderCurrency;
  String receiverCurrency;
  double sentAmount;
  double exchangeRate;
  DateTime time;
  Status status;

  Transaction(
      {this.senderUserId,
        this.receiverUserId,
        this.senderName,
        this.receiverName,
        this.senderCurrency,
        this.receiverCurrency,
        this.sentAmount,
        this.exchangeRate,
        this.time,
        this.status});
}

enum Company {Visa, MasterCard}
class Card {
  String name;
  DateTime expiryDate;
  String cvv;
  String no;
  Company company;

  Card({this.name, this.expiryDate, this.cvv, this.no, this.company});
}

class Payee {
  String mobileNo;
  String cnic;
  String name;
  String image;

  Payee({this.mobileNo, this.cnic, this.name, this.image});
}

enum UserType { sender, receiver }
enum MobileNetwork { ufone, jazz, telenor, zong }

class User {
  static User instance;
  String uid;
  List<Transaction> transactions;
  List<Card> cards;
  List<Payee> payees;
  UserType userType;
  double hraWalletBalance;
  double jsWalletBalance;
  String phone;
  String cnic;
  MobileNetwork mobileNetwork;
  String email;
  Transaction lastTransaction;
  String name;
  String image;

  User(
      {this.uid,
        this.transactions,
        this.cards,
        this.payees,
        this.userType,
        this.hraWalletBalance,
        this.jsWalletBalance,
        this.phone,
        this.cnic,
        this.mobileNetwork,
        this.email,
        this.lastTransaction,
        this.name,
        this.image});
}

class NetworkProvider {
  static Future<void> delay() async {
    await Future.delayed(Duration(seconds: 4));
  }

  static Future<void> login(String email, String password) async {
    await delay();
    User tempUser = userDatabase.firstWhere(
            (element) => element.email == email && password == demoPassword,
        orElse: () {
          throw Exception("Username and password is incorrect");
        });
    User.instance = User();
    User.instance.uid = tempUser.uid;
    User.instance.email = tempUser.email;
  }

  static User _getCurrentUser() {
    return userDatabase
        .firstWhere((element) => element.uid == User.instance.uid, orElse: () {
      throw Exception("Not Logged In");
    });
  }

  static getCurrentUserTransactions() async {
    await delay();
    User.instance.transactions = _getCurrentUser().transactions;
  }

  static getCurrentUserCards() async {
    await delay();
    User.instance.cards = _getCurrentUser().cards;
  }

  static getCurrentUserPayee() async {
    await delay();
    User.instance.payees = _getCurrentUser().payees;
  }

  static getCurrentUserOverview() async {
    await delay();
    if (User.instance.userType == UserType.receiver) {
      User.instance.jsWalletBalance = _getCurrentUser().jsWalletBalance;
      User.instance.hraWalletBalance = _getCurrentUser().hraWalletBalance;
    } else {
      User.instance.lastTransaction = _getCurrentUser().transactions.last;
    }
  }

  static getCurrentUserLegalInfo() async {
    await delay();
    User.instance.cnic = _getCurrentUser().cnic;
    User.instance.mobileNetwork = _getCurrentUser().mobileNetwork;
    User.instance.phone = _getCurrentUser().phone;
  }
}

main() {}

final List<User> userDatabase = [
  User(
      userType: UserType.receiver,
      uid: "0001",
      cnic: "42201-XXXXXXX-7",
      name: "Asad Raza",
      email: "asad_raza@email.com",
      mobileNetwork: MobileNetwork.ufone,
      jsWalletBalance: 5500,
      hraWalletBalance: 16580,
      phone: "0333-XXXXX66",
      image: 'images/Asad Raza.gif',
      transactions: [
        Transaction(
            receiverUserId: "0001",
            senderUserId: "003",
            senderName: "Abuzar Rasool",
            receiverName: "Asad Raza",
            receiverCurrency: "PKR",
            senderCurrency: "USD",
            exchangeRate: 160.8,
            sentAmount: 50,
            time: DateTime(2021, 1, 16),
            status: Status.successful),
        Transaction(
            receiverUserId: "0001",
            senderUserId: "004",
            senderName: "Syed Hasan Faaz Abidi",
            receiverName: "Asad Raza",
            receiverCurrency: "PKR",
            senderCurrency: "USD",
            exchangeRate: 166.5,
            sentAmount: 75,
            time: DateTime(2021, 5, 12),
            status: Status.inProgress),
        Transaction(
            receiverUserId: "0001",
            senderUserId: "003",
            senderName: "Abuzar Rasool",
            receiverName: "Asad Raza",
            receiverCurrency: "PKR",
            senderCurrency: "AUD",
            exchangeRate: 154.1,
            sentAmount: 475,
            time: DateTime(2021, 3, 26),
            status: Status.failed),
        Transaction(
            receiverUserId: "0001",
            senderUserId: "004",
            senderName: "Syed Hasan Faaz Abidi",
            receiverName: "Asad Raza",
            receiverCurrency: "PKR",
            senderCurrency: "EUR",
            exchangeRate: 186.5,
            sentAmount: 300,
            time: DateTime(2021, 7, 1),
            status: Status.cancelled),]),
  User(
      userType: UserType.receiver,
      uid: "0002",
      cnic: "42000-XXXXXXX-9",
      name: "Hussain Abbas",
      email: "hussain_abbas@email.com",
      mobileNetwork: MobileNetwork.jazz,
      jsWalletBalance: 56.78,
      hraWalletBalance: 5760,
      phone: "0334-XXXXX80",
      image: 'images/Hussain Abbas.gif',
      transactions: [
        Transaction(
            receiverUserId: "0002",
            senderUserId: "003",
            senderName: "Abuzar Rasool",
            receiverName: "Hussain Abbas",
            receiverCurrency: "PKR",
            senderCurrency: "AED",
            exchangeRate: 38.2,
            sentAmount: 500,
            time: DateTime(2021, 2, 1),
            status: Status.cancelled),
        Transaction(
            receiverUserId: "0002",
            senderUserId: "004",
            senderName: "Syed Hasan Faaz Abidi",
            receiverName: "Hussain Abbas",
            receiverCurrency: "PKR",
            senderCurrency: "AED",
            exchangeRate: 42.3,
            sentAmount: 76,
            time: DateTime(2021, 6, 22),
            status: Status.successful),
        Transaction(
            receiverUserId: "0002",
            senderUserId: "003",
            senderName: "Abuzar Rasool",
            receiverName: "Hussain Abbas",
            receiverCurrency: "PKR",
            senderCurrency: "INR",
            exchangeRate: 2.2,
            sentAmount: 15000,
            time: DateTime(2021, 4, 27),
            status: Status.inProgress),
        Transaction(
            receiverUserId: "0002",
            senderUserId: "004",
            senderName: "Syed Hasan Faaz Abidi",
            receiverName: "Hussain Abbas",
            receiverCurrency: "PKR",
            senderCurrency: "CAD",
            exchangeRate: 127.5,
            sentAmount: 175,
            time: DateTime(2021, 8, 22),
            status: Status.inProgress)
      ]),
  User(
      userType: UserType.sender,
      uid: "0003",
      name: "Abuzar Rasool",
      email: "abuzar_rasool@email.com",
      phone: "0654-XXXXX76",
      image: "images/Abuzar Rasool.gif",
      payees: [
        Payee(
            name: "Asad Raza",
            cnic: "42201-XXXXXXX-7",
            mobileNo: "0333-XXXXX66",
            image: "images/Asad Raza.gif"
        ),
        Payee(
            name: "Hussain Abbas",
            cnic: "42000-XXXXXXX-9",
            mobileNo: "0334-XXXXX80",
            image: "images/Hussain Abbas.gif"
        ),
        Payee(
            name: "Amma",
            mobileNo: "0321-XXXXX43",
            cnic: "42101-XXXXXXX-4",
            image: "images/Amma.gif"
        )
      ],
      cards: [
        Card(
            name: "Abuzar Rasool",
            no: "4588 26XX XXXX XX73",
            company: Company.Visa,
            cvv: "975",
            expiryDate: DateTime(2024,05)
        )],
      transactions: [
        Transaction(
            receiverUserId: "0001",
            senderUserId: "003",
            senderName: "Abuzar Rasool",
            receiverName: "Asad Raza",
            receiverCurrency: "PKR",
            senderCurrency: "USD",
            exchangeRate: 160.8,
            sentAmount: 50,
            time: DateTime(2021, 1, 16),
            status: Status.successful),
        Transaction(
            receiverUserId: "0002",
            senderUserId: "003",
            senderName: "Abuzar Rasool",
            receiverName: "Hussain Abbas",
            receiverCurrency: "PKR",
            senderCurrency: "AED",
            exchangeRate: 38.2,
            sentAmount: 500,
            time: DateTime(2021, 2, 1),
            status: Status.cancelled),
        Transaction(
            receiverUserId: "0001",
            senderUserId: "003",
            senderName: "Abuzar Rasool",
            receiverName: "Asad Raza",
            receiverCurrency: "PKR",
            senderCurrency: "AUD",
            exchangeRate: 154.1,
            sentAmount: 475,
            time: DateTime(2021, 3, 26),
            status: Status.failed),
        Transaction(
            receiverUserId: "0002",
            senderUserId: "003",
            senderName: "Abuzar Rasool",
            receiverName: "Hussain Abbas",
            receiverCurrency: "PKR",
            senderCurrency: "INR",
            exchangeRate: 2.2,
            sentAmount: 15000,
            time: DateTime(2021, 4, 27),
            status: Status.inProgress)
      ]),
  User(
      userType: UserType.sender,
      uid: "0004",
      name: "Syed Hasan Faaz Abidi",
      email: "hasan_faaz@email.com",
      phone: "0453-XXXXX23",
      image: "images/Syed Hasan Faaz Abidi.gif",
      payees: [
        Payee(
            name: "Asad Raza",
            cnic: "42201-XXXXXXX-7",
            mobileNo: "0333-XXXXX66",
            image: "images/Asad Raza.gif"
        ),
        Payee(
            name: "Hussain Abbas",
            cnic: "42000-XXXXXXX-9",
            mobileNo: "0334-XXXXX80",
            image: "images/Hussain Abbas.gif"
        ),
        Payee(
          name: "Amma",
          mobileNo: "0321-XXXXX43",
          cnic: "42101-XXXXXXX-4",
          image: "images/Amma.gif"
        )
      ],
      cards: [
        Card(
            name: "Syed Hasan Faaz Abidi",
            no: "9628 43XX XXXX XX91",
            company: Company.MasterCard,
            cvv: "803",
            expiryDate: DateTime(2025,03)
        )],
      transactions: [
        Transaction(
            receiverUserId: "0001",
            senderUserId: "004",
            senderName: "Syed Hasan Faaz Abidi",
            receiverName: "Asad Raza",
            receiverCurrency: "PKR",
            senderCurrency: "USD",
            exchangeRate: 166.5,
            sentAmount: 75,
            time: DateTime(2021, 5, 12),
            status: Status.inProgress),
        Transaction(
            receiverUserId: "0002",
            senderUserId: "004",
            senderName: "Syed Hasan Faaz Abidi",
            receiverName: "Hussain Abbas",
            receiverCurrency: "PKR",
            senderCurrency: "AED",
            exchangeRate: 42.3,
            sentAmount: 76,
            time: DateTime(2021, 6, 22),
            status: Status.successful),
        Transaction(
            receiverUserId: "0001",
            senderUserId: "004",
            senderName: "Syed Hasan Faaz Abidi",
            receiverName: "Asad Raza",
            receiverCurrency: "PKR",
            senderCurrency: "EUR",
            exchangeRate: 186.5,
            sentAmount: 300,
            time: DateTime(2021, 7, 1),
            status: Status.failed),
        Transaction(
            receiverUserId: "0002",
            senderUserId: "004",
            senderName: "Syed Hasan Faaz Abidi",
            receiverName: "Hussain Abbas",
            receiverCurrency: "PKR",
            senderCurrency: "CAD",
            exchangeRate: 127.5,
            sentAmount: 175,
            time: DateTime(2021, 8, 22),
            status: Status.inProgress)
      ])
];

const String demoPassword = "1234";
