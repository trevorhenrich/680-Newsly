//
//  ContentView.swift
//  Homework1-DemoModified
//
//
//
//  This code was modified by Trevor Henrich.
//


import SwiftUI

struct ContentView: View {
    
    @State
    var isLoading: Bool = false
    @State
    var buttonText: String = "Tap to Load"
    
    
    var body: some View {
//        VStack { // Vertical Stack
//        HStack { // Horizontal Stack
        ZStack {
            Button(buttonText) {
                isLoading = !isLoading
                if(isLoading){
                    buttonText = "Stop"
                }
                    
                if(!isLoading){
                    buttonText = "Tap to Load"
                }
            }
            
            if isLoading {
                ProgressView()
                    .allowsHitTesting(false)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
