//
//	TBInfluencersListResult.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBInfluencersListResult : NSObject, NSCoding{

	var id : Int!
	var image : String!
	var name : String!
	var status : Int!
	var type : String!


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
		id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
		image = dictionary["image"] as? String == nil ? "" : dictionary["image"] as? String
		name = dictionary["name"] as? String == nil ? "" : dictionary["name"] as? String
		status = dictionary["status"] as? Int == nil ? 0 : dictionary["status"] as? Int
		type = dictionary["type"] as? String == nil ? "" : dictionary["type"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if id != nil{
			dictionary["id"] = id
		}
		if image != nil{
			dictionary["image"] = image
		}
		if name != nil{
			dictionary["name"] = name
		}
		if status != nil{
			dictionary["status"] = status
		}
		if type != nil{
			dictionary["type"] = type
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "id") as? Int
         image = aDecoder.decodeObject(forKey: "image") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         status = aDecoder.decodeObject(forKey: "status") as? Int
         type = aDecoder.decodeObject(forKey: "type") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if image != nil{
			aCoder.encode(image, forKey: "image")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if type != nil{
			aCoder.encode(type, forKey: "type")
		}

	}

}