//
//	TBCreditHistoryResult.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBCreditHistoryResult : NSObject, NSCoding{

	var amount : String!
	var createdAt : String!
	var deletedAt : String!
	var descriptionField : String!
	var orderId : Int!
    var type : String!
    var payment_id : String!
	var invoice_url : String!
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
		amount = dictionary["amount"] as? String == nil ? "" : dictionary["amount"] as? String
		createdAt = dictionary["created_at"] as? String == nil ? "" : dictionary["created_at"] as? String
		deletedAt = dictionary["deleted_at"] as? String == nil ? "" : dictionary["deleted_at"] as? String
		descriptionField = dictionary["description"] as? String == nil ? "" : dictionary["description"] as? String
		orderId = dictionary["order_id"] as? Int == nil ? 0 : dictionary["order_id"] as? Int
        type = dictionary["type"] as? String == nil ? "" : dictionary["type"] as? String
        payment_id = dictionary["payment_id"] as? String == nil ? "" : dictionary["payment_id"] as? String
        invoice_url = dictionary["invoice_url"] as? String == nil ? "" : dictionary["invoice_url"] as? String
		userId = dictionary["user_id"] as? Int == nil ? 0 : dictionary["user_id"] as? Int
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
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if deletedAt != nil{
			dictionary["deleted_at"] = deletedAt
		}
		if descriptionField != nil{
			dictionary["description"] = descriptionField
		}
		if orderId != nil{
			dictionary["order_id"] = orderId
		}
		if type != nil{
			dictionary["type"] = type
		}
		if userId != nil{
			dictionary["user_id"] = userId
		}
        if payment_id != nil{
            dictionary["payment_id"] = payment_id
        }
        if invoice_url != nil{
            dictionary["invoice_url"] = invoice_url
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
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         deletedAt = aDecoder.decodeObject(forKey: "deleted_at") as? String
         descriptionField = aDecoder.decodeObject(forKey: "description") as? String
         orderId = aDecoder.decodeObject(forKey: "order_id") as? Int
         type = aDecoder.decodeObject(forKey: "type") as? String
        payment_id = aDecoder.decodeObject(forKey: "payment_id") as? String
        invoice_url = aDecoder.decodeObject(forKey: "invoice_url") as? String
         userId = aDecoder.decodeObject(forKey: "user_id") as? Int

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
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if deletedAt != nil{
			aCoder.encode(deletedAt, forKey: "deleted_at")
		}
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "description")
		}
		if orderId != nil{
			aCoder.encode(orderId, forKey: "order_id")
		}
		if type != nil{
			aCoder.encode(type, forKey: "type")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "user_id")
		}
        if invoice_url != nil{
            aCoder.encode(invoice_url, forKey: "invoice_url")
        }

	}

}
