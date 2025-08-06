//
//	TBLoyaltyCouponsHistoryHistory.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBLoyaltyCouponsHistoryHistory : NSObject, NSCoding{

	var amount : String!
	var couponTitle : String!
	var createdAt : String!
	var orderId : Int!
	var points : String!
	var type : String!


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
		amount = dictionary["amount"] as? String == nil ? "" : dictionary["amount"] as? String
		couponTitle = dictionary["coupon_title"] as? String == nil ? "" : dictionary["coupon_title"] as? String
		createdAt = dictionary["created_at"] as? String == nil ? "" : dictionary["created_at"] as? String
		orderId = dictionary["order_id"] as? Int == nil ? 0 : dictionary["order_id"] as? Int
		points = dictionary["points"] as? String == nil ? "" : dictionary["points"] as? String
		type = dictionary["type"] as? String == nil ? "" : dictionary["type"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if amount != nil{
			dictionary["amount"] = amount
		}
		if couponTitle != nil{
			dictionary["coupon_title"] = couponTitle
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if orderId != nil{
			dictionary["order_id"] = orderId
		}
		if points != nil{
			dictionary["points"] = points
		}
		if type != nil{
			dictionary["type"] = type
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         amount = aDecoder.decodeObject(forKey: "amount") as? String
         couponTitle = aDecoder.decodeObject(forKey: "coupon_title") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         orderId = aDecoder.decodeObject(forKey: "order_id") as? Int
         points = aDecoder.decodeObject(forKey: "points") as? String
         type = aDecoder.decodeObject(forKey: "type") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if amount != nil{
			aCoder.encode(amount, forKey: "amount")
		}
		if couponTitle != nil{
			aCoder.encode(couponTitle, forKey: "coupon_title")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if orderId != nil{
			aCoder.encode(orderId, forKey: "order_id")
		}
		if points != nil{
			aCoder.encode(points, forKey: "points")
		}
		if type != nil{
			aCoder.encode(type, forKey: "type")
		}

	}

}