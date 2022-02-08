//
//  MatrixRainView.swift
//  MatrixCode
//
//  Created by Erkam Kucet on 8.02.2022.
//

import SwiftUI

struct MatrixRainView: View {
    
    var body: some View {
        ZStack {
            Color.black
            GeometryReader { proxy in
                let size = proxy.size
                HStack {
                    ForEach(1...Int(size.width / 15), id: \.self) { _ in
                        MatrixRainCharacters(size: size)
                    }
                }
            }
        }
    }
}

struct MatrixRainCharacters: View {
    
    var size: CGSize
    private let chars = "0123456789abcdefghijklmnoprstuvwxyzabcquepaje123jdj09"
    
    @State var startAnimation: Bool = false
    @State var random: Int = 0
    
    var body: some View {
        let randomHeight: CGFloat = .random(in: (size.height / 2)...size.height)
        
        VStack {
            ForEach(0..<chars.count, id: \.self) { index in
                let char = Array(chars)[getRandomIndex(index: index)]
                Text(String(char))
                    .font(.custom("MatrixCodeNFI", size: 15))
                    .foregroundColor(Color("Green"))
            }
        }
        .mask(alignment: .top){
            Rectangle()
                .fill(LinearGradient(
                    colors: getGradientColors(),
                    startPoint: .top,
                    endPoint: .bottom))
                .frame(height: size.height / 2)
                .offset(y: startAnimation ? size.height : -randomHeight)
        }
        .onAppear {
            withAnimation(.linear(duration: 3).delay(.random(in: 0...2)).repeatForever(autoreverses: false)) {
                startAnimation = true
            }
        }
        .onReceive(Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()) { _ in
            random = Int.random(in: 0..<chars.count)
        }
    }
    
    private func getRandomIndex(index: Int) -> Int {
        let max = chars.count - 1
        if (index + random) > max {
            if (index - random) < 0 {
                return index
            }
            return (index - random)
        }else {
            return (index + random)
        }
    }
    
    private func getGradientColors() -> [Color] {
        return [.clear,
                .black.opacity(0.1),
                .black.opacity(0.2),
                .black.opacity(0.3),
                .black.opacity(0.4),
                .black.opacity(0.5),
                .black.opacity(0.6),
                .black.opacity(0.7),
                .black]
    }
}

struct MatrixRainView_Previews: PreviewProvider {
    static var previews: some View {
        MatrixRainView()
            .preferredColorScheme(.dark)
    }
}
