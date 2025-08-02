//
//	TBAddressResult.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBAddressResult : NSObject, NSCoding{

	var address : String!
	var apartment : String!
	var area : TBAddressArea!
	var areaId : String!
	var areaName : String!
	var avenue : String!
	var block : String!
	var buildingNumber : String!
	var expressDelivery : Bool!
	var expressDeliveryCharge : Int!
	var expressDeliveryTime : Int!
	var expressDeliveryTimeUnit : String!
	var floor : String!
	var governorateId : Int!
	var governorateName : String!
	var id : Int!
	var isDefault : Int!
	var isDeliveryAvailable : Int!
	var latitude : String!
	var longitude : String!
	var street : String!
	var userId : String!


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
		apartment = dictionary["apartment"] as? String == nil ? "" : dictionary["apartment"] as? String
		if let areaData = dictionary["area"] as? NSDictionary{
			area = TBAddressArea(fromDictionary: areaData)
		}
		else
		{
			area = TBAddressArea(fromDictionary: NSDictionary.init())
		}
		areaId = dictionary["area_id"] as? String == nil ? "" : dictionary["area_id"] as? String
		areaName = dictionary["area_name"] as? String == nil ? "" : dictionary["area_name"] as? String
		avenue = dictionary["avenue"] as? String == nil ? "" : dictionary["avenue"] as? String
		block = dictionary["block"] as? String == nil ? "" : dictionary["block"] as? String
		buildingNumber = dictionary["building_number"] as? String == nil ? "" : dictionary["building_number"] as? String
		expressDelivery = dictionary["express_delivery"] as? Bool == nil ? false : dictionary["express_delivery"] as? Bool
		expressDeliveryCharge = dictionary["express_delivery_charge"] as? Int == nil ? 0 : dictionary["express_delivery_charge"] as? Int
		expressDeliveryTime = dictionary["express_delivery_time"] as? Int == nil ? 0 : dictionary["express_delivery_time"] as? Int
		expressDeliveryTimeUnit = dictionary["express_delivery_time_unit"] as? String == nil ? "" : dictionary["express_delivery_time_unit"] as? String
		floor = dictionary["floor"] as? String == nil ? "" : dictionary["floor"] as? String
		governorateId = dictionary["governorate_id"] as? Int == nil ? 0 : dictionary["governorate_id"] as? Int
		governorateName = dictionary["governorate_name"] as? String == nil ? "" : dictionary["governorate_name"] as? String
		id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
		isDefault = dictionary["is_default"] as? Int == nil ? 0 : dictionary["is_default"] as? Int
		isDeliveryAvailable = dictionary["is_delivery_available"] as? Int == nil ? 0 : dictionary["is_delivery_available"] as? Int
		latitude = dictionary["latitude"] as? String == nil ? "" : dictionary["latitude"] as? String
		longitude = dictionary["longitude"] as? String == nil ? "" : dictionary["longitude"] as? String
		street = dictionary["street"] as? String == nil ? "" : dictionary["street"] as? String
		userId = dictionary["user_id"] as? String == nil ? "" : dictionary["user_id"] as? String
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
		if apartment != nil{
			dictionary["apartment"] = apartment
		}
		if area != nil{
			dictionary["area"] = area.toDictionary()
		}
		if areaId != nil{
			dictionary["area_id"] = areaId
		}
		if areaName != nil{
			dictionary["area_name"] = areaName
		}
		if avenue != nil{
			dictionary["avenue"] = avenue
		}
		if block != nil{
			dictionary["block"] = block
		}
		if buildingNumber != nil{
			dictionary["building_number"] = buildingNumber
		}
		if expressDelivery != nil{
			dictionary["express_delivery"] = expressDelivery
		}
		if expressDeliveryCharge != nil{
			dictionary["express_delivery_charge"] = expressDeliveryCharge
		}
		if expressDeliveryTime != nil{
			dictionary["express_delivery_time"] = expressDeliveryTime
		}
		if expressDeliveryTimeUnit != nil{
			dictionary["express_delivery_time_unit"] = expressDeliveryTimeUnit
		}
		if floor != nil{
			dictionary["floor"] = floor
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
		if isDefault != nil{
			dictionary["is_default"] = isDefault
		}
		if isDeliveryAvailable != nil{
			dictionary["is_delivery_available"] = isDeliveryAvailable
		}
		if latitude != nil{
			dictionary["latitude"] = latitude
		}
		if longitude != nil{
			dictionary["longitude"] = longitude
		}
		if street != nil{
			dictionary["street"] = street
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
         apartment = aDecoder.decodeObject(forKey: "apartment") as? String
         area = aDecoder.decodeObject(forKey: "area") as? TBAddressArea
         areaId = aDecoder.decodeObject(forKey: "area_id") as? String
         areaName = aDecoder.decodeObject(forKey: "area_name") as? String
         avenue = aDecoder.decodeObject(forKey: "avenue") as? String
         block = aDecoder.decodeObject(forKey: "block") as? String
         buildingNumber = aDecoder.decodeObject(forKey: "building_number") as? String
         expressDelivery = aDecoder.decodeObject(forKey: "express_delivery") as? Bool
         expressDeliveryCharge = aDecoder.decodeObject(forKey: "express_delivery_charge") as? Int
         expressDeliveryTime = aDecoder.decodeObject(forKey: "express_delivery_time") as? Int
         expressDeliveryTimeUnit = aDecoder.decodeObject(forKey: "express_delivery_time_unit") as? String
         floor = aDecoder.decodeObject(forKey: "floor") as? String
         governorateId = aDecoder.decodeObject(forKey: "governorate_id") as? Int
         governorateName = aDecoder.decodeObject(forKey: "governorate_name") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         isDefault = aDecoder.decodeObject(forKey: "is_default") as? Int
         isDeliveryAvailable = aDecoder.decodeObject(forKey: "is_delivery_available") as? Int
         latitude = aDecoder.decodeObject(forKey: "latitude") as? String
         longitude = aDecoder.decodeObject(forKey: "longitude") as? String
         street = aDecoder.decodeObject(forKey: "street") as? String
         userId = aDecoder.decodeObject(forKey: "user_id") as? String

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
		if apartment != nil{
			aCoder.encode(apartment, forKey: "apartment")
		}
		if area != nil{
			aCoder.encode(area, forKey: "area")
		}
		if areaId != nil{
			aCoder.encode(areaId, forKey: "area_id")
		}
		if areaName != nil{
			aCoder.encode(areaName, forKey: "area_name")
		}
		if avenue != nil{
			aCoder.encode(avenue, forKey: "avenue")
		}
		if block != nil{
			aCoder.encode(block, forKey: "block")
		}
		if buildingNumber != nil{
			aCoder.encode(buildingNumber, forKey: "building_number")
		}
		if expressDelivery != nil{
			aCoder.encode(expressDelivery, forKey: "express_delivery")
		}
		if expressDeliveryCharge != nil{
			aCoder.encode(expressDeliveryCharge, forKey: "express_delivery_charge")
		}
		if expressDeliveryTime != nil{
			aCoder.encode(expressDeliveryTime, forKey: "express_delivery_time")
		}
		if expressDeliveryTimeUnit != nil{
			aCoder.encode(expressDeliveryTimeUnit, forKey: "express_delivery_time_unit")
		}
		if floor != nil{
			aCoder.encode(floor, forKey: "floor")
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
		if isDefault != nil{
			aCoder.encode(isDefault, forKey: "is_default")
		}
		if isDeliveryAvailable != nil{
			aCoder.encode(isDeliveryAvailable, forKey: "is_delivery_available")
		}
		if latitude != nil{
			aCoder.encode(latitude, forKey: "latitude")
		}
		if longitude != nil{
			aCoder.encode(longitude, forKey: "longitude")
		}
		if street != nil{
			aCoder.encode(street, forKey: "street")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "user_id")
		}

	}

}