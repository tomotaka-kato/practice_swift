//
//  ViewController.swift
//  MyMap
//
//  Created by tomotaka.kato on 2017/10/24.
//  Copyright © 2017 tomotaka.kato. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var photoDisplay: UIImageView!
    @IBOutlet weak var photoInfoDisplay: UITextView!
    
    var imagePicker: UIImagePickerController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func takePhoto(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        photoDisplay.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imagePicker.dismiss(animated: true, completion: nil)
        imageInference(image: (info[UIImagePickerControllerOriginalImage] as? UIImage)!)
    }
    
    func imageInference(image: UIImage) {
        guard let model = try? VNCoreMLModel(for: Resnet50().model) else {
            fatalError("モデルをロードできません")
        }
        
        let request = VNCoreMLRequest(model: model) {
            [weak self] request, error in
            
            guard let results = request.results as? [VNClassificationObservation],
                let firstResult = results.first else {
                    fatalError("判定をできません")
            }
            
            DispatchQueue.main.async {
                self?.photoInfoDisplay.text = "確率 = \(Int(firstResult.confidence * 100))%,\n\n詳細\(firstResult.identifier)"
                print("確率 = \(Int(firstResult.confidence * 100))%,\n\n詳細\(firstResult.identifier)")
            }
        }
        
        guard let ciImage = CIImage(image: image) else {
            fatalError("画像を変換できません")
        }
        let imageHandler = VNImageRequestHandler(ciImage: ciImage)
        
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try imageHandler.perform([request])
            } catch {
                print("エラー\(error)")
            }
        }
    }
}

