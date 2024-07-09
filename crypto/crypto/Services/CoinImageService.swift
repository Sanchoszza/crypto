//
//  CoinImageService.swift
//  crypto
//
//  Created by Alexandra on 07.06.2024.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage? = nil
    
    var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage(){
        
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion(completion:), receiveValue: { [weak self] (returnedCoins) in
                self?.image = returnedCoins
                self?.imageSubscription?.cancel()
            })
    }
}


//class CoinImageService {
//    
//    @Published var image: UIImage? = nil
//    
//    var imageSubscription: AnyCancellable?
//    private let coin: CoinModel
//    private let fileManager = LocaleFileManager.instance
//    private let folderName = "coin_images"
//    private let imageName: String
//    
//    init(coin: CoinModel) {
//        self.coin = coin
//        self.imageName = coin.id
//    }
//    
//    private func getCoinImage() {
//        
//        if let savedImage = fileManager.getImage(imageName: coin.id, folderName: folderName) {
//            image = savedImage
//            print("Image from File Manager")
//        } else {
//            downloadCoinImage()
//            print("Downloading image now")
//        }
//    }
//    
//    private func downloadCoinImage(){
//        
//        guard let url = URL(string: coin.image) else { return }
//        
//        imageSubscription = NetworkingManager.download(url: url)
//            .tryMap({ (data) -> UIImage? in
//                return UIImage(data: data)
//            })
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: NetworkingManager.handleCompletion(completion:), receiveValue: { [weak self] (returnedImage) in
//                guard let self = self, let downloadedImage = returnedImage else { return }
//                self.image = downloadedImage
//                self.imageSubscription?.cancel()
//                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
//            })
//    }
//}
