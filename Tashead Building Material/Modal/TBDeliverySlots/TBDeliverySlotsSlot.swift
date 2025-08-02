//
//	TBDeliverySlotsSlot.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBDeliverySlotsSlot : NSObject, NSCoding{

	var endTime : String!
	var id : Int!
    var startTime : String!
    var remaining_slots : Int!
	var max_allowed_slots : Int!



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
		endTime = dictionary["end_time"] as? String == nil ? "" : dictionary["end_time"] as? String
		id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
		startTime = dictionary["start_time"] as? String == nil ? "" : dictionary["start_time"] as? String
        remaining_slots = dictionary["remaining_slots"] as? Int == nil ? 0 : dictionary["remaining_slots"] as? Int
        max_allowed_slots = dictionary["max_allowed_slots"] as? Int == nil ? 0 : dictionary["max_allowed_slots"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if endTime != nil{
			dictionary["end_time"] = endTime
		}
		if id != nil{
			dictionary["id"] = id
		}
		if startTime != nil{
            dictionary["start_time"] = startTime
        }
        if remaining_slots != nil{
            dictionary["remaining_slots"] = remaining_slots
        }
        if max_allowed_slots != nil{
			dictionary["max_allowed_slots"] = max_allowed_slots
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         endTime = aDecoder.decodeObject(forKey: "end_time") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
        remaining_slots = aDecoder.decodeObject(forKey: "remaining_slots") as? Int
        max_allowed_slots = aDecoder.decodeObject(forKey: "max_allowed_slots") as? Int
         startTime = aDecoder.decodeObject(forKey: "start_time") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if endTime != nil{
			aCoder.encode(endTime, forKey: "end_time")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if startTime != nil{
            aCoder.encode(startTime, forKey: "start_time")
        }
        if remaining_slots != nil{
            aCoder.encode(remaining_slots, forKey: "remaining_slots")
        }
        if max_allowed_slots != nil{
			aCoder.encode(max_allowed_slots, forKey: "max_allowed_slots")
		}

	}

}
