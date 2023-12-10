//  Homework1-ChatGPT-UIKit
//
//
//                      ChatGPT Prompt
//
//  You are a developer for ios applications.
//  You're creating a simple app with a button in the center.
//  When the button is pressed, a "ProgressView" will appear in a zstack on top of the button.
//  when "ProgressView" is not visible, the button should say "Tap to Load".
//  When "ProgressView" is not visible the button should say "Stop Loading"."
//  use Swift UI
//
//  Everythine in this project was created by Trevor Henrich using ChatGPT.
//

//Question 3D-0: In a comment describe your experience with ChatGPT.
//Response: I had to be a lot more literal than I initially expected when typing a prompt.

//Question 3D-1: What did ChatGPT do differently and what did you prefer in ChatGPT’s project or the class project?
//Response: ChatGPT colored my button blue, which was a unique take on the prompt.

// Question 3D-2: How did you refine your prompts to get ChatGPT to eventually create output that behaves identically to the project we created in class?
// Response: I repeatedly went back and added what ChatGPT got wrong the first time. I had to tell it that it needed to show the ProgressView explicitly. I also had to go back and request SwiftUI because it defaulted to UIKit.

// Question 3F: In a few words describe how the SwiftUI and the UIKit apps differ in the way they create the UI.
// Response: The UI Kit is a lot harder to follow. separate functions take up most of the code, which really takes away from readability. the SwiftUI actually feels more simple, easy to read, and seems more like code you would write in java.

import UIKit

class ViewController: UIViewController {

    private var isLoading = false
    private let button = UIButton(type: .system)
    private let progressView = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupButton()
        setupProgressView()
    }

    private func setupButton() {
        button.setTitle("Tap to Load", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(button)
        
        // Set button constraints
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setupProgressView() {
        progressView.hidesWhenStopped = true
        progressView.color = .blue
        progressView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progressView)
        
        // Set progressView constraints
        NSLayoutConstraint.activate([
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func buttonTapped() {
        isLoading.toggle()
        if isLoading {
            button.setTitle("Stop Loading", for: .normal)
            progressView.startAnimating()
        } else {
            button.setTitle("Tap to Load", for: .normal)
            progressView.stopAnimating()
        }
    }
}
