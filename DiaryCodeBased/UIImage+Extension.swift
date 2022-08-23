//
//  UIImage+Extension.swift
//  DiaryCodeBased
//
//  Created by Junhee Yoon on 2022/08/24.
//

import UIKit

extension UIImage {
    
    // UIImage -> String
    func toPngString() -> String? {
        let data = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
    
    func toJpegString(compressionQuality cq: CGFloat) -> String? {
        let data = self.jpegData(compressionQuality: cq)
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
    
}
