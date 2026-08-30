//
//  Buttons.swift
//  Runner
//
//  Created by Maximilian Matisan on 30.08.26.
//
import SwiftUI

enum ButtonIcon {
    case system(String)
    case emoji(String)
    
    @ViewBuilder
    func view(size: CGFloat) -> some View {
        switch self {
        case .system(let name):
            Image(systemName: name)
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
        case .emoji(let emoji):
            Text(String(emoji))
                .font(.system(size: size))
        }
    }
}
