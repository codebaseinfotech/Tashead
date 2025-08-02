//
//	TBCartListResult.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBCartListResult : NSObject, NSCoding{

	var address : TBCartListAddres!
	var cartId : Int!
	var cartItems : [TBCartListCartItem]!
	var currency : String!
	var deviceId : String!
	var expectedOrderDate : String!
	var factoryMessage : String!
	var nonFactoryMessage : String!
	var note : String!
	var promocode : String!
	var promocodeId : String!
	var termsConditionApproved : Int!
	var total : TBCartListTotal!
	var userId : Int!
	var uuid : String!
    var express_delivery : Int!
    var express_delivery_time : String!
    var is_express_delivery : Int!

    var express_delivery_charge : String!

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
        express_delivery = dictionary["express_delivery"] as? Int == nil ? 0 : dictionary["express_delivery"] as? Int
        express_delivery_time = dictionary["express_delivery_time"] as? String == nil ? "" : dictionary["express_delivery_time"] as? String
        is_express_delivery = dictionary["is_express_delivery"] as? Int == nil ? 0 : dictionary["is_express_delivery"] as? Int
        express_delivery_charge = dictionary["express_delivery_charge"] as? String == nil ? "" : dictionary["express_delivery_charge"] as? String
        
		if let addressData = dictionary["address"] as? NSDictionary{
			address = TBCartListAddres(fromDictionary: addressData)
		}
		else
		{
			address = TBCartListAddres(fromDictionary: NSDictionary.init())
		}
		cartId = dictionary["cart_id"] as? Int == nil ? 0 : dictionary["cart_id"] as? Int
		cartItems = [TBCartListCartItem]()
		if let cartItemsArray = dictionary["cart_items"] as? [NSDictionary]{
			for dic in cartItemsArray{
				let value = TBCartListCartItem(fromDictionary: dic)
				cartItems.append(value)
			}
		}
		currency = dictionary["currency"] as? String == nil ? "" : dictionary["currency"] as? String
		deviceId = dictionary["device_id"] as? String == nil ? "" : dictionary["device_id"] as? String
		expectedOrderDate = dictionary["expected_order_date"] as? String == nil ? "" : dictionary["expected_order_date"] as? String
		factoryMessage = dictionary["factory_message"] as? String == nil ? "" : dictionary["factory_message"] as? String
		nonFactoryMessage = dictionary["non_factory_message"] as? String == nil ? "" : dictionary["non_factory_message"] as? String
		note = dictionary["note"] as? String == nil ? "" : dictionary["note"] as? String
		promocode = dictionary["promocode"] as? String == nil ? "" : dictionary["promocode"] as? String
		promocodeId = dictionary["promocode_id"] as? String == nil ? "" : dictionary["promocode_id"] as? String
		termsConditionApproved = dictionary["terms_condition_approved"] as? Int == nil ? 0 : dictionary["terms_condition_approved"] as? Int
		if let totalData = dictionary["total"] as? NSDictionary{
			total = TBCartListTotal(fromDictionary: totalData)
		}
		else
		{
			total = TBCartListTotal(fromDictionary: NSDictionary.init())
		}
		userId = dictionary["user_id"] as? Int == nil ? 0 : dictionary["user_id"] as? Int
		uuid = dictionary["uuid"] as? String == nil ? "" : dictionary["uuid"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
        
        if express_delivery != nil{
            dictionary["express_delivery"] = express_delivery
        }
        if express_delivery_time != nil{
            dictionary["express_delivery_time"] = express_delivery_time
        }
        if is_express_delivery != nil{
            dictionary["is_express_delivery"] = is_express_delivery
        }
        if express_delivery_charge != nil{
            dictionary["express_delivery_charge"] = express_delivery_charge
        }
        
        
		if address != nil{
			dictionary["address"] = address.toDictionary()
		}
		if cartId != nil{
			dictionary["cart_id"] = cartId
		}
		if cartItems != nil{
			var dictionaryElements = [NSDictionary]()
			for cartItemsElement in cartItems {
				dictionaryElements.append(cartItemsElement.toDictionary())
			}
			dictionary["cart_items"] = dictionaryElements
		}
		if currency != nil{
			dictionary["currency"] = currency
		}
		if deviceId != nil{
			dictionary["device_id"] = deviceId
		}
		if expectedOrderDate != nil{
			dictionary["expected_order_date"] = expectedOrderDate
		}
		if factoryMessage != nil{
			dictionary["factory_message"] = factoryMessage
		}
		if nonFactoryMessage != nil{
			dictionary["non_factory_message"] = nonFactoryMessage
		}
		if note != nil{
			dictionary["note"] = note
		}
		if promocode != nil{
			dictionary["promocode"] = promocode
		}
		if promocodeId != nil{
			dictionary["promocode_id"] = promocodeId
		}
		if termsConditionApproved != nil{
			dictionary["terms_condition_approved"] = termsConditionApproved
		}
		if total != nil{
			dictionary["total"] = total.toDictionary()
		}
		if userId != nil{
			dictionary["user_id"] = userId
		}
		if uuid != nil{
			dictionary["uuid"] = uuid
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
        express_delivery = aDecoder.decodeObject(forKey: "express_delivery") as? Int
        express_delivery_time = aDecoder.decodeObject(forKey: "express_delivery_time") as? String
        is_express_delivery = aDecoder.decodeObject(forKey: "is_express_delivery") as? Int
        express_delivery_charge = aDecoder.decodeObject(forKey: "express_delivery_charge") as? String

        
        
         address = aDecoder.decodeObject(forKey: "address") as? TBCartListAddres
         cartId = aDecoder.decodeObject(forKey: "cart_id") as? Int
         cartItems = aDecoder.decodeObject(forKey: "cart_items") as? [TBCartListCartItem]
         currency = aDecoder.decodeObject(forKey: "currency") as? String
         deviceId = aDecoder.decodeObject(forKey: "device_id") as? String
         expectedOrderDate = aDecoder.decodeObject(forKey: "expected_order_date") as? String
         factoryMessage = aDecoder.decodeObject(forKey: "factory_message") as? String
         nonFactoryMessage = aDecoder.decodeObject(forKey: "non_factory_message") as? String
         note = aDecoder.decodeObject(forKey: "note") as? String
         promocode = aDecoder.decodeObject(forKey: "promocode") as? String
         promocodeId = aDecoder.decodeObject(forKey: "promocode_id") as? String
         termsConditionApproved = aDecoder.decodeObject(forKey: "terms_condition_approved") as? Int
         total = aDecoder.decodeObject(forKey: "total") as? TBCartListTotal
         userId = aDecoder.decodeObject(forKey: "user_id") as? Int
         uuid = aDecoder.decodeObject(forKey: "uuid") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
        if express_delivery != nil{
            aCoder.encode(express_delivery, forKey: "express_delivery")
        }
        if express_delivery_time != nil{
            aCoder.encode(express_delivery_time, forKey: "express_delivery_time")
        }
        if is_express_delivery != nil{
            aCoder.encode(is_express_delivery, forKey: "is_express_delivery")
        }
        if express_delivery_charge != nil{
            aCoder.encode(express_delivery_charge, forKey: "express_delivery_charge")
        }
        
        
		if address != nil{
			aCoder.encode(address, forKey: "address")
		}
		if cartId != nil{
			aCoder.encode(cartId, forKey: "cart_id")
		}
		if cartItems != nil{
			aCoder.encode(cartItems, forKey: "cart_items")
		}
		if currency != nil{
			aCoder.encode(currency, forKey: "currency")
		}
		if deviceId != nil{
			aCoder.encode(deviceId, forKey: "device_id")
		}
		if expectedOrderDate != nil{
			aCoder.encode(expectedOrderDate, forKey: "expected_order_date")
		}
		if factoryMessage != nil{
			aCoder.encode(factoryMessage, forKey: "factory_message")
		}
		if nonFactoryMessage != nil{
			aCoder.encode(nonFactoryMessage, forKey: "non_factory_message")
		}
		if note != nil{
			aCoder.encode(note, forKey: "note")
		}
		if promocode != nil{
			aCoder.encode(promocode, forKey: "promocode")
		}
		if promocodeId != nil{
			aCoder.encode(promocodeId, forKey: "promocode_id")
		}
		if termsConditionApproved != nil{
			aCoder.encode(termsConditionApproved, forKey: "terms_condition_approved")
		}
		if total != nil{
			aCoder.encode(total, forKey: "total")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "user_id")
		}
		if uuid != nil{
			aCoder.encode(uuid, forKey: "uuid")
		}

	}

}
