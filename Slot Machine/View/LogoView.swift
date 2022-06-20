//
//  LogoView.swift
//  Slot Machine
//
//  Created by user on 17.06.2022.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        Image("gfx-slot-machine")
            .resizable()
            .scaledToFit()
            .frame(minWidth: 256.0, idealWidth: 300.0, maxWidth: 320.0, minHeight: 112.0, idealHeight: 130.0, maxHeight: 140.0, alignment: .center)
            .padding(.horizontal)
            .layoutPriority(1)
            .modifier(ShadowModifier())
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
