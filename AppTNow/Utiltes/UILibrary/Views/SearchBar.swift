//
//  SearchBar.swift
//  AppTNow
//
//  Created by Qazi Ammar Arshad on 24/10/2023.
//

import SwiftUI

struct SearchBar: AppTNowView {
    
    @Binding var text: String
    @State private var isEditing = false
    var onCancel: () -> Void
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 5)
                .background(backgroundColor)
                .opacity(0.10)
                .frame(height: 40)
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding([.leading])
                
                TextField("Search ...", text: $text)
                    .padding([.trailing,. top, .bottom],7)
                                
                                .foregroundColor(.black)
                                .font(AppTNowFont.regular.getFont(size: .h3))
                                .opacity(isEditing ? 1 : 0.7)
                                .onTapGesture {
                                    self.isEditing = true
                                }
                 
                            if isEditing {
                                Button(action: {
                                    self.isEditing = false
                                    self.text = ""
                                    onCancel()
                                }) {
                                    Text("Cancel")
                                        .foregroundColor(.blue)
                                }
                                .padding(.trailing, 10)
                                .transition(.move(edge: .trailing))
                                
                            }
            }
        }
        
        
        
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("Search service or company ..."), onCancel: {
            print("on Cancel called")
        })
    }
}
