//
//  ContentView.swift
//  Homework1-ChatGPT-SwiftUI
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

import SwiftUI

struct ContentView: View {
    @State private var isLoading = false
    
    var body: some View {
        ZStack {
            Button(action: {
                self.isLoading.toggle()
            }) {
                Text(isLoading ? "Stop Loading" : "Tap to Load")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(1.5)
                    .padding()
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(10)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
