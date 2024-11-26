# Домашние работы
<details>
<summary>HW3</summary>
  Когда-нибудь точно будет
</details>
<details>
<summary>HW4</summary>
  Когда-нибудь точно будет
</details>
<details>
<summary>HW5</summary>
  Когда-нибудь точно будет
</details>
<details>
<summary>HW6</summary>
  
  # Скриншоты кода
  ## hw6.s
  <img width="983" alt="Снимок экрана 2024-11-26 в 04 23 50" src="https://github.com/user-attachments/assets/cbdbfaac-16ca-453e-8d09-1ba86ca2dd92">
  <img width="981" alt="Снимок экрана 2024-11-26 в 04 24 12" src="https://github.com/user-attachments/assets/f9cfaad8-4fbe-44c2-af7b-3c771f4ba3ee">
  <img width="980" alt="Снимок экрана 2024-11-26 в 04 24 30" src="https://github.com/user-attachments/assets/a28b98e0-986d-4642-873a-d6f0b78cfb21">
  
  ## strncpy.s
  <img width="978" alt="Снимок экрана 2024-11-26 в 04 25 37" src="https://github.com/user-attachments/assets/2ca55a80-ade1-470f-94c9-dfc02282e0ee">
  
  ## macrolib.s
  Там полный ужас по количеству макросов, так что приложу только обертку strncpy
  <img width="981" alt="Снимок экрана 2024-11-26 в 04 28 51" src="https://github.com/user-attachments/assets/0ec5c187-74be-4bc7-8ebe-119266a2a7fb">
  # Вывод программы
  <img width="927" alt="Снимок экрана 2024-11-26 в 04 32 31" src="https://github.com/user-attachments/assets/c8559215-c68b-4000-b353-8a4e02383006">
  
  # Как работает программа
  Пользователь передает до 20 символьную строку(размер буффера), выводится эта строка, далее считается длина строки, выводится это число,
  и если длина строки меньше размера буффера, берется ее длина, иначе размер буффера.
  Далее проиходит посимвольное копирование строки до момента того как она закончится или длина скопированной строки превысит размер буффера, переданного как параметр,
  выводится скопированная строка и очищается место для копирования.
  Далее то же самое происходит с пре-генерированными строками: одной короткой (< 20 символов) и одной длинной (> 20 символов)
</details>
