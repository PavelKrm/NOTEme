//
//  ScreenshotService.swift
//  NoteMe
//
//  Created by PavelKrm on 26.03.24.
//

import UIKit
import Foundation

final class FileService {
    
    private var manager = FileManager.default
    
    func saveImage(id: String, image: UIImage?) {
        
        let path = manager.urls(for: .documentDirectory,
                                in: .userDomainMask).first
        guard
            let filePath = path?.appendingPathComponent(id),
            let image,
            let data = image.pngData()
        else {
            print("[FileService]: found nil while unwrapping optional value")
            return
        }
        
        do {
            try data.write(to: filePath)
        } catch {
            print("[FileService]: failed write screenshot")
        }
    }
    
    func loadImage(id: String) -> UIImage? {
        
        guard
            let path = manager.urls(for: .documentDirectory,in: .userDomainMask).first,
            let data = try? Data(contentsOf: path.appendingPathComponent(id))
        else {
            print("[FileService]: failed to load screenshot")
            return nil
        }
            if let screenshot = UIImage(data: data) {
                return screenshot
            }
        return nil
    }
}
    

