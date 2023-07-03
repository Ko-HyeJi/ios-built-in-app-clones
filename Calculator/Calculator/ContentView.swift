//
//  ContentView.swift
//  Calculator
//
//  Created by 고혜지 on 2023/06/28.
//

import SwiftUI

struct ContentView: View {

    @State var display: Double = 0
    let columns: [GridItem] = [GridItem(), GridItem(), GridItem(), GridItem()]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    Text("\(display)")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
                
                LazyVGrid(columns: columns, content: {
                    ForEach(0..<20) { index in
                        Circle()
                            .fill(buttonColor(index))
                            .padding(3)
                    }
                })
                .padding()
            }
        }
    }
    
    func buttonColor(_ index: Int) -> Color {
        if index < 3 {
            return Color.gray
        } else if index % 4 == 3 {
            return Color.orange
        } else {
            return Color.white
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
