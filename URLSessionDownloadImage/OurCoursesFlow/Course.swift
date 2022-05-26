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
    let number_of_lessons: Int?
    let number_of_tests: Int?
}
