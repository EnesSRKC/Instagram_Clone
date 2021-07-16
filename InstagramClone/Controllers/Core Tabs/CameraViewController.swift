//
//  CameraViewController.swift
//  InstagramClone
//
//  Created by Enes Sirkecioğlu on 24.06.2021.
//

import AVFoundation
import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    private let pickerController = UIImagePickerController()
    
    private let photoOverviewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = nil
        imageView.backgroundColor = .orange
        return imageView
    }()
    
    private let chooseButton: UIButton = {
        let button = UIButton()
        button.setTitle("Galeriden Seç", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .red
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerController.delegate = self

        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.addSubview(photoOverviewImageView)
        view.addSubview(chooseButton)
        
        chooseButton.addTarget(self, action: #selector(didTapChooseButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        photoOverviewImageView.frame = CGRect(x: 0, y: 0, width: view.width, height: (view.height/3)*2)
        
        let buttonSize: CGFloat = 120
        chooseButton.frame = CGRect(x: (view.width - buttonSize)/2, y: photoOverviewImageView.bottom + 5, width: buttonSize, height: buttonSize/2)
    }
    
    @objc private func didTapChooseButton() {
        
        
        pickerController.allowsEditing = true
        pickerController.mediaTypes = ["public.image", "public.movie"]
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoOverviewImageView.contentMode = .scaleAspectFit
            photoOverviewImageView.image = pickedImage
        }

        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}
