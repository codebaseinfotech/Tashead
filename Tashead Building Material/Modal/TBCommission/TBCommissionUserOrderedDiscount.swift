//
//	TBCommissionUserOrderedDiscount.swift
//
//	Create by Ankit Gabani on 6/5/2024
//	Copyright © 2024. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBCommissionUserOrderedDiscount : NSObject, NSCoding{

	var commissionAmount : Float!
	var commissionPercentage : Int!
	var createdAt : String!
	var getUserOrder : TBCommissionGetUserOrder!
	var getUserOrderCommissionDetail : [TBCommissionGetUserOrderCommissionDetail]!
	var id : Int!
	var orderId : Int!
	var status : Int!
	var updatedAt : String!
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
		commissionAmount = dictionary["commission_amount"] as? Float == nil ? 0 : dictionary["commission_amount"] as? Float
		commissionPercentage = dictionary["commission_percentage"] as? Int == nil ? 0 : dictionary["commission_percentage"] as? Int
		createdAt = dictionary["created_at"] as? String == nil ? "" : dictionary["created_at"] as? String
		if let getUserOrderData = dictionary["get_user_order"] as? NSDictionary{
			getUserOrder = TBCommissionGetUserOrder(fromDictionary: getUserOrderData)
		}
		else
		{
			getUserOrder = TBCommissionGetUserOrder(fromDictionary: NSDictionary.init())
		}
		getUserOrderCommissionDetail = [TBCommissionGetUserOrderCommissionDetail]()
		if let getUserOrderCommissionDetailArray = dictionary["get_user_order_commission_detail"] as? [NSDictionary]{
			for dic in getUserOrderCommissionDetailArray{
				let value = TBCommissionGetUserOrderCommissionDetail(fromDictionary: dic)
				getUserOrderCommissionDetail.append(value)
			}
		}
		id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
		orderId = dictionary["order_id"] as? Int == nil ? 0 : dictionary["order_id"] as? Int
		status = dictionary["status"] as? Int == nil ? 0 : dictionary["status"] as? Int
		updatedAt = dictionary["updated_at"] as? String == nil ? "" : dictionary["updated_at"] as? String
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
		if commissionPercentage != nil{
			dictionary["commission_percentage"] = commissionPercentage
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if getUserOrder != nil{
			dictionary["get_user_order"] = getUserOrder.toDictionary()
		}
		if getUserOrderCommissionDetail != nil{
			var dictionaryElements = [NSDictionary]()
			for getUserOrderCommissionDetailElement in getUserOrderCommissionDetail {
				dictionaryElements.append(getUserOrderCommissionDetailElement.toDictionary())
			}
			dictionary["get_user_order_commission_detail"] = dictionaryElements
		}
		if id != nil{
			dictionary["id"] = id
		}
		if orderId != nil{
			dictionary["order_id"] = orderId
		}
		if status != nil{
			dictionary["status"] = status
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt
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
         commissionAmount = aDecoder.decodeObject(forKey: "commission_amount") as? Float
         commissionPercentage = aDecoder.decodeObject(forKey: "commission_percentage") as? Int
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         getUserOrder = aDecoder.decodeObject(forKey: "get_user_order") as? TBCommissionGetUserOrder
         getUserOrderCommissionDetail = aDecoder.decodeObject(forKey: "get_user_order_commission_detail") as? [TBCommissionGetUserOrderCommissionDetail]
         id = aDecoder.decodeObject(forKey: "id") as? Int
         orderId = aDecoder.decodeObject(forKey: "order_id") as? Int
         status = aDecoder.decodeObject(forKey: "status") as? Int
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
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
		if commissionPercentage != nil{
			aCoder.encode(commissionPercentage, forKey: "commission_percentage")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if getUserOrder != nil{
			aCoder.encode(getUserOrder, forKey: "get_user_order")
		}
		if getUserOrderCommissionDetail != nil{
			aCoder.encode(getUserOrderCommissionDetail, forKey: "get_user_order_commission_detail")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if orderId != nil{
			aCoder.encode(orderId, forKey: "order_id")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "user_id")
		}

	}

}