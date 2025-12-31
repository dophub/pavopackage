package com.dop.pavopackage.pavopackage;

public enum PrinterError {

    PRINT_FAIL(-1001, "Yazdırma başarısız"),
    ADD_STR_FAIL(-1002, "Metin arabelleği ayarlanamadı"),
    ADD_IMG_FAIL(-1003, "Görsel arabelleği ayarlanamadı"),
    BUSY(-1004, "Yazıcı şu anda meşgul"),
    PAPER_LACK(-1005, "Yazıcıda kağıt yok"),
    WRONG_PACKAGE(-1006, "Yazdırma paketi hatalı"),
    FAULT(-1007, "Yazıcı arızası"),
    TOO_HOT(-1008, "Yazıcı aşırı ısındı"),
    UNFINISHED(-1009, "Yazdırma tamamlanamadı"),
    NO_FONT(-1010, "Yazıcıda yazı tipi bulunamadı"),
    OUT_OF_MEMORY(-1011, "Yazdırma verisi çok büyük"),
    OTHER(-1999, "Bilinmeyen yazıcı hatası");

    public final int code;
    public final String message;

    PrinterError(int code, String message) {
        this.code = code;
        this.message = message;
    }

    public static String fromCode(int code) {
        for (PrinterError e : values()) {
            if (e.code == code) return e.message;
        }
        return "Unknown printer error (" + code + ")";
    }
}
