//
//  ViewController.swift
//  gitApp
//
//  Created by Berezhnova <3 on 20.04.2024.
//

import UIKit

struct GitHubUser: Decodable {
    let login: String
    let url: String
    let company: String?
}

class ViewController: UIViewController {

    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
    super.viewDidLoad()
// Do any additional setup after loading the view.
}

@IBAction func searchButtonTapped(_ sender: UIButton) {
    guard let accountName = accountTextField.text else {
    return
}

fetchGitHubUserData(for: accountName)
}

func fetchGitHubUserData(for accountName: String) {
    let urlString = "https://api.github.com/users/alexanderklimov"
    guard let url = URL(string: urlString) else {
    return
}

let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
guard let self = self else { return }

    if let error = error {
    print("Error: \(error)")
    return
    }

    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
    print("Invalid response")
    return
    }

    if let data = data {
    do {
    let decoder = JSONDecoder()
    let user = try decoder.decode(GitHubUser.self, from: data)
    DispatchQueue.main.async {
        self.resultLabel.text = "Login: \(user.login)\nURL: \(user.url)\nCompany: \(user.company ?? "N/A")"
    }
    } catch {
        print("Error decoding JSON: \(error)")
    }
    }
}

task.resume()
}
}
    


