//
//	TBCommissionCommissionDetail.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBCommissionCommissionDetail : NSObject, NSCoding{

	var commissionAmount : String!
	var commissionPercentage : Int!
	var id : Int!
	var orderId : Int!
	var orderItemId : Int!
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
		commissionAmount = dictionary["commission_amount"] as? String == nil ? "" : dictionary["commission_amount"] as? String
		commissionPercentage = dictionary["commission_percentage"] as? Int == nil ? 0 : dictionary["commission_percentage"] as? Int
		id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
		orderId = dictionary["order_id"] as? Int == nil ? 0 : dictionary["order_id"] as? Int
		orderItemId = dictionary["order_item_id"] as? Int == nil ? 0 : dictionary["order_item_id"] as? Int
		userOrderCommissionsId = dictionary["user_order_commissions_id"] as? Int == nil ? 0 : dictionary["user_order_commissions_id"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if commissionAmount != nil{
			dictionary["commission_amount"] = commissionAmount
		}
		if commissionPercentage != nil{
			dictionary["commission_percentage"] = commissionPercentage
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
         commissionAmount = aDecoder.decodeObject(forKey: "commission_amount") as? String
         commissionPercentage = aDecoder.decodeObject(forKey: "commission_percentage") as? Int
         id = aDecoder.decodeObject(forKey: "id") as? Int
         orderId = aDecoder.decodeObject(forKey: "order_id") as? Int
         orderItemId = aDecoder.decodeObject(forKey: "order_item_id") as? Int
         userOrderCommissionsId = aDecoder.decodeObject(forKey: "user_order_commissions_id") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if commissionAmount != nil{
			aCoder.encode(commissionAmount, forKey: "commission_amount")
		}
		if commissionPercentage != nil{
			aCoder.encode(commissionPercentage, forKey: "commission_percentage")
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
		if userOrderCommissionsId != nil{
			aCoder.encode(userOrderCommissionsId, forKey: "user_order_commissions_id")
		}

	}

}