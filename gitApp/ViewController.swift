//
//  ViewController.swift
//  gitApp
//
//  Created by Berezhnova <3 on 20.04.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func button_action(_ sender: UIButton) {
        fetchDataFromServer()
    }

    func fetchDataFromServer() {
        // Создание URL для запроса
        guard let url = URL(string: "https://api.github.com/repos/square/retrofit/contributors") else {
            return
        }

    // Создание запроса
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
        guard let self = self else { return }
        // Проверка на наличие ошибок
        if let error = error {
        print("Error: \(error.localizedDescription)")
        return
        }

    // Парсинг данных, если они получены успешно
        if let data = data {
            if let result = String(data: data, encoding: .utf8) {
            // Обновление пользовательского интерфейса на основе полученных данных
                DispatchQueue.main.async {
                    self.resultLabel.text = result
                }
            }
        }
    }

    // Запуск запроса
    task.resume()
    }
}
    


