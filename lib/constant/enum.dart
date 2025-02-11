enum PVStatusId {
  Suspended(1), //	Satış askıya alındı
  PaymentWaiting(2), //	Ödeme bakliyor
  DocumentCreating(3), //	Döküman oluşturuluyor
  DocumentPending(4), //	Döküman bekleniyor
  DocumentCreated(5), //	Döküman oluşturuldu
  Completed(6), //	Tamamlandı
  Abandoned(7), //	Satıştan vazgeçildi
  DocumentFailed(8), //	Döküman oluştırulamadı
  Signing(9), //	İmzalanıyor
  SigningFailed(10), //	İmzalama işlemi başarısız
  Cancalled(11), //	İptal edildi
  PaymentCancelling(12), //	Ödemeler iptal ediliyor
  PaymentCancelled(13), //	Ödemeler iptal edildi
  PaymentCancelFailed(14), //	Ödeme iptali geerçekleştirilemedi
  DocumentCancelling(15), //	Döküman iptal ediliyor
  DocumentCancelFailed(16), //	Döküman iptlai gerçekleştirilemedi
  DocumentCancelPending(17), //	Döküman iptali bekleniyor
  Signed(18), //	İmzalandı
  ERPProcessing(19), //	ERP operasyonlarında
  DocumentApproved(20), //	Döküman onaylandı
  DocumentNotApproved(21), //	Döküman onaylanmadı
  InspectionPending(22), //	Inspection bekleniyor
  UnCompletedSale(23); //	Tamamlanmamış satış

  final int id;

  const PVStatusId(this.id);
}

// Kart ekranında görüntülenmesi istenilen slot tipleridir. Gönderilmediği veya boş [] gönderildiği durumda tüm slotlar gösterilir. Geçerli slot tipleri -> “rf” Temassız, “icc” Çip, “magneticStripe” Manyetik, “qr” Karekod, “manual” Manuel.
enum PVPaymentSlotType { rf, icc, magneticStripe, qr, manual }

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

enum PaymentStatusId {
  WaitingPayment(1), // Ödeme bekleniyor
  Completed(2), // Ödeme işlemi tamamlandı
  Failed(3), // Ödeme işlemi tamamlanamadı.
  WaitingCancel(4), // Ödeme iptali bekleniyor
  Cancelled(5), // Ödeme iptal edildi
  CancelFailed(6), // İptal işlemi yapılamadı
  Abandoned(7), // Ödeme terk edildi
  CancelAbandoned(8), // Ödeme iptali terk edildi
  InProgress(9), // Ödeme işleminde
  CompletePayment(10), // Ödeme alındı
  FailPayment(11), // Ödeme başarısız
  CompleteCancel(12), // Ödeme iptali tamamlandı
  FailCancel(13), // Ödeme iptali başarısız
  Abandon(14), // Ödeme terk ediliyor
  WaitingForReversal(15), // Reversal işlemler için bekleniyor
  CancelPending(16); // Ödeme iptali bekleniyor

  final int id;

  const PaymentStatusId(this.id);
}
