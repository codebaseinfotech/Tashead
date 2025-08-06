//
//	TBLoyaltyCouponsHistoryResult.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBLoyaltyCouponsHistoryResult : NSObject, NSCoding{

	var history : [TBLoyaltyCouponsHistoryHistory]!
	var point : String!


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
		history = [TBLoyaltyCouponsHistoryHistory]()
		if let historyArray = dictionary["history"] as? [NSDictionary]{
			for dic in historyArray{
				let value = TBLoyaltyCouponsHistoryHistory(fromDictionary: dic)
				history.append(value)
			}
		}
		point = dictionary["point"] as? String == nil ? "" : dictionary["point"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if history != nil{
			var dictionaryElements = [NSDictionary]()
			for historyElement in history {
				dictionaryElements.append(historyElement.toDictionary())
			}
			dictionary["history"] = dictionaryElements
		}
		if point != nil{
			dictionary["point"] = point
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         history = aDecoder.decodeObject(forKey: "history") as? [TBLoyaltyCouponsHistoryHistory]
         point = aDecoder.decodeObject(forKey: "point") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if history != nil{
			aCoder.encode(history, forKey: "history")
		}
		if point != nil{
			aCoder.encode(point, forKey: "point")
		}

	}

}