
//  Gif.swift
//  Spark
//
//  Created by ohoud on 15/06/1446 AH.
//

//
//  Gif.swift
//  ADHD
//
//  Created by Manar Majeed Alrasheed on 14/06/1446 AH.
//


//
//  GIFImage.swift
//  start_project
//
//  Created by Wejdan Alghamdi on 05/04/1446 AH.
//

import SwiftUI
import UIKit
import ImageIO

// GIFImage struct to display GIFs
struct GIFImage: UIViewRepresentable {
    let name: String
    
    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }
    
    func updateUIView(_ uiView: UIImageView, context: Context) {
        uiView.image = UIImage.gif(name: name)
        uiView.startAnimating()
    }
}

// UIImage extension to handle GIF loading
extension UIImage {
    static func gif(name: String) -> UIImage? {
        guard let url = Bundle.main.url(forResource: name, withExtension: "gif"),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        
        let source = CGImageSourceCreateWithData(data as CFData, nil)
        let images = (0..<CGImageSourceGetCount(source!)).compactMap {
            CGImageSourceCreateImageAtIndex(source!, $0, nil)
        }.map { UIImage(cgImage: $0) }
        
        return UIImage.animatedImage(with: images, duration: Double(images.count) / 5.0)
    }
}


#Preview {
//    Homepage()
    HomeView(userName: "example")
}
