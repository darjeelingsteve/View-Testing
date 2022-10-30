//
//  EmployeeDetailsViewControllerTests.swift
//  View TestingTests
//
//  Created by Stephen Anthony on 30/10/2022.
//

import XCTest
import DJATesting
@testable import View_Testing

final class EmployeeDetailsViewControllerTests: XCTestCase {
    private var employeeDetailsViewController: EmployeeDetailsViewController!
    private var testEmployee: Employee!
    
    override func setUp() {
        super.setUp()
        let employeeData = try! Data(contentsOf: Bundle(for: EmployeeDetailsViewController.self).url(forResource: "Employees", withExtension: "json")!)
        testEmployee = try! JSONDecoder().decode([Employee].self, from: employeeData).first
    }
    
    override func tearDown() {
        employeeDetailsViewController = nil
        testEmployee = nil
        super.tearDown()
    }
    
    private func givenAnEmployeeDetailsViewController() {
        employeeDetailsViewController = EmployeeDetailsViewController(employee: testEmployee)
    }
    
    private func whenTheViewLoads() {
        employeeDetailsViewController.loadViewIfNeeded()
    }
}

// MARK: - Employee Overview
extension EmployeeDetailsViewControllerTests {
    func testItShowsTheEmployeeInTheOverviewView() {
        givenAnEmployeeDetailsViewController()
        whenTheViewLoads()
        XCTAssertEqual(employeeDetailsViewController.employeeOverviewView.employee, testEmployee)
    }
}

// MARK: - Employee Biography
extension EmployeeDetailsViewControllerTests {
    func testItConfiguresTheBiographyTitleLabelCorrectly() {
        givenAnEmployeeDetailsViewController()
        whenTheViewLoads()
        XCTAssertEqual(employeeDetailsViewController.biographyTitleLabel.text, "Biography".uppercased())
        XCTAssertEqual(employeeDetailsViewController.biographyTitleLabel.textColor, .secondaryLabel)
        XCTAssertEqual(employeeDetailsViewController.biographyTitleLabel.numberOfLines, 1)
        XCTAssertTrue(employeeDetailsViewController.biographyTitleLabel.adjustsFontForContentSizeCategory)
        XCTAssertTrue(employeeDetailsViewController.biographyTitleLabel.adjustsFontSizeToFitWidth)
    }
    
    func testItConfiguresTheBiographyLabelCorrectly() {
        givenAnEmployeeDetailsViewController()
        whenTheViewLoads()
        XCTAssertEqual(employeeDetailsViewController.biographyLabel.textColor, .label)
        XCTAssertEqual(employeeDetailsViewController.biographyLabel.font, .preferredFont(forTextStyle: .body))
        XCTAssertEqual(employeeDetailsViewController.biographyLabel.numberOfLines, 0)
        XCTAssertTrue(employeeDetailsViewController.biographyLabel.adjustsFontForContentSizeCategory)
    }
    
    func testItSetsTheEmployeesBiographyAsTheBiographyLabelText() {
        givenAnEmployeeDetailsViewController()
        whenTheViewLoads()
        XCTAssertEqual(employeeDetailsViewController.biographyLabel.text, testEmployee.biography)
    }
}

private extension EmployeeDetailsViewController {
    var employeeOverviewView: EmployeeOverviewView {
        view.subview(ofType: EmployeeOverviewView.self, withAccessibilityIdentifier: "employee_overview")!
    }
    
    var biographyTitleLabel: UILabel {
        view.subview(ofType: UILabel.self, withAccessibilityIdentifier: "biography_title")!
    }
    
    var biographyLabel: UILabel {
        view.subview(ofType: UILabel.self, withAccessibilityIdentifier: "biography")!
    }
}
