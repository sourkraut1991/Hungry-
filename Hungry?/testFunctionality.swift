////
////  testFunctionality.swift
////  Hungry?
////
////  Created by Ed Kraus on 7/19/23.
////
//
////import XCTest
////@testable import Hungry?
//
//final class testFunctionality: XCTestCase {
//
//        func test_note_is_updated() {
//            // Given
//            let dataStore = DataSource()
//            let bucketItem = RestaurantItem(name: "Restaurant", note: "Old note", category: "")
//            let editRestaurant = EditRestaurant(bucketItem: bucketItem, dataStore: dataStore)
//
//            // When
//            editRestaurant.note = "New note"
//            editRestaurant.updateCategory(bucketItem: bucketItem, category: "")
//
//            // Then
//            XCTAssertEqual(bucketItem.note, "New note")
//        }
//
//        func test_category_is_updated() {
//            // Given
//            let dataStore = DataSource()
//            let bucketItem = RestaurantItem(name: "Restaurant", note: "", category: "Old category")
//            let editRestaurant = EditRestaurant(bucketItem: bucketItem, dataStore: dataStore)
//
//            // When
//            editRestaurant.selectedCategory = "New category"
//            editRestaurant.updateCategory(bucketItem: bucketItem, category: "New category")
//
//            // Then
//            XCTAssertEqual(bucketItem.category, "New category")
//        }
//    }
//
