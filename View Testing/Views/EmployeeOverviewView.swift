//
//  EmployeeOverviewView.swift
//  View Testing
//
//  Created by Stephen Anthony on 27/10/2022.
//

import UIKit

/// The view used to show the overview of an employee.
final class EmployeeOverviewView: UIView {
    
    /// The employee whose details are shown.
    var employee: Employee? {
        didSet {
            imageView.image = UIImage(named: employee?.name ?? "")
            nameLabel.text = employee?.name
            jobRoleLabel.text = employee?.jobRole
        }
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemBackground
        imageView.layer.cornerRadius = 30
        imageView.addConstraints([
            imageView.widthAnchor.constraint(equalToConstant: imageView.layer.cornerRadius * 2),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .preferredFont(forTextStyle: .headline)
        nameLabel.adjustsFontForContentSizeCategory = true
        nameLabel.adjustsFontSizeToFitWidth = true
        return nameLabel
    }()
    
    private let jobRoleLabel: UILabel = {
        let jobRoleLabel = UILabel()
        jobRoleLabel.translatesAutoresizingMaskIntoConstraints = false
        jobRoleLabel.font = .preferredFont(forTextStyle: .body)
        jobRoleLabel.textColor = .secondaryLabel
        jobRoleLabel.adjustsFontForContentSizeCategory = true
        jobRoleLabel.adjustsFontSizeToFitWidth = true
        return jobRoleLabel
    }()
    
    private let labelsContainerView: UIView = {
        let labelsContainerView = UIView()
        labelsContainerView.translatesAutoresizingMaskIntoConstraints = false
        return labelsContainerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        layer.cornerRadius = 8
        layer.cornerCurve = .continuous
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        
        addSubview(imageView)
        addSubview(labelsContainerView)
        labelsContainerView.addSubview(nameLabel)
        labelsContainerView.addSubview(jobRoleLabel)
        
        addConstraints([
            imageView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            imageView.bottomAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.bottomAnchor),
            imageView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor).settingPriority(.defaultLow)
        ])
        
        addConstraints([
            labelsContainerView.leadingAnchor.constraint(equalToSystemSpacingAfter: imageView.trailingAnchor, multiplier: 1.0),
            labelsContainerView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            labelsContainerView.topAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.topAnchor),
            labelsContainerView.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor)
        ])
        
        labelsContainerView.addConstraints([
            nameLabel.leadingAnchor.constraint(equalTo: labelsContainerView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: labelsContainerView.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: labelsContainerView.topAnchor)
        ])
        
        labelsContainerView.addConstraints([
            jobRoleLabel.leadingAnchor.constraint(equalTo: labelsContainerView.leadingAnchor),
            jobRoleLabel.trailingAnchor.constraint(equalTo: labelsContainerView.trailingAnchor),
            jobRoleLabel.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: nameLabel.lastBaselineAnchor, multiplier: 1.0),
            jobRoleLabel.bottomAnchor.constraint(equalTo: labelsContainerView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension NSLayoutConstraint {
    /// Allows the priority of a constraint to be set at construction time.
    /// - Parameter priority: The priority that the receiver should have.
    /// - Returns: The receiver.
    func settingPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
