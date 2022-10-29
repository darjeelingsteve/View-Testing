// 
//  EmployeeOverviewViewTests.swift
//  View TestingTests
//
//  Created by Stephen Anthony on 27/10/2022.
//

import XCTest
import DJATesting
@testable import View_Testing

final class EmployeeOverviewViewTests: XCTestCase {
    private var employeeOverviewView: EmployeeOverviewView!
    private var testEmployee: Employee!
    
    override func setUp() {
        super.setUp()
        let employeeData = try! Data(contentsOf: Bundle(for: EmployeeOverviewView.self).url(forResource: "Employees", withExtension: "json")!)
        testEmployee = try! JSONDecoder().decode([Employee].self, from: employeeData).first
    }

    override func tearDown() {
        employeeOverviewView = nil
        testEmployee = nil
        super.tearDown()
    }
    
    private func givenAnEmployeeOverviewView() {
        employeeOverviewView = EmployeeOverviewView()
        employeeOverviewView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func whenTheViewLaysOut() {
        employeeOverviewView.layoutIfNeeded()
    }
    
    private func whenTheViewEmployee(isSetTo employee: Employee) {
        employeeOverviewView.employee = employee
    }
}

// MARK: - View Configuration
extension EmployeeOverviewViewTests {
    func testItConfiguresItsBackgroundColourCorrectly() {
        givenAnEmployeeOverviewView()
        XCTAssertEqual(employeeOverviewView.backgroundColor, .secondarySystemGroupedBackground)
    }
    
    func testItConfiguresItsLayerCorrectly() {
        givenAnEmployeeOverviewView()
        XCTAssertEqual(employeeOverviewView.layer.cornerRadius, 8)
        XCTAssertEqual(employeeOverviewView.layer.cornerCurve, .continuous)
    }
    
    func testItConfiguresItsLayoutMarginsCorrectly() {
        givenAnEmployeeOverviewView()
        XCTAssertEqual(employeeOverviewView.directionalLayoutMargins, NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
    }
}

// MARK: - Image View
extension EmployeeOverviewViewTests {
    func testItConfiguresTheImageViewCorrectly() {
        givenAnEmployeeOverviewView()
        whenTheViewLaysOut()
        XCTAssertEqual(employeeOverviewView.imageView.contentMode, .scaleAspectFill)
        XCTAssertTrue(employeeOverviewView.imageView.clipsToBounds)
        XCTAssertEqual(employeeOverviewView.imageView.layer.cornerRadius, employeeOverviewView.imageView.frame.width / 2)
    }
    
    func testItSetsTheEmployeeImageOnItsImageView() {
        givenAnEmployeeOverviewView()
        whenTheViewEmployee(isSetTo: testEmployee)
        XCTAssertEqual(employeeOverviewView.imageView.image, UIImage(named: testEmployee.name))
    }
}

// MARK: - Name Label
extension EmployeeOverviewViewTests {
    func testItConfiguresTheNameLabelCorrectly() {
        givenAnEmployeeOverviewView()
        XCTAssertEqual(employeeOverviewView.nameLabel.font, .preferredFont(forTextStyle: .headline))
        XCTAssertEqual(employeeOverviewView.nameLabel.textColor, .label)
        XCTAssertEqual(employeeOverviewView.nameLabel.numberOfLines, 1)
        XCTAssertTrue(employeeOverviewView.nameLabel.adjustsFontForContentSizeCategory)
        XCTAssertTrue(employeeOverviewView.nameLabel.adjustsFontSizeToFitWidth)
    }
    
    func testItSetsTheEmployeeNameOnItsNameLabel() {
        givenAnEmployeeOverviewView()
        whenTheViewEmployee(isSetTo: testEmployee)
        XCTAssertEqual(employeeOverviewView.nameLabel.text, testEmployee.name)
    }
}

// MARK: - Job Role Label
extension EmployeeOverviewViewTests {
    func testItConfiguresTheJobRoleLabelCorrectly() {
        givenAnEmployeeOverviewView()
        XCTAssertEqual(employeeOverviewView.jobRoleLabel.font, .preferredFont(forTextStyle: .body))
        XCTAssertEqual(employeeOverviewView.jobRoleLabel.textColor, .secondaryLabel)
        XCTAssertEqual(employeeOverviewView.jobRoleLabel.numberOfLines, 1)
        XCTAssertTrue(employeeOverviewView.jobRoleLabel.adjustsFontForContentSizeCategory)
        XCTAssertTrue(employeeOverviewView.jobRoleLabel.adjustsFontSizeToFitWidth)
    }
    
    func testItSetsTheEmployeeJobRoleOnItsJobRoleLabel() {
        givenAnEmployeeOverviewView()
        whenTheViewEmployee(isSetTo: testEmployee)
        XCTAssertEqual(employeeOverviewView.jobRoleLabel.text, testEmployee.jobRole)
    }
}

// MARK: - Subview Layout
extension EmployeeOverviewViewTests {
    func testItAlignsItsImageViewWithTheLeadingTopMargin() {
        givenAnEmployeeOverviewView()
        whenTheViewLaysOut()
        XCTAssertEqual(employeeOverviewView.imageView.frame.origin, CGPoint(x: employeeOverviewView.bounds.minX + employeeOverviewView.directionalLayoutMargins.leading,
                                                                            y: employeeOverviewView.bounds.minY + employeeOverviewView.directionalLayoutMargins.top))
    }
    
    func testItPositionsTheNameLabelAboveTheJobRoleLabel() {
        givenAnEmployeeOverviewView()
        whenTheViewLaysOut()
        XCTAssertGreaterThan(employeeOverviewView.jobRoleLabel.frame.minY, employeeOverviewView.nameLabel.frame.maxY)
    }
    
    func testItPositionsTheNameAndJobRoleLabelsToTheTrailingEdgeOfTheImageView() {
        givenAnEmployeeOverviewView()
        whenTheViewLaysOut()
        let imageViewFrameInViewCoordinates = employeeOverviewView.convert(employeeOverviewView.imageView.bounds, from: employeeOverviewView.imageView)
        let nameLabelFrameInViewCoordinates = employeeOverviewView.convert(employeeOverviewView.nameLabel.bounds, from: employeeOverviewView.nameLabel)
        let jobRoleLabelFrameInViewCoordinates = employeeOverviewView.convert(employeeOverviewView.jobRoleLabel.bounds, from: employeeOverviewView.jobRoleLabel)
        XCTAssertGreaterThan(nameLabelFrameInViewCoordinates.minX, imageViewFrameInViewCoordinates.maxX)
        XCTAssertGreaterThan(jobRoleLabelFrameInViewCoordinates.minX, imageViewFrameInViewCoordinates.maxX)
    }
}

private extension EmployeeOverviewView {
    var imageView: UIImageView {
        subview(ofType: UIImageView.self, withAccessibilityIdentifier: "photo_image_view")!
    }
    
    var nameLabel: UILabel {
        subview(ofType: UILabel.self, withAccessibilityIdentifier: "name")!
    }
    
    var jobRoleLabel: UILabel {
        subview(ofType: UILabel.self, withAccessibilityIdentifier: "job_role")!
    }
}
