INCLUDE Irvine32.inc
BUFMAX = 128     	; maximum buffer size

.data
msg1  BYTE  "Enter the your string: ",0
mystring   BYTE   BUFMAX+1 DUP(?) ;儲存輸入文字
myupper   BYTE   BUFMAX+1 DUP(?)  ;儲存變大寫的文字
ans   BYTE   2 DUP(?) ;最後回答Y/n的文字
msg2  BYTE  "Morse Code: ",0
spas  BYTE  " ",0 
msg3  BYTE  "Would you like to proceed another translation (y/n)?",0
mymorse   DWORD  30 DUP(?) ;暫存摩斯密碼的地方
strSize  DWORD  ?          ;輸入文字的長度
i  DWORD  000000000h       ;用於位置計算的變數

;A-Z Letter
letter_table DWORD "_.", "..._","._._",".._",".","._..",".__","....","..","___.","_._",".._.","__","._","___",".__.","_.__","._.","...","_","_..","_...","__.","_.._","__._","..__"
;0-9 Digit
zero BYTE  "_____",0
one BYTE  ".____",0
two BYTE  "..___",0
three BYTE  "...__",0
four BYTE  "...._",0
five BYTE  ".....",0
six BYTE  "_....",0
seven BYTE  "__...",0
eight BYTE  "___..",0
nine BYTE  "____.",0

;Punctuation
Period BYTE  "._._._",0
Comma BYTE  "__..__",0
QuestionMark BYTE  "..__..",0
ParenthesesL BYTE  "_.__. ",0
ParenthesesR BYTE  "_.__._",0
Apostrophe  BYTE  ".____.",0
Semicolon BYTE  "_._._.",0
Colon BYTE  "___...",0
QuotationMarks BYTE  "._.._.",0
Hyphen BYTE  "_...._",0
FractionBar BYTE  "_.._.",0
DollarSign BYTE  "..._.._",0
Other BYTE  "@",0
Space BYTE  "/",0
;-----------------------------------------------------
.code
MorseTran PROC
    pushad
    mov esi,OFFSET myupper  ;用來讀取upper的字串
    mov ecx,strSize
L1: mov al,[esi]            ;若[esi]範圍落在A~Z，去找對應的Morse
    cmp al,'A'              ;若沒落在此範圍內代表不是letter，就去看是否為數字(Digit)
    jae ckZ                 ;[esi]>=A
    jb not_letter           ;[esi]<A (不是字母)

ckZ:cmp al,'Z'
    jbe Find                ;[esi]<=Z
    jmp not_letter          ;[esi]>Z (不是字母)
Find:
    sub al,41h              ;看是第幾個字母
    add BYTE PTR i,al
    mov eax,i
    mov edx,4
    mul edx
    mov	ebx,letter_table[eax] ;eax為該字母對應的Morse位置
    mov mymorse,ebx
    mov edx,OFFSET mymorse    ;輸出
    call WriteString
    jmp qt
not_letter:                 ;若不為字母，檢查是否為數字
    cmp al,'0'
    jae ck9
    jmp not_digit
ck9:cmp al,'9'
    jbe is_Digit
    jmp not_digit
is_Digit:                   ;若是數字，去DIGIT
    call DIGIT
    jmp qt
not_digit:                  ;若不為數字，去Punctuation(符號)
    call Punctuation

qt: mov i,0
    mov edx,OFFSET spas
    call WriteString
    mov mymorse,0
    inc esi
    loop L1
    popad
    ret
MorseTran ENDP
;-----------------------------------------------------
DIGIT PROC
    pushad
    mov ecx,10        ;迴圈10 0-9
    mov i,30h         ;i=00000030
    mov al,[esi]
L1: cmp al,BYTE PTR i ;找為0-9中的哪個
    je Find0
    add i,1
    loop L1
Find0:
    mov eax,i
    sub eax,30h     ;eax-30=該數字
    cmp eax,0       ;比較0
    je out0         ;若符號跳至out0(輸出該數字的Morse)       
    ja Find1        ;否則繼續往下找
Find1:
    cmp eax,1
    je out1
    ja Find2
Find2:
    cmp eax,2
    je out2
    ja Find3
Find3:
    cmp eax,3
    je out3
    ja Find4
Find4:
    cmp eax,4
    je out4
    ja Find5
Find5:
    cmp eax,5
    je out5
    ja Find6
Find6:
    cmp eax,6
    je out6
    ja Find7
Find7:
    cmp eax,7
    je out7
    ja Find8
Find8:
    cmp eax,8
    je out8
    ja Find9
