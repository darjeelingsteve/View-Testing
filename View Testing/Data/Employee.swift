//
//  Employee.swift
//  View Testing
//
//  Created by Stephen Anthony on 27/10/2022.
//

import Foundation

/// Represents an individual employee.
struct Employee: Codable, Hashable {
    
    /// The employee's name.
    let name: String
    
    /// The employee's biography.
    let biography: String
    
    /// The employee's job role.
    let jobRole: String
}
