//
//  CoursesTableView.swift
//  URLSessionDownloadImage
//
//  Created by Muller Alexander on 25.05.2022.
//

import UIKit

final class CoursesTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        register()
        contentInsetAdjustmentBehavior = .always
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CoursesTableView {
    private func register() {
        register(CoursesTableViewCell.self, forCellReuseIdentifier: "CoursesCell")
    }
}
