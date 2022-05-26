//
//  BigButton.swift
//  URLSessionDownloadImage
//
//  Created by Muller Alexander on 23.05.2022.
//

import UIKit

class BigButton: UIControl {
    
    let titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .preferredFont(forTextStyle: .title1)
        $0.textColor = .white
        
        return $0
    }(UILabel(frame: .zero))
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        backgroundColor = tintColor
    }
    
    override var isHighlighted: Bool {
        didSet {
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: isHighlighted ? 0.2 : 0.5, delay: 0) {
                self.alpha = self.isHighlighted ? 0.4 : 1
            }
        }
    }
    
    override var intrinsicContentSize: CGSize {
        .init(width: UIView.noIntrinsicMetric, height: 56)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}

extension BigButton {
    private func setupConstraints() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16),
            trailingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 16)
        ])
    }
}

extension BigButton {
    private func setupAppearance() {
        layer.cornerCurve = .continuous
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}
