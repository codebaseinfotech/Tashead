//
//	TBDeliverySlotsResult.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBDeliverySlotsResult : NSObject, NSCoding{

	var date : String!
	var day : String!
	var slots : [TBDeliverySlotsSlot]!


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
		date = dictionary["date"] as? String == nil ? "" : dictionary["date"] as? String
		day = dictionary["day"] as? String == nil ? "" : dictionary["day"] as? String
		slots = [TBDeliverySlotsSlot]()
		if let slotsArray = dictionary["slots"] as? [NSDictionary]{
			for dic in slotsArray{
				let value = TBDeliverySlotsSlot(fromDictionary: dic)
				slots.append(value)
			}
		}
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if date != nil{
			dictionary["date"] = date
		}
		if day != nil{
			dictionary["day"] = day
		}
		if slots != nil{
			var dictionaryElements = [NSDictionary]()
			for slotsElement in slots {
				dictionaryElements.append(slotsElement.toDictionary())
			}
			dictionary["slots"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         date = aDecoder.decodeObject(forKey: "date") as? String
         day = aDecoder.decodeObject(forKey: "day") as? String
         slots = aDecoder.decodeObject(forKey: "slots") as? [TBDeliverySlotsSlot]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if date != nil{
			aCoder.encode(date, forKey: "date")
		}
		if day != nil{
			aCoder.encode(day, forKey: "day")
		}
		if slots != nil{
			aCoder.encode(slots, forKey: "slots")
		}

	}

}