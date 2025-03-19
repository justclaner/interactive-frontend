//
//  ProfilePage.swift
//  Interactive
//
//  Created by Justin Zou on 3/18/25.
//

import SwiftUI

struct ProfilePage: View {
    @Binding var path: [String]
    @State var userId: String
    
    init(path: Binding<[String]>) {
        self._path = path
        self._userId = State(initialValue:
        (path.wrappedValue.last != nil && path.wrappedValue.last!.count > 8)
            ? String(path.wrappedValue.last!.dropFirst(8))
            : ""
        )
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ProfilePage(path: .constant(["profile-card-67d45cbd2f34df445d2b0d78"]))
}
