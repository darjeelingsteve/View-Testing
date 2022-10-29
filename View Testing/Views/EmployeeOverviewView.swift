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
            photoImageView.image = UIImage(named: employee?.name ?? "")
            nameLabel.text = employee?.name
            jobRoleLabel.text = employee?.jobRole
        }
    }
    
    /// The image view used to display the employee's photo.
    private let photoImageView: UIImageView = {
        let photoImageView = UIImageView()
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        photoImageView.layer.cornerRadius = 30
        photoImageView.addConstraints([
            photoImageView.widthAnchor.constraint(equalToConstant: photoImageView.layer.cornerRadius * 2),
            photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor)
        ])
        photoImageView.accessibilityIdentifier = "photo_image_view"
        return photoImageView
    }()
    
    /// The label used to display the employee's name.
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .preferredFont(forTextStyle: .headline)
        nameLabel.adjustsFontForContentSizeCategory = true
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.accessibilityIdentifier = "name"
        return nameLabel
    }()
    
    /// The label used to display the employee's job role.
    private let jobRoleLabel: UILabel = {
        let jobRoleLabel = UILabel()
        jobRoleLabel.translatesAutoresizingMaskIntoConstraints = false
        jobRoleLabel.font = .preferredFont(forTextStyle: .body)
        jobRoleLabel.textColor = .secondaryLabel
        jobRoleLabel.adjustsFontForContentSizeCategory = true
        jobRoleLabel.adjustsFontSizeToFitWidth = true
        jobRoleLabel.accessibilityIdentifier = "job_role"
        return jobRoleLabel
    }()
    
    private let labelsContainerView: UIView = {
        let labelsContainerView = UIView()
        labelsContainerView.translatesAutoresizingMaskIntoConstraints = false
        return labelsContainerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemGroupedBackground
        layer.cornerRadius = 8
        layer.cornerCurve = .continuous
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        
        addSubview(photoImageView)
        addSubview(labelsContainerView)
        labelsContainerView.addSubview(nameLabel)
        labelsContainerView.addSubview(jobRoleLabel)
        
        addConstraints([
            photoImageView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            photoImageView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            photoImageView.bottomAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.bottomAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor).settingPriority(.defaultLow)
        ])
        
        addConstraints([
            labelsContainerView.leadingAnchor.constraint(equalToSystemSpacingAfter: photoImageView.trailingAnchor, multiplier: 1.0),
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
