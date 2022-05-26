//
//  Course.swift
//  URLSessionDownloadImage
//
//  Created by Muller Alexander on 26.05.2022.
//

import Foundation

struct Course: Decodable {
    let id: Int?
    let name: String?
    let link: String?
    let imageUrl: String?
    let numberOfLessons: Int?
    let numberOfTests: Int?
}
