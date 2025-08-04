//
//	TBCommissionUserOrderedDiscount.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBCommissionUserOrderedDiscount : NSObject, NSCoding{

	var commissionAmount : String!
	var commissionDetails : [TBCommissionCommissionDetail]!
	var createdAt : String!
	var id : Int!
	var order : TBCommissionOrder!
	var orderId : Int!
	var status : Int!
	var userId : Int!


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
		commissionDetails = [TBCommissionCommissionDetail]()
		if let commissionDetailsArray = dictionary["commission_details"] as? [NSDictionary]{
			for dic in commissionDetailsArray{
				let value = TBCommissionCommissionDetail(fromDictionary: dic)
				commissionDetails.append(value)
			}
		}
		createdAt = dictionary["created_at"] as? String == nil ? "" : dictionary["created_at"] as? String
		id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
		if let orderData = dictionary["order"] as? NSDictionary{
			order = TBCommissionOrder(fromDictionary: orderData)
		}
		else
		{
			order = TBCommissionOrder(fromDictionary: NSDictionary.init())
		}
		orderId = dictionary["order_id"] as? Int == nil ? 0 : dictionary["order_id"] as? Int
		status = dictionary["status"] as? Int == nil ? 0 : dictionary["status"] as? Int
		userId = dictionary["user_id"] as? Int == nil ? 0 : dictionary["user_id"] as? Int
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
		if commissionDetails != nil{
			var dictionaryElements = [NSDictionary]()
			for commissionDetailsElement in commissionDetails {
				dictionaryElements.append(commissionDetailsElement.toDictionary())
			}
			dictionary["commission_details"] = dictionaryElements
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if id != nil{
			dictionary["id"] = id
		}
		if order != nil{
			dictionary["order"] = order.toDictionary()
		}
		if orderId != nil{
			dictionary["order_id"] = orderId
		}
		if status != nil{
			dictionary["status"] = status
		}
		if userId != nil{
			dictionary["user_id"] = userId
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
         commissionDetails = aDecoder.decodeObject(forKey: "commission_details") as? [TBCommissionCommissionDetail]
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         order = aDecoder.decodeObject(forKey: "order") as? TBCommissionOrder
         orderId = aDecoder.decodeObject(forKey: "order_id") as? Int
         status = aDecoder.decodeObject(forKey: "status") as? Int
         userId = aDecoder.decodeObject(forKey: "user_id") as? Int

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
		if commissionDetails != nil{
			aCoder.encode(commissionDetails, forKey: "commission_details")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if order != nil{
			aCoder.encode(order, forKey: "order")
		}
		if orderId != nil{
			aCoder.encode(orderId, forKey: "order_id")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "user_id")
		}

	}

}