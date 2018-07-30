//
//  Codeable_and_UserDefaultsTests.swift
//  Codeable and UserDefaultsTests
//
//  Created by Louis Tur on 6/29/17.
//  Copyright © 2017 AccessCode. All rights reserved.
//

import XCTest
@testable import Codeable_and_UserDefaults

class Codeable_and_UserDefaultsTests: XCTestCase {
	
//	var cartItems: [CartItem] = [
//		CartItem(name: "iPhone", sku: 999, price: 700.00),
//		CartItem(name: "iMac", sku: 998, price: 2500.00),
//		CartItem(name: "iPad", sku: 997, price: 800.00)
//	]
//	var cart: Cart!
//	var cartStorage: CartStorageManager!
	
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
//		let defaults = UserDefaults.standard
//		defaults.set(nil, forKey: "userCartKey")
//
//		self.cart = Cart(items: cartItems)
//		self.cartStorage = CartStorageManager(cart: self.cart)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
	func test_CartItem_Initializer() {
//		let item = CartItem(name: "iPhone", sku: 999, price: 700.0)
//		XCTAssertNotNil(item, "Cart Item should have a default initializer")
//		XCTAssertTrue(item.name == "iPhone")
//		XCTAssertTrue(item.sku == 999)
//		XCTAssertTrue(item.price == 700.00)
	}
	
	func test_Cart_Initializer() {
//		let newCart = Cart(items: self.cartItems)
//		XCTAssertTrue(newCart.items.count == 3, "Initializing a cart should have the proper number of times")
	}
	
	func test_Cart_Adding_Item_Should_Increase_Cart_Size() {
//		XCTAssertTrue(self.cart.items.count == 3)
//
//		let newItem = CartItem(name: "Test", sku: 000, price: 10.00)
//		self.cart.addItem(newItem)
//
//		XCTAssertTrue(self.cart.items.count == 4, "Adding an item to the cart should increment its item count")
	}
	
	func test_Cart_Removing_Item_Should_Decrease_Cart_Size() {
//		let originalCount = self.cart.items.count
//		let newItem = self.cartItems.first!
//
//		XCTAssertTrue(self.cart.removeItem(newItem), "When an item is removed from the cart, it should return 'true'")
//		XCTAssertTrue(self.cart.items.count == (originalCount - 1), "Adding an item to the cart should increment its item count")
	}
	
	func test_Cart_Adding_Item_Should_Have_New_Item_Stored() {
//		let newItem = CartItem(name: "Test", sku: 000, price: 10.00)
//		self.cart.addItem(newItem)
//
//		XCTAssertTrue( self.cart.items.filter{ $0.sku == 0 ? true : false}.count == 1,
//		               "Adding an item to a cart should add it to its items property")
	}
	
	func test_Removing_Item_Should_Remove_Item_Stored() {
//		let index = self.cart.items.index { return $0.sku == 999 ? true : false }
//		XCTAssertNotNil(index)
//
//		let firstItem = self.cartItems.first!
//		XCTAssertTrue(self.cart.removeItem(firstItem), "When an item is removed from the cart, it should return 'true'")
//
//
//		let updatedIndex = self.cart.items.index { return $0.sku == 999 ? true : false }
//		XCTAssertNil(updatedIndex)
	}
	
	func test_Saving_Cart() {
//		self.cartStorage.saveCart()
//
//		let defaults = UserDefaults.standard
//		let foundData = defaults.data(forKey: "userCartKey")
//
//		XCTAssertNotNil(foundData, "After saving a cart, we should be able to retrieve it by key")
	}
	
	func test_Loading_Cart() {
//		self.cartStorage.saveCart()
//		let loadedCart = CartStorageManager.loadCart()
//
//		XCTAssertTrue(self.cartStorage.cart.items.count == loadedCart.items.count)
//		XCTAssertTrue(self.cartStorage.cart.items[0].sku == loadedCart.items[0].sku)
//		XCTAssertTrue(self.cartStorage.cart.items[1].sku == loadedCart.items[1].sku)
//		XCTAssertTrue(self.cartStorage.cart.items[2].sku == loadedCart.items[2].sku)
	}
	
	func test_Saving_Cart_Yields_Loaded_Cart_With_Correct_Items() {
//		let newItem = CartItem(name: "Test", sku: 000, price: 10.00)
//		self.cart.addItem(newItem)
//
//		self.cartStorage.saveCart()
//
//		let loadedCart = CartStorageManager.loadCart()
//		XCTAssertTrue(loadedCart.items.count == 4, "Cart should have correct number of items after loading")
	}
	
	func test_Loading_Nil_Cart_Creates_Empty_New_Cart() {
//		let emptyLoadedCart = CartStorageManager.loadCart()
//		XCTAssertTrue(emptyLoadedCart.items.count == 0, "Calling loadCart before a cart is saved shouyld return an empty cart")
//
	}
	
}
