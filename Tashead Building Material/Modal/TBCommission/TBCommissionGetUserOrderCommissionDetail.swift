//
//	TBCommissionGetUserOrderCommissionDetail.swift
//
//	Create by Ankit Gabani on 6/5/2024
//	Copyright © 2024. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBCommissionGetUserOrderCommissionDetail : NSObject, NSCoding{

	var actualPrice : Float!
	var commissionAmount : Float!
	var commissionPercentage : Int!
	var createdAt : String!
	var id : Int!
	var orderId : Int!
	var orderItemId : Int!
	var type : String!
	var updatedAt : String!
	var userId : Int!
	var userOrderCommissionsId : Int!


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
		actualPrice = dictionary["actual_price"] as? Float == nil ? 0 : dictionary["actual_price"] as? Float
		commissionAmount = dictionary["commission_amount"] as? Float == nil ? 0 : dictionary["commission_amount"] as? Float
		commissionPercentage = dictionary["commission_percentage"] as? Int == nil ? 0 : dictionary["commission_percentage"] as? Int
		createdAt = dictionary["created_at"] as? String == nil ? "" : dictionary["created_at"] as? String
		id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
		orderId = dictionary["order_id"] as? Int == nil ? 0 : dictionary["order_id"] as? Int
		orderItemId = dictionary["order_item_id"] as? Int == nil ? 0 : dictionary["order_item_id"] as? Int
		type = dictionary["type"] as? String == nil ? "" : dictionary["type"] as? String
		updatedAt = dictionary["updated_at"] as? String == nil ? "" : dictionary["updated_at"] as? String
		userId = dictionary["user_id"] as? Int == nil ? 0 : dictionary["user_id"] as? Int
		userOrderCommissionsId = dictionary["user_order_commissions_id"] as? Int == nil ? 0 : dictionary["user_order_commissions_id"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if actualPrice != nil{
			dictionary["actual_price"] = actualPrice
		}
		if commissionAmount != nil{
			dictionary["commission_amount"] = commissionAmount
		}
		if commissionPercentage != nil{
			dictionary["commission_percentage"] = commissionPercentage
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if id != nil{
			dictionary["id"] = id
		}
		if orderId != nil{
			dictionary["order_id"] = orderId
		}
		if orderItemId != nil{
			dictionary["order_item_id"] = orderItemId
		}
		if type != nil{
			dictionary["type"] = type
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt
		}
		if userId != nil{
			dictionary["user_id"] = userId
		}
		if userOrderCommissionsId != nil{
			dictionary["user_order_commissions_id"] = userOrderCommissionsId
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         actualPrice = aDecoder.decodeObject(forKey: "actual_price") as? Float
         commissionAmount = aDecoder.decodeObject(forKey: "commission_amount") as? Float
         commissionPercentage = aDecoder.decodeObject(forKey: "commission_percentage") as? Int
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         orderId = aDecoder.decodeObject(forKey: "order_id") as? Int
         orderItemId = aDecoder.decodeObject(forKey: "order_item_id") as? Int
         type = aDecoder.decodeObject(forKey: "type") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         userId = aDecoder.decodeObject(forKey: "user_id") as? Int
         userOrderCommissionsId = aDecoder.decodeObject(forKey: "user_order_commissions_id") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if actualPrice != nil{
			aCoder.encode(actualPrice, forKey: "actual_price")
		}
		if commissionAmount != nil{
			aCoder.encode(commissionAmount, forKey: "commission_amount")
		}
		if commissionPercentage != nil{
			aCoder.encode(commissionPercentage, forKey: "commission_percentage")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if orderId != nil{
			aCoder.encode(orderId, forKey: "order_id")
		}
		if orderItemId != nil{
			aCoder.encode(orderItemId, forKey: "order_item_id")
		}
		if type != nil{
			aCoder.encode(type, forKey: "type")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "user_id")
		}
		if userOrderCommissionsId != nil{
			aCoder.encode(userOrderCommissionsId, forKey: "user_order_commissions_id")
		}

	}

}