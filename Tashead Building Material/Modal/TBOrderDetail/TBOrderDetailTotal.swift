//
//	TBOrderDetailTotal.swift
//
//	Create by iMac on 1/1/2024
//	Copyright © 2024. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBOrderDetailTotal : NSObject, NSCoding{

	var cartDeliveryCharge : String!
	var cartSubTotal : String!
	var cartTotal : String!


	/**
	 * Overiding init method
	 */
	init(fromDictionary dictionary: NSDictionary)
	{
		super.init()
		parseJSONData(fromDictionary: dictionary)
	}

	/**
	 * Overiding init method
	 */
	override init(){
	}

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	@objc func parseJSONData(fromDictionary dictionary: NSDictionary)
	{
		cartDeliveryCharge = dictionary["cart_delivery_charge"] as? String == nil ? "" : dictionary["cart_delivery_charge"] as? String
		cartSubTotal = dictionary["cart_sub_total"] as? String == nil ? "" : dictionary["cart_sub_total"] as? String
		cartTotal = dictionary["cart_total"] as? String == nil ? "" : dictionary["cart_total"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if cartDeliveryCharge != nil{
			dictionary["cart_delivery_charge"] = cartDeliveryCharge
		}
		if cartSubTotal != nil{
			dictionary["cart_sub_total"] = cartSubTotal
		}
		if cartTotal != nil{
			dictionary["cart_total"] = cartTotal
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         cartDeliveryCharge = aDecoder.decodeObject(forKey: "cart_delivery_charge") as? String
         cartSubTotal = aDecoder.decodeObject(forKey: "cart_sub_total") as? String
         cartTotal = aDecoder.decodeObject(forKey: "cart_total") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if cartDeliveryCharge != nil{
			aCoder.encode(cartDeliveryCharge, forKey: "cart_delivery_charge")
		}
		if cartSubTotal != nil{
			aCoder.encode(cartSubTotal, forKey: "cart_sub_total")
		}
		if cartTotal != nil{
			aCoder.encode(cartTotal, forKey: "cart_total")
		}

	}

}