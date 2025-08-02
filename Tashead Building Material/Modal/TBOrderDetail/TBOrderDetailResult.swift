//
//	TBOrderDetailResult.swift
//
//	Create by iMac on 1/1/2024
//	Copyright © 2024. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBOrderDetailResult : NSObject, NSCoding{

	var address : String!
	var addressId : String!
	var deliveryCharge : String!
	var isPaid : Int!
	var orderId : Int!
	var orderItems : [TBOrderDetailOrderItem]!
	var paymentStatus : String!
	var paymentType : String!
	var total : TBOrderDetailTotal!
	var userFirstName : String!
	var userId : Int!
    var order_date : String!


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
		address = dictionary["address"] as? String == nil ? "" : dictionary["address"] as? String
		addressId = dictionary["address_id"] as? String == nil ? "" : dictionary["address_id"] as? String
		deliveryCharge = dictionary["delivery_charge"] as? String == nil ? "" : dictionary["delivery_charge"] as? String
		isPaid = dictionary["is_paid"] as? Int == nil ? 0 : dictionary["is_paid"] as? Int
		orderId = dictionary["order_id"] as? Int == nil ? 0 : dictionary["order_id"] as? Int
		orderItems = [TBOrderDetailOrderItem]()
		if let orderItemsArray = dictionary["order_items"] as? [NSDictionary]{
			for dic in orderItemsArray{
				let value = TBOrderDetailOrderItem(fromDictionary: dic)
				orderItems.append(value)
			}
		}
		paymentStatus = dictionary["payment_status"] as? String == nil ? "" : dictionary["payment_status"] as? String
		paymentType = dictionary["payment_type"] as? String == nil ? "" : dictionary["payment_type"] as? String
		if let totalData = dictionary["total"] as? NSDictionary{
			total = TBOrderDetailTotal(fromDictionary: totalData)
		}
		else
		{
			total = TBOrderDetailTotal(fromDictionary: NSDictionary.init())
		}
		userFirstName = dictionary["user_first_name"] as? String == nil ? "" : dictionary["user_first_name"] as? String
		userId = dictionary["user_id"] as? Int == nil ? 0 : dictionary["user_id"] as? Int
        order_date = dictionary["order_date"] as? String == nil ? "" : dictionary["order_date"] as? String

	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if address != nil{
			dictionary["address"] = address
		}
		if addressId != nil{
			dictionary["address_id"] = addressId
		}
		if deliveryCharge != nil{
			dictionary["delivery_charge"] = deliveryCharge
		}
		if isPaid != nil{
			dictionary["is_paid"] = isPaid
		}
		if orderId != nil{
			dictionary["order_id"] = orderId
		}
		if orderItems != nil{
			var dictionaryElements = [NSDictionary]()
			for orderItemsElement in orderItems {
				dictionaryElements.append(orderItemsElement.toDictionary())
			}
			dictionary["order_items"] = dictionaryElements
		}
		if paymentStatus != nil{
			dictionary["payment_status"] = paymentStatus
		}
		if paymentType != nil{
			dictionary["payment_type"] = paymentType
		}
		if total != nil{
			dictionary["total"] = total.toDictionary()
		}
		if userFirstName != nil{
			dictionary["user_first_name"] = userFirstName
		}
        if order_date != nil{
            dictionary["order_date"] = order_date
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
         address = aDecoder.decodeObject(forKey: "address") as? String
         addressId = aDecoder.decodeObject(forKey: "address_id") as? String
         deliveryCharge = aDecoder.decodeObject(forKey: "delivery_charge") as? String
         isPaid = aDecoder.decodeObject(forKey: "is_paid") as? Int
         orderId = aDecoder.decodeObject(forKey: "order_id") as? Int
         orderItems = aDecoder.decodeObject(forKey: "order_items") as? [TBOrderDetailOrderItem]
         paymentStatus = aDecoder.decodeObject(forKey: "payment_status") as? String
         paymentType = aDecoder.decodeObject(forKey: "payment_type") as? String
         total = aDecoder.decodeObject(forKey: "total") as? TBOrderDetailTotal
         userFirstName = aDecoder.decodeObject(forKey: "user_first_name") as? String
         userId = aDecoder.decodeObject(forKey: "user_id") as? Int
        order_date = aDecoder.decodeObject(forKey: "order_date") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if address != nil{
			aCoder.encode(address, forKey: "address")
		}
		if addressId != nil{
			aCoder.encode(addressId, forKey: "address_id")
		}
		if deliveryCharge != nil{
			aCoder.encode(deliveryCharge, forKey: "delivery_charge")
		}
		if isPaid != nil{
			aCoder.encode(isPaid, forKey: "is_paid")
		}
		if orderId != nil{
			aCoder.encode(orderId, forKey: "order_id")
		}
		if orderItems != nil{
			aCoder.encode(orderItems, forKey: "order_items")
		}
		if paymentStatus != nil{
			aCoder.encode(paymentStatus, forKey: "payment_status")
		}
		if paymentType != nil{
			aCoder.encode(paymentType, forKey: "payment_type")
		}
		if total != nil{
			aCoder.encode(total, forKey: "total")
		}
		if userFirstName != nil{
			aCoder.encode(userFirstName, forKey: "user_first_name")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "user_id")
		}
        if order_date != nil{
            aCoder.encode(order_date, forKey: "order_date")
        }

	}

}
