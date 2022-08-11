//
//  EmptyStateView.swift
//  EmptyState
//
//  Created by Jorge Ovalle on 12/6/18.
//  Copyright © 2018 Wizeline. All rights reserved.
//

import Foundation
import UIKit

final class EmptyStateView: UIView {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var imageContainer: UIView = {
        let view = UIView()
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            view.heightAnchor.constraint(equalTo: imageView.heightAnchor)])
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.accessibilityTraits = [.header]
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    private lazy var containerView: UIView = {
        let containerView = UIView(frame: .zero)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    var accessibilityDescription: String? {
        get {
            return self.containerView.accessibilityLabel
        }
        set {
            self.containerView.isAccessibilityElement = (newValue != nil)
            self.containerView.accessibilityLabel = newValue
        }
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        addSubview(containerView)
        
        containerView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            containerView.heightAnchor.constraint(equalTo: stackView.heightAnchor),
            stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor)])
    }
    
    func configData(image: UIImage?, title: NSAttributedString?, desc: NSAttributedString?) {
        self.imageView.image = image
        self.titleLabel.attributedText = title
        self.descriptionLabel.attributedText = desc
        
        if image != nil {
            self.stackView.addArrangedSubview(imageContainer)
        }
        
        if title != nil {
            self.stackView.addArrangedSubview(titleLabel)
        }
        
        if desc != nil {
            self.stackView.addArrangedSubview(descriptionLabel)
        }
    }
    
    override public func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.frame = self.superview?.bounds ?? .zero
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    struct Defaults {
        static let height = CGFloat(160)
        static let image = UIImage(systemName: "info.circle")
        static let title = NSAttributedString(string: "Empty DataSet", attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)])
        static let description = NSAttributedString(string: "Oops There's no data.", attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption1)])
    }
    
}
