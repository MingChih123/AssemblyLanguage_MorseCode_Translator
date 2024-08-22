# Assembly Language
姓名： 李名智  
學號：1102924  
## MorseCode Translator
### 介紹
由組合語言來製作一個摩斯密碼轉換器，他會將輸入字串轉為大寫後在進行轉換過程，其中若輸入為定義的符號等等則為以"@"來表示，另外因x86為little-endian而當輸入英文字母A-Z時須將摩斯密碼反過來存，這樣輸出會是正確的。最後設計是否繼續轉換，若回答"Y"則可以繼續輸入字串，否則結束程式。
### 程式說明
主要分為：（[詳細說明](https://github.com/MingChih123/AssemblyLanguage_MorseCode_Translator/blob/main/Morse%20Code%20Translator%E7%A8%8B%E5%BC%8F%E8%AA%AA%E6%98%8E.pdf)）  
**1. DATA**  
  - 儲存字母A-Z、數字0-9、各種符號的摩斯密碼


**2. 主程式**  
  - 呼叫以下副程式


**3. 副程式**  
  - InputTheString：輸入文字
  - lowertoCap：將字串全轉為大寫
  - MorseTran：用於輸出 A-Z Morse
  - DIGIT：用於輸出 0-9 Morse
  - Punctuation：用於輸出各種符號的 Morse  

### 結果呈現
![image](https://github.com/user-attachments/assets/89ef6033-f096-4547-a3f6-92565ab13547)
