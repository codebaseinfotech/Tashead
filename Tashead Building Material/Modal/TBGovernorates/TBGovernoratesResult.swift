//
//	TBGovernoratesResult.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBGovernoratesResult : NSObject, NSCoding{

	var areas : [TBGovernoratesArea]!
	var createdAt : String!
	var governorateNameEn : String!
	var id : Int!
	var status : Int!
	var updatedAt : String!
    var name : String!


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
		areas = [TBGovernoratesArea]()
		if let areasArray = dictionary["areas"] as? [NSDictionary]{
			for dic in areasArray{
				let value = TBGovernoratesArea(fromDictionary: dic)
				areas.append(value)
			}
		}
		createdAt = dictionary["created_at"] as? String == nil ? "" : dictionary["created_at"] as? String
		governorateNameEn = dictionary["governorate_name_en"] as? String == nil ? "" : dictionary["governorate_name_en"] as? String
		id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
		status = dictionary["status"] as? Int == nil ? 0 : dictionary["status"] as? Int
		updatedAt = dictionary["updated_at"] as? String == nil ? "" : dictionary["updated_at"] as? String
        name = dictionary["name"] as? String == nil ? "" : dictionary["name"] as? String

	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if areas != nil{
			var dictionaryElements = [NSDictionary]()
			for areasElement in areas {
				dictionaryElements.append(areasElement.toDictionary())
			}
			dictionary["areas"] = dictionaryElements
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if governorateNameEn != nil{
			dictionary["governorate_name_en"] = governorateNameEn
		}
		if id != nil{
			dictionary["id"] = id
		}
		if status != nil{
			dictionary["status"] = status
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt
		}
        if name != nil{
            dictionary["name"] = name
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         areas = aDecoder.decodeObject(forKey: "areas") as? [TBGovernoratesArea]
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         governorateNameEn = aDecoder.decodeObject(forKey: "governorate_name_en") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         status = aDecoder.decodeObject(forKey: "status") as? Int
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if areas != nil{
			aCoder.encode(areas, forKey: "areas")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if governorateNameEn != nil{
			aCoder.encode(governorateNameEn, forKey: "governorate_name_en")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }

	}

}
