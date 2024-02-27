//
//  ResultViewController.swift
//  what animal are you?
//
//  Created by Anna Lavrova on 26.02.2024.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var animalTypeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    var answers: [Answer] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        updateResult()
    }

    private func updateResult() {

        var frequencyOfAnimals: [Animal: Int] = [:]
        let animals = answers.map { $0.animal }

        for animal in animals {
            if let animalTypeCount = frequencyOfAnimals[animal] {
                frequencyOfAnimals.updateValue(animalTypeCount + 1, forKey: animal)
            } else {
                frequencyOfAnimals[animal] = 1
            }
        }

        let sortedFrequencyOfAnimals = frequencyOfAnimals.sorted { $0.value > $1.value }
        guard let mostFrequencyAnimal = sortedFrequencyOfAnimals.first?.key 
        else { return }

//        let mostFrequencyAnimal = Dictionary(grouping: answers) { $0.animal }
//            .sorted { $0.value.count > $1.value.count }
//            .first?.key

        updateUI(with: mostFrequencyAnimal)
    }

    private func updateUI(with animal: Animal) {
        animalTypeLabel.text = "Вы - \(animal.rawValue)!"
        descriptionLabel.text = animal.definition
    }
}
