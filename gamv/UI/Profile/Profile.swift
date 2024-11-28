//
//  Profile.swift
//  gamv
//
//  Created by Ajie DR on 18/11/24.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            Image(ImageResource.myPicture)
                .resizable()
                .scaledToFit()
                .clipped()
                .clipShape(.circle)
                .frame(width: 100, height: 100)
            Text("Ajie DR")
            Text("ajiedibyor@gmail.com")
        }
        .navigationTitle("Profile")
    }
}


#Preview {
    ProfileView()
}
