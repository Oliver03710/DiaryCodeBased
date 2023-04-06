//
//  FileManager+Extension.swift
//  DiaryCodeBased
//
//  Created by Junhee Yoon on 2022/08/24.
//

import UIKit

import Zip

extension UIViewController {
    
    func documentDirectoryPath() -> URL? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentDirectory
    }
    
    func saveImageToDocument(fileName: String, image: UIImage) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 0.8) else { return }
        
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("file save error", error)
        }
    }
    
    func loadImageFromDocument(fileName: String) -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let folderName = "images"
        let folderURL = documentDirectory.appendingPathComponent(folderName)
        let fileURL = folderURL.appendingPathComponent(fileName)
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        } else {
            return UIImage(systemName: "apple.logo")
        }
    }
    
    func fetchDocumentZipFile() -> ([URL]?, [String]?) {
        
        do {
            
            guard let path = documentDirectoryPath() else { return (nil, nil) }
            
            let docs = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
            print("docs: \(docs)")
            
            let zip = docs.filter { $0.pathExtension == "zip" }
            print("Zip: \(zip)")
            
            let result = zip.map { $0.lastPathComponent }
            print("Result: \(result)")
            
            return (zip, result)
            
        } catch {
            print("Error")
            return (nil, nil)
        }
        
    }
    
    func restoreFromCell(urls: URL?, indexPath: IndexPath) {
        
        guard let selectedFileURL = urls else {
            showAlertMessage(title: "선택하신 파일을 찾을 수 없습니다.")
            return
        }
        
        guard let path = documentDirectoryPath() else {
            showAlertMessage(title: "선택하신 파일을 찾을 수 없습니다.")
            return
        }
        
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            
            guard let fileName = fetchDocumentZipFile().1?[indexPath.row] else {
                self.showAlertMessage(title: "파일 이름 불러오는데 실패했습니다.")
                return
            }
            
            let fileURL = path.appendingPathComponent(fileName)
            
            do {
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("\(unzippedFile)")
                    self.showAlertMessage(title: "복구에 성공하였습니다.")
                })
                
            } catch {
                showAlertMessage(title: "압축 해제에 실패했습니다.")
            }
            
        }
    }
    
}
