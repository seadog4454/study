# 診断コネクタの場所
車両にはODB-Ⅱといった内部ネットワークの診断リンクコネクタが搭載されている。:w
* ステアリングコラムの下
* ダッシュボードの接続しやすい場所
* アクセスパネルの後ろ
* その他

# CANの電圧
安定時は2.5Vになる。
そこから、1V加算、または減算される。




# ODB-Ⅱのピン配置
ODB-Ⅱは通信の規格として５つの機能を必ずつけるように定められている。
pin番号もiso規格で決まっているらしい。
isoは購入してないので、本当かどうかわから無いが、様々なところでそう書いてあるので、多分あっているだろう。

odbコネクタを売っている会社も言ってるんだから間違いない。

[https://www.outilsobdfacile.com/communication-norm-obd.php](https://www.outilsobdfacile.com/communication-norm-obd.php)

* PWM SAEJ1850 2,10pin
* VPW SAEJ1850 2pin
* K-line ISO9141-2 7pin
* L-line ISO14230 15pin
* CAN  ISO15765 6,14,pin


# CANの通信プロトコル
基本、通信のプロトコルはKWP, UDSが使用されているらしい。  

* KWP(keyword protocol) ISO14230

* UDS(unified diagnostic services) ISO14229

* OBD2(on-board diagnostics) ISO27145

* WWH-OBD(World Wide Harmonized- ODB) ISO27145

* J1929 SAE J1939

# CANのパケット
* SOF 1bit 送信の開始
* アービトレーション　ID 11bit IDを示す。拡張パケットでは29bitになる
* RTR 1bit データフレームとリモートフレームの区別
* id拡張 1bit 拡張パケットでは1を、標準では0を示す
* 予約(r0) 1bit　拡張パケットでは1を、標準では0を示す
* データ長(DLC) 4bit
* データ 8bit 
* CRC 15bit　サムチェック
* CRC デリミタ 1bit 　サムチェック終了
* ACKスロット 1bit 送信のお知らせ
* ACKデリミタ 1bit　送信終了
* EOF 7bit
* IFS(ITM) 3bit


