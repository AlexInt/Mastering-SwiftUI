//
//  SwiftUI_AsyncImage.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/27.
//

import SwiftUI

struct SwiftUI_AsyncImage: View {
    private let imageURL = "https://cdn9-banquan.ituchong.com/weili/l/897633020865937538.webp";
    var body: some View {
        Group {
            if #available(iOS 15.0, *) {
                
                AsyncImage(url: URL(string: imageURL), transaction: Transaction(animation: .spring())) { phase in
                    switch phase {
                    case .empty:
                        Color.purple.opacity(0.1)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .transition(.slide)
                        
                    case .failure(_):
                        Image(systemName: "exclamationmark.icloud")
                            .resizable()
                            .scaledToFit()
                        
                    @unknown default:
                        Image(systemName: "exclamationmark.icloud")
                    }
                }
                .frame(width: 300, height: 500)
                    .cornerRadius(20)
                
            } else {
                // Fallback on earlier versions
                ZStack {
                    Color.purple.opacity(0.1)
                    
                    RemoteImage(url: imageURL)
                }
                    .scaledToFill()
                    .frame(width: 300, height: 500)
                    .cornerRadius(20)
            }
        }
        
    }
}

struct SwiftUI_AsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_AsyncImage()
    }
}

struct RemoteImage: View {
    private enum LoadState {
        case loading, success, failure
    }

    private class Loader: ObservableObject {
        var data = Data()
        var state = LoadState.loading

        init(url: String) {
            guard let parsedURL = URL(string: url) else {
                fatalError("Invalid URL: \(url)")
            }

            URLSession.shared.dataTask(with: parsedURL) { data, response, error in
                if let data = data, data.count > 0 {
                    self.data = data
                    self.state = .success
                } else {
                    self.state = .failure
                }

                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }.resume()
        }
    }

    @StateObject private var loader: Loader
    var loading: Image
    var failure: Image

    var body: some View {
        selectImage()
            .resizable()
    }

    init(url: String,
         loading: Image = Image(systemName: "photo"),
         failure: Image = Image(systemName: "multiply.circle")) {
        _loader = StateObject(wrappedValue: Loader(url: url))
        self.loading = loading
        self.failure = failure
    }

    private func selectImage() -> Image {
        switch loader.state {
        case .loading:
            return loading
        case .failure:
            return failure
        default:
            if let image = UIImage(data: loader.data) {
                return Image(uiImage: image)
            } else {
                return failure
            }
        }
    }
}
