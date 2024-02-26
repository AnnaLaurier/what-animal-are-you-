//
//  Quastion.swift
//  what animal are you?
//
//  Created by Anna Lavrova on 08.02.2024.
//

struct Question {
    let title: String
    let answers: [Answer]
    let type: ResponseType

    static func getQuestions() -> [Question] {
        [
            Question(
                title: "Какую пищу вы предпочитаете?",
                answers: [
                    Answer(title: "Стейк", animal: .dog),
                    Answer(title: "Рыба", animal: .cat),
                    Answer(title: "Морковь", animal: .rabbit),
                    Answer(title: "Кукуруза", animal: .turtle)
                ],

                type: .single
            ),

            Question(
                title: "Что вам нравится больше?",
                answers: [
                    Answer(title: "Плавать", animal: .dog),
                    Answer(title: "Спать", animal: .cat),
                    Answer(title: "Обниматься", animal: .rabbit),
                    Answer(title: "Есть", animal: .turtle)
                ],

                type: .multiple
            ),
            
            Question(
                title: "Любите ли вы поездки на машине?",
                answers: [
                    Answer(title: "Ненавижу", animal: .cat),
                    Answer(title: "Нервничаю", animal: .rabbit),
                    Answer(title: "Не замечаю", animal: .turtle),
                    Answer(title: "Обожаю", animal: .dog)
                ],
                type: .ranged
            )
        ]
    }
}

struct Answer {
    let title: String
    let animal: Animal
}

enum ResponseType {
    case single
    case multiple
    case ranged
}

enum Animal: Character {
    case dog = "🐶"
    case cat = "😺"
    case rabbit = "🐰"
    case turtle = "🐢"

    var definition: String {
        switch self {
        case .dog:
            return "Вам нравится мясо и гулять"
        case .cat:
            return "Вы любите лежать на солнце и есть рыбу"
        case .rabbit:
            return "Вы очень быстро принимаете решения"
        case .turtle:
            return "Вы довольно размеренно живете свою жизнь"
        }
    }
}
