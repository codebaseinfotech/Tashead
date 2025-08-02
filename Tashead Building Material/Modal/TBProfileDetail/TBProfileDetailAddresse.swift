//
//	TBProfileDetailAddresse.swift
//
//	Create by iMac on 20/12/2023
//	Copyright © 2023. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBProfileDetailAddresse : NSObject, NSCoding{

	var address : String!
	var apartment : String!
	var areaId : String!
	var avenue : String!
	var block : String!
	var buildingNumber : String!
	var createdAt : String!
	var floor : String!
	var id : Int!
	var isDefault : Int!
	var latitude : String!
	var longitude : String!
	var street : String!
	var updatedAt : String!
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
		areaId = dictionary["area_id"] as? String == nil ? "" : dictionary["area_id"] as? String
		avenue = dictionary["avenue"] as? String == nil ? "" : dictionary["avenue"] as? String
		block = dictionary["block"] as? String == nil ? "" : dictionary["block"] as? String
		buildingNumber = dictionary["building_number"] as? String == nil ? "" : dictionary["building_number"] as? String
		createdAt = dictionary["created_at"] as? String == nil ? "" : dictionary["created_at"] as? String
		floor = dictionary["floor"] as? String == nil ? "" : dictionary["floor"] as? String
		id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
		isDefault = dictionary["is_default"] as? Int == nil ? 0 : dictionary["is_default"] as? Int
		latitude = dictionary["latitude"] as? String == nil ? "" : dictionary["latitude"] as? String
		longitude = dictionary["longitude"] as? String == nil ? "" : dictionary["longitude"] as? String
		street = dictionary["street"] as? String == nil ? "" : dictionary["street"] as? String
		updatedAt = dictionary["updated_at"] as? String == nil ? "" : dictionary["updated_at"] as? String
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
		if areaId != nil{
			dictionary["area_id"] = areaId
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
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if floor != nil{
			dictionary["floor"] = floor
		}
		if id != nil{
			dictionary["id"] = id
		}
		if isDefault != nil{
			dictionary["is_default"] = isDefault
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
         address = aDecoder.decodeObject(forKey: "address") as? String
         apartment = aDecoder.decodeObject(forKey: "apartment") as? String
         areaId = aDecoder.decodeObject(forKey: "area_id") as? String
         avenue = aDecoder.decodeObject(forKey: "avenue") as? String
         block = aDecoder.decodeObject(forKey: "block") as? String
         buildingNumber = aDecoder.decodeObject(forKey: "building_number") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         floor = aDecoder.decodeObject(forKey: "floor") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         isDefault = aDecoder.decodeObject(forKey: "is_default") as? Int
         latitude = aDecoder.decodeObject(forKey: "latitude") as? String
         longitude = aDecoder.decodeObject(forKey: "longitude") as? String
         street = aDecoder.decodeObject(forKey: "street") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
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
		if areaId != nil{
			aCoder.encode(areaId, forKey: "area_id")
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
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if floor != nil{
			aCoder.encode(floor, forKey: "floor")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if isDefault != nil{
			aCoder.encode(isDefault, forKey: "is_default")
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
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "user_id")
		}

	}

}