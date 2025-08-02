//
//	TBOrderList.swift
//
//	Create by iMac on 1/1/2024
//	Copyright © 2024. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBOrderList : NSObject, NSCoding{

	var code : Int!
	var message : String!
	var result : [TBOrderListResult]!
	var status : Bool!


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
		code = dictionary["code"] as? Int == nil ? 0 : dictionary["code"] as? Int
		message = dictionary["message"] as? String == nil ? "" : dictionary["message"] as? String
		result = [TBOrderListResult]()
		if let resultArray = dictionary["result"] as? [NSDictionary]{
			for dic in resultArray{
				let value = TBOrderListResult(fromDictionary: dic)
				result.append(value)
			}
		}
		status = dictionary["status"] as? Bool == nil ? false : dictionary["status"] as? Bool
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if code != nil{
			dictionary["code"] = code
		}
		if message != nil{
			dictionary["message"] = message
		}
		if result != nil{
			var dictionaryElements = [NSDictionary]()
			for resultElement in result {
				dictionaryElements.append(resultElement.toDictionary())
			}
			dictionary["result"] = dictionaryElements
		}
		if status != nil{
			dictionary["status"] = status
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         code = aDecoder.decodeObject(forKey: "code") as? Int
         message = aDecoder.decodeObject(forKey: "message") as? String
         result = aDecoder.decodeObject(forKey: "result") as? [TBOrderListResult]
         status = aDecoder.decodeObject(forKey: "status") as? Bool

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if code != nil{
			aCoder.encode(code, forKey: "code")
		}
		if message != nil{
			aCoder.encode(message, forKey: "message")
		}
		if result != nil{
			aCoder.encode(result, forKey: "result")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}

	}

}