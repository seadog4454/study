# コメントアウト
セミコロン";"を入れるだけ
```assembly
push eax ; こんな感じ
```

# PUSH, POP
スタックに挿入、取得
```assembly
push eax, pop, eax
```

# MOV
レジスタに代入
```assembly
mov eax, 2 ; 数字を直接入力することはイミディエイトと言うらしい
mov eax, ebx
```

# LEA
ポインタに紐づけされている変数の値を代入
```assembly
lea eax, dword ptr ss:[esi]
lea eax, dword ptr ds:[esi]
```
因みに、movを使った場合だと、アドレスそのもの代入することになるので注意。
例えばc言語とかでいうと、以下のようになる。
以下で示す内容はprintfで画面に出力される値を例にしている。

```c
int t = 0;
int *p;
p = &t;
printf("%p", p); // これがmov
printf("%d", *p) //こっちがlea
```

# ADD
レジスタに値を加算する
```assembly
add eax, 3
```

# SUB
レジスタに値を減算する
```assembly
sub eax, 3
```
# INT
割り込み命令。使い方知らん

# CALL
関数を呼び出す命令。

# INC, DEC
* インクリメント、ディクリメント
```assembly
INC exa
```

# AND, OR, XOR
論理演算。因みに以下のような記述がある場合はたいてい、初期化処理。
```assembly
xor eax, eax　; exaがすべて0になる
```

# NOP
何もしない

# CMP, JMP
比較、ジャンプ。


