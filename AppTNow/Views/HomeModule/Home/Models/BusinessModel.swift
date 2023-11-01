//
//  BusinessModel.swift
//  AppTNow
//
//  Created by Qazi Ammar Arshad on 24/10/2023.
//

struct BusinessList: Codable {
    let businessInRadius: [Business]
}


// MARK: - DataClass
struct Business: Codable, Identifiable {
    let id: Int?
    let name, password, email, profile: String?
    let businessCategoryID, latitude, longitude, description: String?
    let code, deviceID, payment, loyality: String?
    let status, createdAt, updatedAt, distance: String?
    let address: String?
    var reviews: [Review]?
    let averageRating: Double?
    let isReviewd: Bool?
    let services: [Service]?
    let businessImages: [BusinessImage]?
    let businessTimings: [BusinessTiming]?
    var isSaved: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, name, password, email, profile
        case businessCategoryID = "business_category_id"
        case latitude, longitude, description, code
        case deviceID = "device_id"
        case payment, loyality, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case distance, address, reviews
        case averageRating = "average_rating"
        case isReviewd = "is_reviewd"
        case services
        case businessImages = "business_images"
        case businessTimings = "business_timings"
        case isSaved = "check_saved_business"
    }
}

// MARK: - BusinessImage
struct BusinessImage: Codable, Identifiable {
    let id: Int
    let businessID, image, status, createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case businessID = "business_id"
        case image, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - BusinessTiming
struct BusinessTiming: Codable {
    let id: Int
    let businessID, day, startTime, endTime: String
    let status, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case businessID = "business_id"
        case day
        case startTime = "start_time"
        case endTime = "end_time"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Review
struct Review: Codable, Identifiable {
    let id: Int
    let userID, businessID, review, rating: String
    let status: String?
    let createdAt, updatedAt: String
    let user: User?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case businessID = "business_id"
        case review, rating, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case user
    }
}


// MARK: - Service
struct Service: Codable, Identifiable {
    let id: Int
    let name, businessID, image, duration: String
    let status, paid, payment, points: String
    let price, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case businessID = "business_id"
        case image, duration, status, paid, payment, points, price
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

let reviewsForBusiness = [
    Review(
        id: 1,
        userID: "1",
        businessID: "1",
        review: "Overall Good",
        rating: "2",
        status: "1",
        createdAt: "02/10/23 19:24",
        updatedAt: "02/10/23 19:24",
        user: User(
            id: 1,
            name: "testing",
            email: "testing@gmail.com",
            phone: "+923202114483",
            image: "users_profile/jPchJNp3u15WSq9.png",
            code: "0", status: "1",
            latitude: "31.466524",
            longitude: "74.268876",
            fCode: "",
            deviceID: "asdsddsdtyrty",
            gToken: "",
            fbToken: "",
            aCode: "",
            createdAt: "02/10/23 18:01",
            updatedAt: "24/10/23 10:58", token: ""
        )
    ),
    Review(
        id: 4,
        userID: "1",
        businessID: "1",
        review: "Overall Good and I liked it",
        rating: "2",
        status: "1",
        createdAt: "02/10/23 19:24",
        updatedAt: "02/10/23 19:24",
        user: User(
            id: 1,
            name: "testing",
            email: "testing@gmail.com",
            phone: "+923202114483",
            image: "users_profile/jPchJNp3u15WSq9.png",
            code: "0", status: "1",
            latitude: "31.466524",
            longitude: "74.268876",
            fCode: "",
            deviceID: "asdsddsdtyrty",
            gToken: "",
            fbToken: "",
            aCode: "",
            createdAt: "02/10/23 18:01",
            updatedAt: "24/10/23 10:58", token: ""
        )
    ),
    Review(
        id: 7,
        userID: "1",
        businessID: "1",
        review: "Overall Good",
        rating: "2",
        status: "1",
        createdAt: "02/10/23 19:24",
        updatedAt: "02/10/23 19:24",
        user: User(
            id: 1,
            name: "testing",
            email: "testing@gmail.com",
            phone: "+923202114483",
            image: "users_profile/jPchJNp3u15WSq9.png",
            code: "0", status: "1",
            latitude: "31.466524",
            longitude: "74.268876",
            fCode: "",
            deviceID: "asdsddsdtyrty",
            gToken: "",
            fbToken: "",
            aCode: "",
            createdAt: "02/10/23 18:01",
            updatedAt: "24/10/23 10:58", token: ""
        )
    )
]
let mockServiceForBusiness = [
    Service(
        id: 1,
        name: "cloud computing",
        businessID: "1",
        image: "service_images/1696270373_651b08255a5c2.jpg",
        duration: "30",
        status: "1",
        paid: "1",
        payment: "1",
        points: "10",
        price: "10",
        createdAt: "02/10/23 18:12",
        updatedAt: "02/10/23 18:12"
    ),
    Service(
        id: 2,
        name: "Web Development",
        businessID: "1",
        image: "service_images/1696272166_651b0f261c103.jpg",
        duration: "30",
        status: "1",
        paid: "1",
        payment: "1",
        points: "10",
        price: "10",
        createdAt: "02/10/23 18:42",
        updatedAt: "02/10/23 18:42"
    )
]
let mockImagesForBusiness = [
    BusinessImage(
        id: 1,
        businessID: "1",
        image: "business_images/1696272428_651b102cdff4f.jpeg",
        status: "1",
        createdAt: "02/10/23 18:47",
        updatedAt: "02/10/23 18:47"
    ),
    BusinessImage(
        id: 2,
        businessID: "1",
        image: "business_images/1696272428_651b102ce1d10.jpeg",
        status: "1",
        createdAt: "02/10/23 18:47",
        updatedAt: "02/10/23 18:47"
    )
]
let mockTimingForBusiness = [
    BusinessTiming(
        id: 1,
        businessID: "1",
        day: "Monday",
        startTime: "10:00:00",
        endTime: "18:00:00",
        status: "1",
        createdAt: "02/10/23 18:27",
        updatedAt: "02/10/23 18:27"
    ),
    BusinessTiming(
        id: 2,
        businessID: "1",
        day: "Tuesday",
        startTime: "10:00:00",
        endTime: "18:00:00",
        status: "1",
        createdAt: "02/10/23 18:27",
        updatedAt: "02/10/23 18:27"
    ),
    BusinessTiming(
        id: 3,
        businessID: "1",
        day: "Wednesday",
        startTime: "10:00:00",
        endTime: "18:00:00",
        status: "1",
        createdAt: "02/10/23 18:27",
        updatedAt: "02/10/23 18:27"
    ),
    BusinessTiming(
        id: 4,
        businessID: "1",
        day: "Thursday",
        startTime: "10:00:00",
        endTime: "18:00:00",
        status: "1",
        createdAt: "02/10/23 18:27",
        updatedAt: "02/10/23 18:27"
    ),
    BusinessTiming(
        id: 5,
        businessID: "1",
        day: "Friday",
        startTime: "10:00:00",
        endTime: "18:00:00",
        status: "1",
        createdAt: "02/10/23 18:27",
        updatedAt: "02/10/23 18:27"
    ),
    BusinessTiming(
        id: 6,
        businessID: "1",
        day: "Saturday",
        startTime: "00:00:00",
        endTime: "00:00:00",
        status: "1",
        createdAt: "02/10/23 18:27",
        updatedAt: "02/10/23 18:27"
    ),
    BusinessTiming(
        id: 7,
        businessID: "1",
        day: "Sunday",
        startTime: "00:00:00",
        endTime: "00:00:00",
        status: "1",
        createdAt: "02/10/23 18:27",
        updatedAt: "02/10/23 18:27"
    )
]

let mockBusinessList = [Business(
    id: 1,
    name: "It Management",
    password: "12345678@@",
    email: "business@gmail.com",
    profile: "business_profiles/1696272502_651b10760c0fc.jpg",
    businessCategoryID: "1",
    latitude: "31.466524",
    longitude: "74.268876",
    description: "We Provide IT Solutions",
    code: "0",
    deviceID: "",
    payment: "1",
    loyality: "1",
    status: "1",
    createdAt: "02/10/23 18:04",
    updatedAt: "02/10/23 18:48",
    distance: "1.1959895377814527",
    address: "Plot 443, Block L Phase 2 Johar Town, Lahore, Punjab, Pakistan",
    reviews: reviewsForBusiness,
    averageRating: 2.3,
    isReviewd: false,
    
    services: mockServiceForBusiness,
    businessImages: mockImagesForBusiness,
    businessTimings: mockTimingForBusiness,
    isSaved: false
    
), Business(
    id: 2,
    name: "Tech Solutions",
    password: "87654321@@",
    email: "tech@example.com",
    profile: "business_profiles/1696272502_651b10760c0fd.jpg",
    businessCategoryID: "2",
    latitude: "31.466525",
    longitude: "74.268877",
    description: "Your Technology Partner",
    code: "0",
    deviceID: "",
    payment: "1",
    loyality: "1",
    status: "1",
    createdAt: "02/10/23 19:04",
    updatedAt: "02/10/23 19:48",
    distance: "2.1959895377814527",
    address: "123 Main St, Tech Town, Techland",
    reviews: [],
    averageRating: 3.5,
    isReviewd: true,
    services: [],
    businessImages: [],
    businessTimings: [],
    isSaved: false
),Business(
    id: 3,
    name: "Software Creations",
    password: "password123@@",
    email: "software@example.com",
    profile: "business_profiles/1696272502_651b10760c0fe.jpg",
    businessCategoryID: "3",
    latitude: "31.466526",
    longitude: "74.268878",
    description: "Crafting Software Solutions",
    code: "0",
    deviceID: "",
    payment: "1",
    loyality: "1",
    status: "1",
    createdAt: "02/10/23 20:04",
    updatedAt: "02/10/23 20:48",
    distance: "3.1959895377814527",
    address: "456 Software Rd, Codeville, Techland",
    reviews: reviewsForBusiness,
    averageRating: 4.2,
    isReviewd: false,
    services: [],
    businessImages: [],
    businessTimings: [],
    isSaved: false
)]



