//
//  CoursesTableViewCell.swift
//  URLSessionDownloadImage
//
//  Created by Muller Alexander on 25.05.2022.
//

import UIKit

class CoursesTableViewCell: UITableViewCell {
    
    let courseImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        
        return $0
    }(UIImageView(image: UIImage(named: "Yarik")))
    
    let titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .label
        $0.font = .preferredFont(forTextStyle: .footnote)
        $0.text = "Course takoy-to"
        
        return $0
    }(UILabel(frame: .zero))
    
    let numberOfLessonsLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .label
        $0.font = .preferredFont(forTextStyle: .footnote)
        $0.text = "Number of lessons: "
        
        return $0
    }(UILabel(frame: .zero))
    
    let numberOfTestsLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .label
        $0.font = .preferredFont(forTextStyle: .footnote)
        $0.text = "Number of tests: "
        
        return $0
    }(UILabel(frame: .zero))
    
    let stackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 8
        //        $0.distribution = .fillEqually
        return $0
    }(UIStackView(frame: .zero))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CoursesTableViewCell {
    private func setupConstraints() {
        contentView.addSubview(courseImageView)
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(numberOfLessonsLabel)
        stackView.addArrangedSubview(numberOfTestsLabel)
        
        NSLayoutConstraint.activate([
            courseImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            courseImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            courseImageView.widthAnchor.constraint(equalToConstant: 120),
            courseImageView.heightAnchor.constraint(equalTo: courseImageView.widthAnchor),
            {$0.priority = .defaultHigh; return $0} (contentView.bottomAnchor.constraint(equalTo: courseImageView.bottomAnchor)),
            
            stackView.topAnchor.constraint(equalTo: courseImageView.topAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: courseImageView.trailingAnchor, constant: 10),
            contentView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: stackView.bottomAnchor),
            
        ])
    }
}
