//
//  Extensions.swift
//  testiosapp
//
//  Created by Alfredo Tochon on 11/11/20.
//


import UIKit

extension UIImageView{
    
    func imageFromServerURL(url:String, placeHolderImage:UIImage){
        if self.image == nil{
            self.image = placeHolderImage
        }
        
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            if error != nil{
                return
            }
            DispatchQueue.main.async {
                guard let data = data else {return}
                let image = UIImage(data: data)
                self.image = image
            }
        }.resume()
        
    }
}
