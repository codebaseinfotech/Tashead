//
//	TBCommissionGetUserOrder.swift
//
//	Create by Ankit Gabani on 6/5/2024
//	Copyright © 2024. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBCommissionGetUserOrder : NSObject, NSCoding{

	var createdAt : String!
	var id : Int!
	var isPaid : Int!
	var status : Int!
	var subTotal : String!
	var total : String!


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
		createdAt = dictionary["created_at"] as? String == nil ? "" : dictionary["created_at"] as? String
		id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
		isPaid = dictionary["is_paid"] as? Int == nil ? 0 : dictionary["is_paid"] as? Int
		status = dictionary["status"] as? Int == nil ? 0 : dictionary["status"] as? Int
		subTotal = dictionary["sub_total"] as? String == nil ? "" : dictionary["sub_total"] as? String
		total = dictionary["total"] as? String == nil ? "" : dictionary["total"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if id != nil{
			dictionary["id"] = id
		}
		if isPaid != nil{
			dictionary["is_paid"] = isPaid
		}
		if status != nil{
			dictionary["status"] = status
		}
		if subTotal != nil{
			dictionary["sub_total"] = subTotal
		}
		if total != nil{
			dictionary["total"] = total
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         isPaid = aDecoder.decodeObject(forKey: "is_paid") as? Int
         status = aDecoder.decodeObject(forKey: "status") as? Int
         subTotal = aDecoder.decodeObject(forKey: "sub_total") as? String
         total = aDecoder.decodeObject(forKey: "total") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if isPaid != nil{
			aCoder.encode(isPaid, forKey: "is_paid")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if subTotal != nil{
			aCoder.encode(subTotal, forKey: "sub_total")
		}
		if total != nil{
			aCoder.encode(total, forKey: "total")
		}

	}

}