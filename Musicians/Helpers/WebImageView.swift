//
//  WebImageVie.swift
//  VK Feed
//
//  Created by Артём on 16.08.2021.
//

import UIKit

class WebImageView: UIImageView {
    
    private var currentTask: URLSessionDataTask?
    
    func load(from url: URL?) {
        guard let url = url else {
            image = nil
            return
        }
        currentTask?.cancel()
        
        let request = URLRequest(url: url)
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            setImage(from: cachedResponse.data)
            return
        }
        
        DispatchQueue.global().async {
            self.currentTask = URLSession.shared.dataTask(with: request) { [unowned self] data, response, _ in
                self.setImage(from: data)
                cacheURLResponse(request: request, data: data, response: response)
            }
            self.currentTask!.resume()
        }
    }
    
    private func setImage(from data: Data?) {
        guard let data = data else { return }
        let image = UIImage(data: data)
        DispatchQueue.main.async {
            self.image = image
        }
    }
    
    private func cacheURLResponse(request: URLRequest, data: Data?, response: URLResponse?) {
        guard let data = data, let response = response else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius: CGFloat = self.bounds.size.width / 2.0
        self.layer.cornerRadius = radius
    }
}
