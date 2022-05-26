//
//  WebSiteDescription.swift
//  URLSessionDownloadImage
//
//  Created by Muller Alexander on 26.05.2022.
//

import Foundation

struct WebsiteDescription: Decodable {
    let websiteDescription: String?
    let websiteName: String?
    let courses: [Course]
}
