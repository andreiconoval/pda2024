//
//  UIViewControllerExtensions.swift
//  teammate
//
//  Created by user256828 on 4/20/24.
//

import UIKit

extension UIViewController {
    
    func showToast(message: String, font: UIFont) {
        let toastLable = UILabel(frame:CGRect(x: self.view.frame.size.width/2-75, y: self.view.frame.size.width/2-100
                                              , width: 150, height: 35))
        toastLable.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLable.textAlignment = .center
        toastLable.textColor = .white
        toastLable.font = font
        toastLable.text = message
        toastLable.alpha = 1.0
        toastLable.layer.cornerRadius = 10
        toastLable.clipsToBounds = true
        self.view.addSubview(toastLable)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseIn ,animations:
                        {
            toastLable.alpha = 0.0
        }, completion: {
            (isCompleted) in toastLable.removeFromSuperview()
        })
    }
    
    func loadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
            // Create URL object from string
            guard let url = URL(string: urlString) else {
                completion(nil)
                return
            }
            
            // Create a data task to fetch the image
            URLSession.shared.dataTask(with: url) { data, response, error in
                // Check for errors
                if let error = error {
                    print("Error fetching image: \(error)")
                    completion(nil)
                    return
                }
                
                // Check for response status code
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Invalid response")
                    completion(nil)
                    return
                }
                
                // Check if data is available
                if let data = data {
                    // Create image from data
                    if let image = UIImage(data: data) {
                        // Pass image to completion handler
                        completion(image)
                    }
                }
            }.resume() // Resume the data task
        }
}
