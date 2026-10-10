//
//  ParentView .swift
//  Lemon App View Exercise
//
//  Created by Valentyn Verovkin on 21.06.2026.
//

import SwiftUI

struct ParentView_: View {
    var body: some View {
        HStack {
            Rectangle()
                .fill(Color.red)
                .frame(width: 50, height: 50)
            
            Text("Rectangle One")
                .foregroundColor(.white)
                .padding(20)
                .background(Color.yellow)
            
            Rectangle()
                .fill(Color.blue)
                .frame(width: 100, height: 30)
        }
    }
}

#Preview {
    ParentView_()
}
