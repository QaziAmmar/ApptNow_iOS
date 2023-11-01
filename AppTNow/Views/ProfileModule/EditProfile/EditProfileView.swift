//
//  EditProfileView.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 06/08/2023.
//

import SwiftUI
import PhotosUI

struct EditProfileView: AppTNowView {
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImageData: Data? = nil
    @StateObject private var viewModel = EditProfileVM()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            loadView
            LoaderView(isLoading: $viewModel.showLoader)
        }
        .alert(item: $viewModel.activeAlert) { activeAlert in
            switch activeAlert.alert {
            case .showError(let message):
                return Alert(title: Text(message))
            case .goBack:
                return Alert(
                    title: Text("Profile Update"),
                    message: Text("Your Profile has been updated."),
                    dismissButton: .default(Text("OK")) {
                        dismiss()
                    }
                )
            }
        }
        .onAppear() {
            setImageFromStringrURL(stringUrl:  AppUrl.IMAGEURL + viewModel.userImageURL)
        }
    }
}
extension EditProfileView {
    
    var loadView: some View {
        VStack(alignment: .leading, spacing: 30) {
            NavBar(title: "Edit Profile", action: {dismiss()})
            imagePlaceHolerView
            titleView
            Spacer()
            saveChangeButton
        }.padding(15)
    }
    
    var titleView: some View {
        VStack(alignment: .leading) {
            customeTextField(title: "Name ",placeHolder: "Email",text: $viewModel.name)
        }
    }
    
    private var imagePlaceHolerView: some View {
        HStack {
            Spacer()
            ZStack {
                imageLoadingView
            }.overlay(imageButton.offset(y: 10), alignment: .bottom)
            Spacer()
        }
    }
    
    @ViewBuilder
    private var imageLoadingView: some View {
        if let selectedImageData,
           let uiImage = UIImage(data: selectedImageData) {
            rectangleImage(image: uiImage)
        } else {
            if viewModel.userImageURL.isEmpty {
                placeHolderImage()
            } else {
                RectangleAysnImageView(url: viewModel.userImageURL, width: 70, height: 70)
            }
            
        }
    }
}
// MARK: Images type
extension EditProfileView {
    func rectangleImage(image: UIImage) -> some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: 70, height: 70)
            .background(
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 70)
                    .clipped()
            )
            .cornerRadius(12.6)
            .overlay(
                RoundedRectangle(cornerRadius: 12.6)
                    .stroke(imagePlaceHolder, lineWidth: 2.8)
            )
    }
    
    private func placeHolderImage() -> some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: 70, height: 70)
            .background(
                Image(ImageName.Common.thumb.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 70)
                    .clipped()
            )
            .cornerRadius(12.6)
            .overlay(
                RoundedRectangle(cornerRadius: 12.6)
                    .stroke(imagePlaceHolder, lineWidth: 2.8)
            )
    }
}
// MARK: Buttons
extension EditProfileView {
    private var imageButton: some View {
        PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared(), label: {
            HStack(alignment: .center, spacing: 0) {
                Image(ImageName.Common.pencil.rawValue)
                    .resizable()
                    .frame(width: 19, height: 19)
                    .foregroundColor(.white)
            }
            .frame(width: 25, height: 25, alignment: .center)
            .background((Color.color(.mainColor)))
            .cornerRadius(22)
            .overlay(
                RoundedRectangle(cornerRadius: 22)
                    .inset(by: 0.7)
                    .stroke(.white, lineWidth: 1)
            )
        }).onChange(of: selectedItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                    selectedImageData = data
                }
            }
        }
    }
    
    private var saveChangeButton: some View {
        customButton(
            title: "Save Changes",
            action: {
                viewModel.showLoader = true
                Task {
                    guard let selectedImageData else {return}
                    let base64String = getBase64String(from: UIImage(data: selectedImageData) ?? UIImage())
                    await viewModel.updateProfileApi(base64Image: base64String)
                }
            })
    }
}

// MARK: Custom Function Ex

extension EditProfileView {
    func setImageFromStringrURL(stringUrl: String) {
        if let url = URL(string: stringUrl) {
            viewModel.showLoader = true
        URLSession.shared.dataTask(with: url) { (data, response, error) in
          // Error handling...
            debugPrint(error?.localizedDescription ?? "")
          guard let imageData = data else { return }
            
            DispatchQueue.main.async {
                viewModel.showLoader = false
            }
            
            selectedImageData = imageData
            debugPrint("Appt: Image loaded successfully")
            
            
        }.resume()
      }
    }
}

struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
