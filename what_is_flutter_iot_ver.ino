#include <NTPClient.h>  //와이파이 실시간
#include <WiFiUdp.h> //와이파이 실시간
#include <WiFiManager.h> //와이파이 매니저 
#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <WiFiClient.h>
#include <ESP8266WiFiMulti.h>
#include <Arduino_JSON.h> //JSON 라이브러리

WiFiManager wifiManager;  //와이파이매니저
WiFiUDP ntpUDP;  //와이파이 실시간
NTPClient timeClient(ntpUDP, "pool.ntp.org", 3600 * 9, 60000);
String realtime;
// 하위 경로에 지정된 디바이스 ID 입력
String serverNameSend = "http://core.apis.ctrls-studio.com/iot/18237191";

const int LED_PIN = 15; // LED를 제어할 핀 설정

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  wifiManager.autoConnect("ESP8266_AP"); //WiFiManager를 사용하여 AP에 연결
  Serial.println("Connected to Wi-Fi");

  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
  timeClient.begin(); //NTPClient를 사용하여 실시간 시간 동기화
  pinMode(LED_PIN, OUTPUT); // LED_PIN을 출력으로 설정
}

void loop() {
  // put your main code here, to run repeatedly:
  timeClient.update(); // 시간 업데이트
  realtime = timeClient.getFormattedTime(); // 현재 시간을 문자열로 가져옴
  Serial.println(realtime); // 시리얼 모니터에 현재 시간 출력

  // API로 LED를 제어하는 함수 호출
  controlLED();

  delay(1000); // 1초 대기
}

void controlLED() {
  HTTPClient http; // HTTPClient 객체 생성
  WiFiClient client;

  // API에 GET 요청 보내기
  http.begin(client, serverNameSend); // 서버 URL 설정
  int httpResponseCode = http.GET(); // GET 요청 보내기

  // 서버 응답 코드 확인
  if (httpResponseCode > 0) {
    // 응답 데이터가 있는 경우
    String response = http.getString();
    Serial.println(response);

    // JSON 데이터 파싱
    JSONVar json = JSON.parse(response);

    // JSON 데이터에서 'sensor_status' 값 가져오기
    int sensorStatus = json["sensor_status"];
    Serial.printf("sensorStatus : %d\n", sensorStatus);
    // LED 제어
    if (sensorStatus == 1) {
      Serial.println("LED ON");
      digitalWrite(LED_PIN, HIGH); // LED 켜기
    } 
    if (sensorStatus == 0) {
      Serial.println("LED OFF");
      digitalWrite(LED_PIN, LOW); // LED 끄기
    }
  } else {
    Serial.print("Error on HTTP request: ");
    Serial.println(httpResponseCode);
  }

  // HTTP 연결 닫기
  http.end();
}
