
> ### what_is_flutter_api
>> Dart언어와 dart_frog 프레임워크를 사용하여 백엔드 API 역활을 수행하며,<br> 앱과 디바이스 간의 상호 작용을 담당하는 코어 백엔드 시스템입니다.
> 
>
> <div style="background-color: #ffe6e6; color: #cc0000; padding: 10px; border-radius: 10px">
> **경고:** <br>서버와 접속하기 위해서는 반드시 _connect() 함수에서 서버 설정을 사용하는 서버의 DB설정과 동일하게 맞추어줘야 연결됩니다.<br><br>아래 입력부 코드 참고 요망
> </div>
>ㅤ<pre>what_is_flutter_pack/what_is_flutter_api/<br>lib/database/sql_client.dart (21~37 line)
>
>><code> Future\<void> _connect() async {
    _connection = await MySQLConnection.createConnection(
      // "localhost" OR 127.0.0.1
      host: '서버 도메인 혹은 IP',
      // Your MySQL port
      port: 3306,
      // MySQL userName
      userName: '사용자 이름',
      // MySQL Database password
      password: '사용자 비밀번호',
      // your database name
      databaseName: '접속하고자 하는 DB 이름',
    );
    await _connection?.connect();
  }
></code></pre>


