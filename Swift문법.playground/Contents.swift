import UIKit


/* 1. 변수와 상수 선언 */
// 1.1 상수
let name: String = "Uno"
let swift = "Swift"

// 1.2 변수
var year: Int = 2022 // type 결정
var y = 2022 // type 추론하도록 함

year = 2023 // (변수이기 때문에) 값 변경 가능

//print(year)

/* 2. 함수만들기 */
func sum(a: Int, b: Int) -> Int {
    return a + b
}

//print(sum(a: 1, b:2))

func multiply(a: Int, b: Int) -> Int {
    a * b
}

//print(multiply(a: 10, b: 10))

/* 3. 이름 짓기 */
// 3.1 Lower Camel Case(라는 규칙으로 이름을 정함) - 인스턴스 / 메소드 / 함수 를 생성할 때 주로 사용
// - 시작은 소문자 나머지 단어의 시작은 대문자라는 뜻 (Lower Camel Case)
let viewController = UIViewController()


// 3.2 Upper Camel Case - 구조체 / 클래스 / 프로토콜
// - 시작과 나머지 단어도 모두 대문자.
struct Person {
    let a: Int
    let b: Int // 구조체 내부에 상수 선언
}

class Operator {
    let a: Int
    let b: Int // 외부에서 호출된 값을 내부에 있는 a,b에 할당
    
    // 초기화 함수 : 클래스 인스턴스가 생성될 때 최초에 호출되는 함수
    init(a: Int, b: Int) {
        self.a = a
        self.b = b
    } // 외부에서 호출됨
}

// 프로토콜 선언
protocol Flyable {
    func fly() // 어떤 메세징을 보낼지만 선언 -> 구체적인 선언은 클래스, 구조체 내부에서 해당 프로토콜을 채택한 객체가 직접 구현
}
