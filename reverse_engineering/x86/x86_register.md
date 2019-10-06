# 各種汎用レジスタ説明
## EAX
Accumuator register ：　算術操作(add eax, ebx .etc)と戻り値(rtn)が格納される

## EBX
Base register　：　よく知らない

## ECX
Counter register　：　ループ命令で使う

## EDX
Data register ：　算術操作(add eax, ebx .etc)等で用いる。要はただの変数

## ESI, EDI
Source index, Destination index　：　現アドレス、宛先アドレス。少し違うかも・・・・

# ESP
stack pointer　：　スタックにアクセスするためのレジスタ。
* スタックの一番上のアドレスが格納されている。
* 例えばpush等でレジスタの値をスタックに投げた場合、espレジスタを用いてアクセスする。
* pushでスタックにデータが挿入されると、espの示すアドレスが変化する

# EBP
base register　：　スタックの底にアクセスするためのレジスタ。
* スタックの一番下のアドレスが格納されている。
* 現在実行されている関数のスタック領域の底
* 実行している関数は当然実行最中に変更するので、関数を実行する最初と最後に値を変更する


# レジスタの下位、上位ビットのアクセス方法
例：
* EAX = 32bit
* AX = 16bit
* AH = 上位8bit
* AL = 下位8bit

```
|---------------EAX(32bit)--------------------|
                    |--------AX(16bit)^-------|
                    |--AH(8bit)--|--AL(8bit)--|

```

他の汎用レジスタも同様にX, H, Lがつくだけ。

# セグメントレジスタ
## ss
stack segment　：　スタックのポインタ。引数とかの時に使われる印象。まぁスタックって言ってるんだしそうだよな。
## cs
code segment　：　コードのポインタ。これは見たことない・・・。
## DS
data segment　：　データのポインタ。よく見るんだけど、何だったか忘れた。
