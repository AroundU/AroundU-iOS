//
//  PublishViewController.swift
//  AroundU
//
//  Created by Richer Archambault on 2017-03-05.
//  Copyright © 2017 LassondeHacks. All rights reserved.
//

import UIKit
import Material
import Stevia

class PublishTextViewController: UIViewController, UITextViewDelegate {
    var captionBox = UITextView()
    var submitButton = RaisedButton()
    var cancelButton = FlatButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.sv(captionBox,
                submitButton)
        
        captionBox.text = "Your desciption"
        captionBox.returnKeyType = .default
        captionBox.delegate = self
        
        submitButton.titleColor = .white
        submitButton.pulseColor = .white
        submitButton.backgroundColor = .primary
        submitButton.title = "Publish"
        submitButton.tap {
            Connection.publish(self.captionBox.text)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PublishShouldTerminate"), object: nil)
        }
        
        view.layout(
            16,
            |-10-captionBox-10-| ~ 100,
            16,
            |-10-submitButton-10-| ~ 40
        )
    }
    
    
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        captionBox.text = ""
        return true
    }
}

class PublishMediaViewController: UIViewController {
    var image: UIImage!
    
    init(image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        //isMotionEnabled = true
        self.image = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = PublishScrollView(image: self.image)
        
    }
    
}

class PublishScrollView: UIScrollView, UIScrollViewDelegate, UITextViewDelegate {
    var imageView = UIImageView()
    var captionBox = UITextView()
    var submitButton = RaisedButton()
    var cancelButton = FlatButton()
    
    convenience init(image: UIImage) {
        self.init(frame:CGRect.zero)
        
        imageView.image = image
        render()
    }
    
    func render() {
        backgroundColor = .white
        
        
        sv(captionBox,
           submitButton,
           imageView)
        
        captionBox.text = "Your desciption"
        captionBox.returnKeyType = .default
        captionBox.delegate = self
        
        submitButton.titleColor = .white
        submitButton.pulseColor = .white
        submitButton.backgroundColor = .primary
        submitButton.title = "Publish"
        submitButton.tap {
            
            DispatchQueue.global().async {
                if self.captionBox.text == "Your desciption" {
                    self.captionBox.text = ""
                }
                Connection.publish(self.imageView.image!, description: self.captionBox.text)
            }
            
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PublishShouldTerminate"), object: nil)
            }
            
        }
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        layout(
            16,
            |-10-captionBox-10-| ~ 100,
            16,
            |-10-submitButton-10-| ~ 40,
            16
        )
        
        layout(imageView).horizontally().height(340).center(offsetY: 96)
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        captionBox.text = ""
        return true
    }
    
    
}
