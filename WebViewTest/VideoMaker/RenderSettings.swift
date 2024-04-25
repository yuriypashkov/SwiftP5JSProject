//
//  RenderSettings.swift
//  WebViewTest
//
//  Created by Yuriy Pashkov on 21.04.2024.
//

import AVFoundation
import UIKit
import Photos

struct RenderSettings {
    
    var size : CGSize = CGSize(width: 360, height: 360)
    var fps: Int32 = 5   // frames per second
    var avCodecKey = AVVideoCodecType.h264
    var videoFilename = "render" + String(Date().timeIntervalSince1970)
    var videoFilenameExt = "mp4"
    
    
    var outputURL: URL {
        let fileManager = FileManager.default
        if let docDirURL = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) {
            return docDirURL.appendingPathComponent(videoFilename).appendingPathExtension(videoFilenameExt)
        }
        fatalError("URLForDirectory() failed")
    }
    
}
