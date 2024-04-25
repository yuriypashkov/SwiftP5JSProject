//
//  WebViewController.swift
//  WebViewTest
//
//  Created by Yuriy Pashkov on 19.04.2024.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var selectedColor: Colors = .green // red (255, 0, 0), green (0, 211, 0)
    private var savedFramesCount: Int = 0

    private var imageURLs: [URL] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self

        //let url = Bundle.main.url(forResource: "web_graphics_test_003", withExtension: "html")!
        //webView.loadFileURL(url, allowingReadAccessTo: url)

        var finalString = Constants.htmlHeader
        switch selectedColor {
        case .green:
            finalString += Constants.sketchGreen
        case .red:
            finalString += Constants.sketchRed
        }
        finalString += Constants.htmlFooter
        webView.loadHTMLString(finalString, baseURL: Bundle.main.bundleURL)
    }
    
    private func showAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Complete", message: "Video saved", preferredStyle: .alert)
            let button = UIAlertAction(title: "OK", style: .default)
            alert.addAction(button)
            self.present(alert, animated: true)
        }
    }
    
}

extension WebViewController: WKNavigationDelegate, WKDownloadDelegate {
    
    func webView(_ webView: WKWebView, navigationAction: WKNavigationAction, didBecome download: WKDownload) {
        download.delegate = self
    }
    
    func webView(_ webView: WKWebView, navigationResponse: WKNavigationResponse, didBecome download: WKDownload) {
        download.delegate = self
    }
    
    func download(_ download: WKDownload, decideDestinationUsing response: URLResponse, suggestedFilename: String, completionHandler: @escaping (URL?) -> Void) {
        let url = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(suggestedFilename)
        if let url {
            imageURLs.append(url)
        }
        completionHandler(url)
    }
    
    func downloadDidFinish(_ download: WKDownload) {
        print("Donwload did finish")
        savedFramesCount += 1
        
        if savedFramesCount >= 20 {
            print("All frames saved")
            // start making video process
            let settings = RenderSettings()
            var images: [UIImage] = []
            imageURLs.forEach { url in
                if let data = try? Data(contentsOf: url) {
                    images.append(UIImage(data: data)!)
                }
            }
            let imageAnimator = ImageAnimator(renderSettings: settings, images: images)
            imageAnimator.render() {
                print("Video created and saved")
                self.showAlert()
            }
        }
    }
    
}
