//
//  Models.swift
//  InstagramClone
//
//  Created by Enes Sirkecioğlu on 11.07.2021.
//

import Foundation

struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}

public enum Gender {
    case male, female, other
}

public struct User {
    let username: String
    let bio: String
    let name: (first: String, last: String)
    let birthDate: Date
    let gender: Gender
    let counts: UserCount
    let joinDate: Date
}


public enum UserPostType {
    case photo, video
}

/// Represent a user post
public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL
    let caption: String?
    let likeCount: [PostLike]
    let comments: [PostComment]
    let createdDate: Date
    let taggedUsers: [User]
}

struct PostLike {
    let username: String
    let postIdentifier: String
}

struct CommentLike {
    let username: String
    let commentIdentifier: String
}

struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createdDate: Date
    let likes: [CommentLike]
}
