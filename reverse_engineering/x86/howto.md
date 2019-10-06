# 関数で一番初めにすること
これが関数の始まりと終わりなる。頭の中でうまく整理できていないので、とりあえず、こうなるって覚えておこう。
 ```assembly
 push ebp
 mov ebp, esp

 mov esp, ebp
 pop  ebp
 ```

# 関数の呼び出し規約
## cdecl
関数に飛ぶ前にスタックを積み、関数が終了したら、その分のスタックを呼び出し元で除去する。
以下、wkipediaのを参考にする。
```assembly
push c
push b
push a
call function
add esp, 12 ;スタック上の引数を除去
mov x, eax
```

## stdcall
retnで指定した数値分、スタックポインタをインクリメントする

```assembly
retn 12 ;的な感じ
```

# fastcall
高速関数呼び出し ECX EDXレジスタを経由して引数を操作する。引数が２より多い場合、どうするんだろ？

# thiscall
c++のクラスで用いられる呼び出し方式。オブジェクトのポインターをECXに入れるらしい。
c++のリバースエンジニアリングしたことないからわからない・・・・。


