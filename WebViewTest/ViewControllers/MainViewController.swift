//
//  ViewController.swift
//  WebViewTest
//
//  Created by Yuriy Pashkov on 19.04.2024.
//

import UIKit

enum Colors {
    case green
    case red
}

class MainViewController: UIViewController {

    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var redView: UIView!
    
    private var selectedColor: Colors = .green
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBaseLayout()
        
        let greenTap = UITapGestureRecognizer(target: self, action: #selector(greenTap))
        greenView.addGestureRecognizer(greenTap)
        
        let redTap = UITapGestureRecognizer(target: self, action: #selector(redTap))
        redView.addGestureRecognizer(redTap)
    }
    
    private func setupBaseLayout() {
        greenView.layer.borderWidth = 4
        redView.layer.borderWidth = 4
        greenView.layer.borderColor = UIColor.black.cgColor
        redView.layer.borderColor = UIColor.red.cgColor
    }
    
    @objc private func greenTap() {
        print("green tap")
        setSelectedColor(.green)
        greenView.layer.borderColor = UIColor.black.cgColor
        redView.layer.borderColor = UIColor.systemRed.cgColor
    }
    
    @objc private func redTap() {
        print("red tap")
        setSelectedColor(.red)
        greenView.layer.borderColor = UIColor.systemGreen.cgColor
        redView.layer.borderColor = UIColor.black.cgColor
    }
    
    private func setSelectedColor(_ color: Colors) {
        selectedColor = color
    }

    @IBAction func buttonTap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let webViewVC = storyboard.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
            webViewVC.selectedColor = selectedColor
            navigationController?.pushViewController(webViewVC, animated: true)
        }
    }
    
}

