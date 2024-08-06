//
//  CommunitiesModel.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 08/07/24.
//

import Foundation
import SwiftUI

struct Community: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var description: String
    var subgroups: [Subgroup]
    var members: [Member]
    var createdAt: Date
    
    init(id: UUID = UUID(), name: String, description: String, subgroups: [Subgroup] = [], members: [Member] = [], createdAt: Date = Date()) {
        self.id = id
        self.name = name
        self.description = description
        self.subgroups = subgroups
        self.members = members
        self.createdAt = createdAt
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(description)
        hasher.combine(createdAt)
    }
    
    static func == (lhs: Community, rhs: Community) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.description == rhs.description &&
        lhs.createdAt == rhs.createdAt
    }
}

struct Subgroup: Identifiable, Hashable {
    let id: UUID
    var name: String
    var members: [Member]
    
    init(id: UUID = UUID(), name: String, members: [Member] = []) {
        self.id = id
        self.name = name
        self.members = members
    }
}

struct Member: Identifiable, Hashable {
    let id: UUID
    var name: String
    var phoneNumber: String
    var role: MemberRole
    
    init(id: UUID = UUID(), name: String, phoneNumber: String, role: MemberRole = .member) {
        self.id = id
        self.name = name
        self.phoneNumber = phoneNumber
        self.role = role
    }
}

enum MemberRole: String, CaseIterable {
    case admin
    case moderator
    case member
}

class CommunitiesMockData {
    static let community = Community(
        name: "Neighborhood Watch",
        description: "A community for local residents to discuss neighborhood safety and events.",
        subgroups: [
            Subgroup(name: "General Discussion", members: [
                Member(name: "John Doe", phoneNumber: "+1234567890", role: .admin),
                Member(name: "Jane Smith", phoneNumber: "+1987654321", role: .moderator),
                Member(name: "Alice Johnson", phoneNumber: "+1122334455", role: .member)
            ]),
            Subgroup(name: "Events Planning", members: [
                Member(name: "Jane Smith", phoneNumber: "+1987654321", role: .moderator),
                Member(name: "Bob Brown", phoneNumber: "+1555666777", role: .member),
                Member(name: "Carol White", phoneNumber: "+1999888777", role: .member)
            ])
        ],
        members: [
            Member(name: "John Doe", phoneNumber: "+1234567890", role: .admin),
            Member(name: "Jane Smith", phoneNumber: "+1987654321", role: .moderator),
            Member(name: "Alice Johnson", phoneNumber: "+1122334455", role: .member),
            Member(name: "Bob Brown", phoneNumber: "+1555666777", role: .member),
            Member(name: "Carol White", phoneNumber: "+1999888777", role: .member)
        ]
    )
    
    static let communities = [
        community,
        Community(
            name: "Tech Enthusiasts",
            description: "A community for discussing the latest in technology and gadgets.",
            subgroups: [
                Subgroup(name: "Mobile Devices", members: [
                    Member(name: "Emily Chen", phoneNumber: "+1112223333", role: .admin),
                    Member(name: "David Lee", phoneNumber: "+1444555666", role: .member)
                ]),
                Subgroup(name: "AI and Machine Learning", members: [
                    Member(name: "Emily Chen", phoneNumber: "+1112223333", role: .admin),
                    Member(name: "Frank Wilson", phoneNumber: "+1777888999", role: .moderator)
                ])
            ],
            members: [
                Member(name: "Emily Chen", phoneNumber: "+1112223333", role: .admin),
                Member(name: "David Lee", phoneNumber: "+1444555666", role: .member),
                Member(name: "Frank Wilson", phoneNumber: "+1777888999", role: .moderator)
            ]
        ),
        Community(
            name: "Book Club",
            description: "A community for book lovers to discuss their favorite reads.",
            subgroups: [
                Subgroup(name: "Fiction", members: [
                    Member(name: "Grace Taylor", phoneNumber: "+2223334444", role: .admin),
                    Member(name: "Henry Johnson", phoneNumber: "+2555666777", role: .member)
                ]),
                Subgroup(name: "Non-Fiction", members: [
                    Member(name: "Grace Taylor", phoneNumber: "+2223334444", role: .admin),
                    Member(name: "Isabel Rodriguez", phoneNumber: "+2888999000", role: .moderator)
                ])
            ],
            members: [
                Member(name: "Grace Taylor", phoneNumber: "+2223334444", role: .admin),
                Member(name: "Henry Johnson", phoneNumber: "+2555666777", role: .member),
                Member(name: "Isabel Rodriguez", phoneNumber: "+2888999000", role: .moderator)
            ]
        )
    ]
}
