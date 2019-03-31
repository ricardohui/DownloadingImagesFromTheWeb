//
//  ViewController.swift
//  DownloadingImagesFromTheWeb
//
//  Created by Ricardo Hui on 31/3/2019.
//  Copyright © 2019 Ricardo Hui. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if documentsPath.count > 0{
            let documentsDirectory = documentsPath[0]
            let restorePath = documentsDirectory + "/bach.jpg"
            
            ximageView.image = UIImage(contentsOfFile: restorePath)
            
        }
        
        
        let url = URL(string: "https://upload.wikimedia.org/wikipedia/commons/6/6a/Johann_Sebastian_Bach.jpg")!
        let request = NSMutableURLRequest(url: url)
        
        let task  = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            if error != nil {
                print(error)
            }else{
                if let data = data{
                    if let bachImage = UIImage(data: data){
                        self.imageView.image = bachImage
                        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                        if documentsPath.count > 0{
                            let documentsDirectory = documentsPath[0]
                            let savePath = documentsDirectory + "/bach.jpg"
                            do {
                                try bachImage.jpegData(compressionQuality: 1)?.write(to: URL(fileURLWithPath: savePath))
                            }catch{
                                
                            }
                        }
                    }
                }
                
            }
        }
        task.resume()
        
    }


}

