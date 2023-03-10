//
//  ImageCacheService.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/11.
//

import UIKit

final class ImageCacheService {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}
