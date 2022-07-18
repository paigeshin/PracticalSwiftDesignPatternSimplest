//
//  ContentView.swift
//  TestingTesting
//
//  Created by paige shin on 2022/07/17.
//

import SwiftUI

struct ContentView: View {
    
    @State var text = "Hello World"
    
    var body: some View {
        Text("\(text)")
            .padding()
            .onTapGesture {
                text = "Haha you clicked"
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
