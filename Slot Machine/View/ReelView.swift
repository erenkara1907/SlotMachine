//
//  ReelView.swift
//  Slot Machine
//
//  Created by user on 17.06.2022.
//

import SwiftUI

struct ReelView: View {
    // MARK: - PROPERTY
    
    // MARK: - BODY
    var body: some View {
        Image("gfx-reel")
            .resizable()
            .modifier(ImageModifier())
    }
}

// MARK: - PREVIEW
struct ReelView_Previews: PreviewProvider {
    static var previews: some View {
        ReelView()
            .previewLayout(.fixed(width: 220.0, height: 220.0))
    }
}
