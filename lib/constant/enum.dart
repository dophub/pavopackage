enum PavoAppType {
  nKolay('tr.com.overtech.overpay_nkolay'),
  pavo('tr.com.overtech.overpay_pos');

  final String packageName;

  const PavoAppType(this.packageName);
}

enum PVStatusId {
  Suspended(1, 'Satış Askıya Alındı'),
  PaymentWaiting(2, 'Ödeme Bekleniyor'),
  DocumentCreating(3, 'Döküman Oluşturuluyor'),
  DocumentPending(4, 'Döküman Bekleniyor'),
  DocumentCreated(5, 'Döküman Oluşturuldu'),
  Completed(6, 'Tamamlandı'),
  Abandoned(7, 'Satıştan Vazgeçildi'),
  DocumentFailed(8, 'Döküman Oluşturulamadı'),
  Signing(9, 'İmzalanıyor'),
  SigningFailed(10, 'İmzalama Başarısız'),
  Cancalled(11, 'İptal Edildi'),
  PaymentCancelling(12, 'Ödeme İptali Gerçekleştiriliyor'),
  PaymentCancelled(13, 'Ödeme İptali Tamamlandı'),
  PaymentCancelFailed(14, 'Ödeme İptali Başarısız'),
  DocumentCancelling(15, 'Döküman İptali Gerçekleştiriliyor'),
  DocumentCancelFailed(16, 'Döküman İptali Başarısız'),
  DocumentCancelPending(17, 'Döküman İptali Bekleniyor'),
  Signed(18, 'İmzalandı'),
  ERPProcessing(19, 'ERP İşlemleri Devam Ediyor'),
  DocumentApproved(20, 'Döküman Onaylandı'),
  DocumentNotApproved(21, 'Döküman Onaylanmadı'),
  InspectionPending(22, 'İnceleme Bekleniyor'),
  UnCompletedSale(23, 'Tamamlanmamış Satış');

  final int id;
  final String title;

  const PVStatusId(this.id, this.title);
}

// Kart ekranında görüntülenmesi istenilen slot tipleridir. Gönderilmediği veya boş [] gönderildiği durumda tüm slotlar gösterilir. Geçerli slot tipleri -> “rf” Temassız, “icc” Çip, “magneticStripe” Manyetik, “qr” Karekod, “manual” Manuel.
enum PVPaymentSlotType { rf, icc, magneticStripe, qr, manual }

enum PVPrinterDataType { dSpace, dLine, dText }

enum PVPaymentType {
  Nakit(1),
  KrediKarti(2),
  YemekKarti(3),
  BankaKarti(6),
  TransferEFT(9),
  Fatura(10),
  CreditPayment(11),
  UlasimKarti(12),
  HediyeKarti(13),
  AcikHesap(14),
  Cek(18),
  Advance(20),
  Cuzdan(21),
  Diger(22);

  final int type;

  const PVPaymentType(this.type);
}

enum PaymentMediatorType {
  Nakit(1, PVPaymentType.Nakit),
  BKMTechPos(2, PVPaymentType.KrediKarti),
  Multinet(4, PVPaymentType.YemekKarti),
  HariciYemekKarti(10, PVPaymentType.YemekKarti),
  Metropol(13, PVPaymentType.YemekKarti),
  HariciOdemeSaglayici(14, PVPaymentType.Diger),
  Odemesiz(27, PVPaymentType.AcikHesap),
  HavaleEFT(28, PVPaymentType.AcikHesap),
  AcikHesap(29, PVPaymentType.AcikHesap),
  TicketRestaurant(30, PVPaymentType.YemekKarti),
  IsBankasi(31, PVPaymentType.KrediKarti),
  HariciKapaliDevre(32, PVPaymentType.Cek),
  Paye(33, PVPaymentType.YemekKarti),
  Macellan(34, PVPaymentType.Cuzdan),
  Istanbulkart(35, PVPaymentType.Cuzdan);

  final int type;
  final PVPaymentType paymentType;

  const PaymentMediatorType(this.type, this.paymentType);
}

enum PavoPaymentStatusId {
  WaitingPayment(1, 'Ödeme Bekleniyor'),
  Completed(2, 'Ödeme Tamamlandı'),
  Failed(3, 'Ödeme Başarısız'),
  WaitingCancel(4, 'İptal Bekleniyor'),
  Cancelled(5, 'İptal Edildi'),
  CancelFailed(6, 'İptal Başarısız'),
  Abandoned(7, 'Ödemeden Vazgeçildi'),
  CancelAbandoned(8, 'İptalden Vazgeçildi'),
  InProgress(9, 'Ödeme İşlemde'),
  CompletePayment(10, 'Ödeme Alındı'),
  FailPayment(11, 'Ödeme Başarısız'),
  CompleteCancel(12, 'İptal Tamamlandı'),
  FailCancel(13, 'İptal Başarısız'),
  Abandon(14, 'Ödemeden Vazgeçiliyor'),
  WaitingForReversal(15, 'Ters İşlem Bekleniyor'),
  CancelPending(16, 'İptal Bekleniyor');

  final int id;
  final String title;

  const PavoPaymentStatusId(this.id, this.title);
}
