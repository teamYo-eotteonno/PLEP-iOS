//
//  RemoteImageView.swift
//  PLEP
//
//  Created by 이다경 on 7/30/25.
//

import SwiftUI

struct RemoteImageView: View {
    let urlString: String?
    @State private var image: UIImage? = nil
    
    var body: some View {
        Group {
            if let uiImage = image {
                Image(uiImage: uiImage)
                    .resizable()
            } else {
                Color.gray.opacity(0.2)
            }
        }
        .onAppear {
            guard let urlString = urlString,
                  let url = URL(string: urlString) else { return }
            
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data, error == nil, let uiImage = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = uiImage
                    }
                }
            }.resume()
        }
    }
}
