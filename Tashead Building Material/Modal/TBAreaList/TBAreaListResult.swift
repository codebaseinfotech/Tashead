//
//	TBAreaListResult.swift
//
//	Create by iMac on 27/11/2023
//	Copyright © 2023. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBAreaListResult : NSObject, NSCoding{

	var areaNameEn : String!
	var codSwitch : Int!
	var createdAt : String!
	var creditCardSwitch : Int!
	var deliveryCharge : Int!
	var deliverySwitch : Int!
	var expressDeliveryCharge : String!
	var expressDeliveryOrderCapacity : String!
	var expressDeliverySwitch : Int!
	var expressDeliveryTime : String!
	var governorateId : Int!
	var id : Int!
	var knetSwitch : Int!
	var minimumOrder : Int!
	var status : Int!
	var updatedAt : String!


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
		areaNameEn = dictionary["area_name_en"] as? String == nil ? "" : dictionary["area_name_en"] as? String
		codSwitch = dictionary["cod_switch"] as? Int == nil ? 0 : dictionary["cod_switch"] as? Int
		createdAt = dictionary["created_at"] as? String == nil ? "" : dictionary["created_at"] as? String
		creditCardSwitch = dictionary["credit_card_switch"] as? Int == nil ? 0 : dictionary["credit_card_switch"] as? Int
		deliveryCharge = dictionary["delivery_charge"] as? Int == nil ? 0 : dictionary["delivery_charge"] as? Int
		deliverySwitch = dictionary["delivery_switch"] as? Int == nil ? 0 : dictionary["delivery_switch"] as? Int
		expressDeliveryCharge = dictionary["express_delivery_charge"] as? String == nil ? "" : dictionary["express_delivery_charge"] as? String
		expressDeliveryOrderCapacity = dictionary["express_delivery_order_capacity"] as? String == nil ? "" : dictionary["express_delivery_order_capacity"] as? String
		expressDeliverySwitch = dictionary["express_delivery_switch"] as? Int == nil ? 0 : dictionary["express_delivery_switch"] as? Int
		expressDeliveryTime = dictionary["express_delivery_time"] as? String == nil ? "" : dictionary["express_delivery_time"] as? String
		governorateId = dictionary["governorate_id"] as? Int == nil ? 0 : dictionary["governorate_id"] as? Int
		id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
		knetSwitch = dictionary["knet_switch"] as? Int == nil ? 0 : dictionary["knet_switch"] as? Int
		minimumOrder = dictionary["minimum_order"] as? Int == nil ? 0 : dictionary["minimum_order"] as? Int
		status = dictionary["status"] as? Int == nil ? 0 : dictionary["status"] as? Int
		updatedAt = dictionary["updated_at"] as? String == nil ? "" : dictionary["updated_at"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if areaNameEn != nil{
			dictionary["area_name_en"] = areaNameEn
		}
		if codSwitch != nil{
			dictionary["cod_switch"] = codSwitch
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt
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
		if id != nil{
			dictionary["id"] = id
		}
		if knetSwitch != nil{
			dictionary["knet_switch"] = knetSwitch
		}
		if minimumOrder != nil{
			dictionary["minimum_order"] = minimumOrder
		}
		if status != nil{
			dictionary["status"] = status
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         areaNameEn = aDecoder.decodeObject(forKey: "area_name_en") as? String
         codSwitch = aDecoder.decodeObject(forKey: "cod_switch") as? Int
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         creditCardSwitch = aDecoder.decodeObject(forKey: "credit_card_switch") as? Int
         deliveryCharge = aDecoder.decodeObject(forKey: "delivery_charge") as? Int
         deliverySwitch = aDecoder.decodeObject(forKey: "delivery_switch") as? Int
         expressDeliveryCharge = aDecoder.decodeObject(forKey: "express_delivery_charge") as? String
         expressDeliveryOrderCapacity = aDecoder.decodeObject(forKey: "express_delivery_order_capacity") as? String
         expressDeliverySwitch = aDecoder.decodeObject(forKey: "express_delivery_switch") as? Int
         expressDeliveryTime = aDecoder.decodeObject(forKey: "express_delivery_time") as? String
         governorateId = aDecoder.decodeObject(forKey: "governorate_id") as? Int
         id = aDecoder.decodeObject(forKey: "id") as? Int
         knetSwitch = aDecoder.decodeObject(forKey: "knet_switch") as? Int
         minimumOrder = aDecoder.decodeObject(forKey: "minimum_order") as? Int
         status = aDecoder.decodeObject(forKey: "status") as? Int
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if areaNameEn != nil{
			aCoder.encode(areaNameEn, forKey: "area_name_en")
		}
		if codSwitch != nil{
			aCoder.encode(codSwitch, forKey: "cod_switch")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
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
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if knetSwitch != nil{
			aCoder.encode(knetSwitch, forKey: "knet_switch")
		}
		if minimumOrder != nil{
			aCoder.encode(minimumOrder, forKey: "minimum_order")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}

	}

}