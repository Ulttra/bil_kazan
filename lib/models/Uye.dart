class Uye
{
final String isim;
final String kod;

Uye({this.isim, this.kod});
Map<String, dynamic> toMap() {
  return {

    'isim': isim,
    'kod': kod,
  };
}

// Implement toString to make it easier to see information about
// each dog when using the print statement.
@override
String toString() {
  return 'Uye{isim: $isim, kod: $kod}';

}
}