Find9:
    cmp eax,9
    je out9
    jmp qt
out0:
    mov edx,OFFSET zero
    jmp qt
out1:
    mov edx,OFFSET one
    jmp qt
out2:
    mov edx,OFFSET two
    jmp qt
out3:
    mov edx,OFFSET three
    jmp qt
out4:
    mov edx,OFFSET four
    jmp qt
out5:
    mov edx,OFFSET five
    jmp qt
out6:
    mov edx,OFFSET six
    jmp qt
out7:
    mov edx,OFFSET seven
    jmp qt
out8:
    mov edx,OFFSET eight
    jmp qt
out9:
    mov edx,OFFSET nine
    jmp qt
qt: call WriteString
    popad
    ret
DIGIT ENDP
;-----------------------------------------------------
Punctuation PROC
    mov al,[esi]
    pushad
Find0:
    cmp eax,' '
    je out0
Find1:
    cmp eax,'.'
    je out1
Find2:
    cmp eax,','
    je out2
Find3:
    cmp eax,'?'
    je out3
Find4:
    cmp eax,'('
    je out4
Find5:
    cmp eax,')'
    je out5
Find6:
    cmp eax,"'"
    je out6
Find7:
    cmp eax,";"
    je out7
Find8:
    cmp eax,':'
    je out8
Find9:
    cmp eax,'"'
    je out9
Find10:
    cmp eax,'-'
    je out10
Find11:
    cmp eax,'/'
    je out11
Find12:
    cmp eax,'$'
    je out12
    jmp other1
out0:
    mov edx,OFFSET Space
    jmp qt
out1:
    mov edx,OFFSET Period
    jmp qt
out2:
    mov edx,OFFSET Comma
    jmp qt
out3:
    mov edx,OFFSET QuestionMark
    jmp qt
out4:
    mov edx,OFFSET ParenthesesL
    jmp qt
out5:
    mov edx,OFFSET ParenthesesR
    jmp qt
out6:
    mov edx,OFFSET Apostrophe
    jmp qt
out7:
    mov edx,OFFSET Semicolon
    jmp qt
out8:
    mov edx,OFFSET Colon
    jmp qt
out9:
    mov edx,OFFSET QuotationMarks
    jmp qt
out10:
    mov edx,OFFSET Hyphen
    jmp qt
out11:
    mov edx,OFFSET FractionBar
    jmp qt
out12:
    mov edx,OFFSET DollarSign
    jmp qt
other1:
    mov edx,OFFSET Other
    jmp qt
qt: call WriteString
    popad
    ret
Punctuation ENDP
;-----------------------------------------------------
lowertoCap PROC
    pushad          
    mov esi, OFFSET mystring                 
    mov edi, OFFSET myupper                  
    mov ecx, strSize          ; 長度

L1: mov al, [esi]                 
    cmp al, 0                 ; 檢查是否到達結尾
    je do                     ; 如果是，結束循環

    cmp al, 'a'               ; 檢查是否為小寫字母
    jb A1                     ; 如果小於 'a'，跳過轉換
    cmp al, 'z'
    ja A1
    sub al, 32                ; 若a<=[esi]<=z 將小寫字母轉換為大寫字母

A1: mov [edi], al                 
    inc esi                       
    inc edi                       
    loop L1             
do: mov BYTE PTR [edi], 0     ;確保輸出以 NULL 結尾
    popad                         
    ret
lowertoCap ENDP
;-----------------------------------------------------
InputTheString PROC
	pushad
	mov	ecx,BUFMAX		    
	mov	edx,OFFSET mystring ; 將輸入文字存到mystring
	call ReadString         ; 輸入
	mov	strSize,eax        	; 儲存文字長度
	popad
	ret
InputTheString ENDP
;-----------------------------------------------------
main PROC
beginwhile:
    mov	edx,OFFSET msg1	;輸出enter your string
	call WriteString
	call InputTheString ;輸入文字

	call lowertoCap     ;小寫變大寫的副程式
   
    call Crlf
    mov	edx,OFFSET msg2	;輸出我的Morse
	call WriteString
    call MorseTran      ;輸出Morse的副程式

    call Crlf
    mov	edx,OFFSET msg3	;是否再一次?
	call WriteString
    mov	ecx,2
    mov edx,OFFSET ans
    call ReadString     ;輸入Y/n
    mov al,ans
    cmp al,'Y'          ;若為Y 再進一次迴圈，若否就跳出迴圈並結束程式
    je beginwhile
endwhile:

	exit
main ENDP
END main