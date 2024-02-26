//
//  QuestionsViewController.swift
//  what animal are you?
//
//  Created by Anna Lavrova on 26.02.2024.
//

import UIKit

class QuestionsViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionProgressView: UIProgressView!

    @IBOutlet weak var singleStackView: UIStackView!

    @IBOutlet var singleButtons: [UIButton]!
   
    @IBOutlet weak var multipleStackView: UIStackView!

    @IBOutlet var multipleLabels: [UILabel]!
    
    @IBOutlet var multipleSwitches: [UISwitch]!


    @IBOutlet weak var rangedStackView: UIStackView!

    @IBOutlet weak var rangesSlider: UISlider! {
        didSet {
            let answerCount = Float(currentAnswers.count - 1)
            rangesSlider.maximumValue = answerCount
            rangesSlider.value = answerCount / 2
        }
    }
    @IBOutlet weak var rangedButton: UIButton!

    @IBOutlet var rangedLabels: [UILabel]!
    
    private let questions = Question.getQuestions()
    private var questionIndex = 0
    private var currentAnswers: [Answer] {
        questions[questionIndex].answers
    }
    private var answersChosen: [Answer] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        <#code#>
//    }

    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        guard let buttonIndex = singleButtons.firstIndex(of: sender) else { return }
        let currentAnswer = currentAnswers[buttonIndex]
        answersChosen.append(currentAnswer)

        
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        for (multipleSwitch, answer) in zip(multipleSwitches, currentAnswers) {
            if multipleSwitch.isOn {
                answersChosen.append(answer)
            }
        }

        nextQuestion()
    }

    @IBAction func rangedAnswerButtonPressed() {
        let index = lrintf(rangesSlider.value)
        answersChosen.append(currentAnswers[index])

        nextQuestion()
    }
    
}

// MARK: - Private Methods
extension QuestionsViewController {
    private func updateUI() {
        for stackView in [singleStackView, multipleStackView, rangedStackView] {
            stackView?.isHidden = true
        }
        
        let currentQuestion = questions[questionIndex]
        
        questionLabel.text = currentQuestion.title

        let totalProgress = Float(questionIndex) / Float(questions.count)

        questionProgressView.setProgress(totalProgress, animated: true)

        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"

        showCurrentAnswers(for: currentQuestion.type)
    }

    private func showCurrentAnswers(for type: ResponseType) {
        switch type {
        case .single: showSingleStackView(with: currentAnswers)
        case .multiple: showMultipleStackView(with: currentAnswers)
        case .ranged: showRangedStackView(with: currentAnswers)
        }
    }

    private func showSingleStackView(with answers: [Answer]) {
        singleStackView.isHidden.toggle()

        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.title, for: .normal)
        }
    }

    private func showMultipleStackView(with answers: [Answer]) {
        multipleStackView.isHidden.toggle()

        for (label, answer) in zip(multipleLabels, answers) {
            label.text = answer.title
        }
    }

    private func showRangedStackView(with answers: [Answer]) {
        rangedStackView.isHidden.toggle()

        rangedLabels.first?.text = answers.first?.title
        rangedLabels.last?.text = answers.last?.title
    }

    private func nextQuestion() {
        questionIndex += 1

        if questionIndex < questions.count {
            updateUI()
            return
        }

        performSegue(withIdentifier: "showResult", sender: nil)
    }

}
