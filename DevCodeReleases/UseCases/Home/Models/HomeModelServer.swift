// 
//  HomeModelServer.swift
//  XcodeReleases
//
//  Created by Raul on 30/5/23.
//

import Foundation

struct VersionModel: Codable, Identifiable, Hashable, Equatable {
    static func == (lhs: VersionModel, rhs: VersionModel) -> Bool {
        lhs.id == rhs.id
    }

    let id = UUID().uuidString
    let compilers: Compilers?
    let requires: String?
    let date: DateClass?
    let links: Links?
    let version: Version?
    let sdks: Sdks?
    let name: String?
    let checksums: Checksums?
}

// MARK: - Checksums
struct Checksums: Codable {
    let sha1: String?
}

// MARK: - Compilers
struct Compilers: Codable {
    let clang, swift, llvm, llvmGCC: [Clang]?
    let gcc: [Clang]?

    enum CodingKeys: String, CodingKey {
        case clang, swift, llvm
        case llvmGCC = "llvm_gcc"
        case gcc
    }
}

// MARK: - Clang
struct Clang: Codable {
    let number, build: String?
    let release: ClangRelease?
}

// MARK: - ClangRelease
struct ClangRelease: Codable {
    let release: Bool?
}

// MARK: - DateClass
struct DateClass: Codable {
    let year, month, day: Int?
}

// MARK: - Links
struct Links: Codable {
    let notes, download: Download?
}

// MARK: - Download
struct Download: Codable {
    let url: String?
}

// MARK: - Sdks
struct Sdks: Codable {
    let macOS, tvOS, iOS, watchOS: [Clang]?
}

// MARK: - Version
struct Version: Codable {
    let number, build: String?
    let release: VersionRelease?
}

// MARK: - VersionRelease
struct VersionRelease: Codable {
    let rc: Int?
    let release: Bool?
    let beta: Int?
    let gm: Bool?
    let gmSeed, dp: Int?
}

typealias HomeModelServer = [VersionModel]

extension VersionModel {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
