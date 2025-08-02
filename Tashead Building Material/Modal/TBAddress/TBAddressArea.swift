//
//	TBAddressArea.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBAddressArea : NSObject, NSCoding{

	var applePay : Int!
	var codSwitch : Int!
	var creditCardSwitch : Int!
	var deliveryCharge : String!
	var deliverySwitch : Int!
	var expressDeliveryCharge : String!
	var expressDeliveryOrderCapacity : Int!
	var expressDeliverySwitch : Int!
	var expressDeliveryTime : String!
	var governorateId : Int!
	var governorateName : String!
	var id : Int!
	var knetSwitch : Int!
	var minimumOrder : String!
	var name : String!
	var sendPaymentLink : Int!


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
		applePay = dictionary["apple_pay"] as? Int == nil ? 0 : dictionary["apple_pay"] as? Int
		codSwitch = dictionary["cod_switch"] as? Int == nil ? 0 : dictionary["cod_switch"] as? Int
		creditCardSwitch = dictionary["credit_card_switch"] as? Int == nil ? 0 : dictionary["credit_card_switch"] as? Int
		deliveryCharge = dictionary["delivery_charge"] as? String == nil ? "" : dictionary["delivery_charge"] as? String
		deliverySwitch = dictionary["delivery_switch"] as? Int == nil ? 0 : dictionary["delivery_switch"] as? Int
		expressDeliveryCharge = dictionary["express_delivery_charge"] as? String == nil ? "" : dictionary["express_delivery_charge"] as? String
		expressDeliveryOrderCapacity = dictionary["express_delivery_order_capacity"] as? Int == nil ? 0 : dictionary["express_delivery_order_capacity"] as? Int
		expressDeliverySwitch = dictionary["express_delivery_switch"] as? Int == nil ? 0 : dictionary["express_delivery_switch"] as? Int
		expressDeliveryTime = dictionary["express_delivery_time"] as? String == nil ? "" : dictionary["express_delivery_time"] as? String
		governorateId = dictionary["governorate_id"] as? Int == nil ? 0 : dictionary["governorate_id"] as? Int
		governorateName = dictionary["governorate_name"] as? String == nil ? "" : dictionary["governorate_name"] as? String
		id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
		knetSwitch = dictionary["knet_switch"] as? Int == nil ? 0 : dictionary["knet_switch"] as? Int
		minimumOrder = dictionary["minimum_order"] as? String == nil ? "" : dictionary["minimum_order"] as? String
		name = dictionary["name"] as? String == nil ? "" : dictionary["name"] as? String
		sendPaymentLink = dictionary["send_payment_link"] as? Int == nil ? 0 : dictionary["send_payment_link"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if applePay != nil{
			dictionary["apple_pay"] = applePay
		}
		if codSwitch != nil{
			dictionary["cod_switch"] = codSwitch
		}
		if creditCardSwitch != nil{
			dictionary["credit_card_switch"] = creditCardSwitch
		}
		if deliveryCharge != nil{
			dictionary["delivery_charge"] = deliveryCharge
		}
		if deliverySwitch != nil{
			dictionary["delivery_switch"] = deliverySwitch
		}
		if expressDeliveryCharge != nil{
			dictionary["express_delivery_charge"] = expressDeliveryCharge
		}
		if expressDeliveryOrderCapacity != nil{
			dictionary["express_delivery_order_capacity"] = expressDeliveryOrderCapacity
		}
		if expressDeliverySwitch != nil{
			dictionary["express_delivery_switch"] = expressDeliverySwitch
		}
		if expressDeliveryTime != nil{
			dictionary["express_delivery_time"] = expressDeliveryTime
		}
		if governorateId != nil{
			dictionary["governorate_id"] = governorateId
		}
		if governorateName != nil{
			dictionary["governorate_name"] = governorateName
		}
		if id != nil{
			dictionary["id"] = id
		}
		if knetSwitch != nil{
			dictionary["knet_switch"] = knetSwitch
		}
		if minimumOrder != nil{
			dictionary["minimum_order"] = minimumOrder
		}
		if name != nil{
			dictionary["name"] = name
		}
		if sendPaymentLink != nil{
			dictionary["send_payment_link"] = sendPaymentLink
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         applePay = aDecoder.decodeObject(forKey: "apple_pay") as? Int
         codSwitch = aDecoder.decodeObject(forKey: "cod_switch") as? Int
         creditCardSwitch = aDecoder.decodeObject(forKey: "credit_card_switch") as? Int
         deliveryCharge = aDecoder.decodeObject(forKey: "delivery_charge") as? String
         deliverySwitch = aDecoder.decodeObject(forKey: "delivery_switch") as? Int
         expressDeliveryCharge = aDecoder.decodeObject(forKey: "express_delivery_charge") as? String
         expressDeliveryOrderCapacity = aDecoder.decodeObject(forKey: "express_delivery_order_capacity") as? Int
         expressDeliverySwitch = aDecoder.decodeObject(forKey: "express_delivery_switch") as? Int
         expressDeliveryTime = aDecoder.decodeObject(forKey: "express_delivery_time") as? String
         governorateId = aDecoder.decodeObject(forKey: "governorate_id") as? Int
         governorateName = aDecoder.decodeObject(forKey: "governorate_name") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         knetSwitch = aDecoder.decodeObject(forKey: "knet_switch") as? Int
         minimumOrder = aDecoder.decodeObject(forKey: "minimum_order") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         sendPaymentLink = aDecoder.decodeObject(forKey: "send_payment_link") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if applePay != nil{
			aCoder.encode(applePay, forKey: "apple_pay")
		}
		if codSwitch != nil{
			aCoder.encode(codSwitch, forKey: "cod_switch")
		}
		if creditCardSwitch != nil{
			aCoder.encode(creditCardSwitch, forKey: "credit_card_switch")
		}
		if deliveryCharge != nil{
			aCoder.encode(deliveryCharge, forKey: "delivery_charge")
		}
		if deliverySwitch != nil{
			aCoder.encode(deliverySwitch, forKey: "delivery_switch")
		}
		if expressDeliveryCharge != nil{
			aCoder.encode(expressDeliveryCharge, forKey: "express_delivery_charge")
		}
		if expressDeliveryOrderCapacity != nil{
			aCoder.encode(expressDeliveryOrderCapacity, forKey: "express_delivery_order_capacity")
		}
		if expressDeliverySwitch != nil{
			aCoder.encode(expressDeliverySwitch, forKey: "express_delivery_switch")
		}
		if expressDeliveryTime != nil{
			aCoder.encode(expressDeliveryTime, forKey: "express_delivery_time")
		}
		if governorateId != nil{
			aCoder.encode(governorateId, forKey: "governorate_id")
		}
		if governorateName != nil{
			aCoder.encode(governorateName, forKey: "governorate_name")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if knetSwitch != nil{
			aCoder.encode(knetSwitch, forKey: "knet_switch")
		}
		if minimumOrder != nil{
			aCoder.encode(minimumOrder, forKey: "minimum_order")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if sendPaymentLink != nil{
			aCoder.encode(sendPaymentLink, forKey: "send_payment_link")
		}

	}

}