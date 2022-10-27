//
//  EmployeeDetailsViewController.swift
//  View Testing
//
//  Created by Stephen Anthony on 27/10/2022.
//

import UIKit

/// The view controller responsible for showing the details of an employee.
final class EmployeeDetailsViewController: UIViewController {
    private let employeeOverviewView: EmployeeOverviewView = {
        let employeeOverviewView = EmployeeOverviewView()
        employeeOverviewView.translatesAutoresizingMaskIntoConstraints = false
        return employeeOverviewView
    }()
    
    private let biographyTitleLabel: UILabel = {
        let biographyTitleLabel = UILabel()
        biographyTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        biographyTitleLabel.text = "Biography".uppercased()
        biographyTitleLabel.textColor = .secondaryLabel
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .callout).addingAttributes([
            .featureSettings: [
                [
                    UIFontDescriptor.FeatureKey.type: kUpperCaseType,
                    UIFontDescriptor.FeatureKey.selector: kUpperCaseSmallCapsSelector,
                ],
            ],
            .traits: [
                UIFontDescriptor.TraitKey.weight: UIFont.Weight.semibold,
            ],
        ])
        biographyTitleLabel.font = UIFont(descriptor: descriptor, size: 0)
        biographyTitleLabel.adjustsFontForContentSizeCategory = true
        biographyTitleLabel.adjustsFontSizeToFitWidth = true
        return biographyTitleLabel
    }()
    
    private let biographyLabel: UILabel = {
        let biographyLabel = UILabel()
        biographyLabel.translatesAutoresizingMaskIntoConstraints = false
        biographyLabel.font = .preferredFont(forTextStyle: .body)
        biographyLabel.numberOfLines = 0
        biographyLabel.adjustsFontForContentSizeCategory = true
        return biographyLabel
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.preservesSuperviewLayoutMargins = true
        return scrollView
    }()
    
    init(employee: Employee) {
        super.init(nibName: nil, bundle: nil)
        employeeOverviewView.employee = employee
        biographyLabel.text = employee.biography
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(employeeOverviewView)
        scrollView.addSubview(biographyTitleLabel)
        scrollView.addSubview(biographyLabel)
        
        view.addConstraints([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        scrollView.addConstraints([
            employeeOverviewView.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor),
            employeeOverviewView.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor),
            employeeOverviewView.centerXAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.centerXAnchor),
            employeeOverviewView.topAnchor.constraint(equalTo: scrollView.topAnchor),
        ])
        
        scrollView.addConstraints([
            biographyTitleLabel.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor),
            biographyTitleLabel.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor),
            biographyTitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: employeeOverviewView.bottomAnchor, multiplier: 2.0)
        ])
        
        scrollView.addConstraints([
            biographyLabel.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor),
            biographyLabel.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor),
            biographyLabel.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: biographyTitleLabel.lastBaselineAnchor, multiplier: 1.0),
            biographyLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}
