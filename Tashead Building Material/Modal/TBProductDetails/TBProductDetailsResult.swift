//
//	TBProductDetailsResult.swift
//
//	Create by Ankit Gabani on 24/7/2024
//	Copyright © 2024. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBProductDetailsResult : NSObject, NSCoding{

	var categories : [TBProductDetailsCategory]!
	var currentPage : Int!
	var data : [TBProductDetailsData]!
	var from : Int!
	var lastPage : Int!
	var perPage : Int!
	var to : Int!
	var total : Int!


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
		categories = [TBProductDetailsCategory]()
		if let categoriesArray = dictionary["categories"] as? [NSDictionary]{
			for dic in categoriesArray{
				let value = TBProductDetailsCategory(fromDictionary: dic)
				categories.append(value)
			}
		}
		currentPage = dictionary["current_page"] as? Int == nil ? 0 : dictionary["current_page"] as? Int
		data = [TBProductDetailsData]()
		if let dataArray = dictionary["data"] as? [NSDictionary]{
			for dic in dataArray{
				let value = TBProductDetailsData(fromDictionary: dic)
				data.append(value)
			}
		}
		from = dictionary["from"] as? Int == nil ? 0 : dictionary["from"] as? Int
		lastPage = dictionary["last_page"] as? Int == nil ? 0 : dictionary["last_page"] as? Int
		perPage = dictionary["per_page"] as? Int == nil ? 0 : dictionary["per_page"] as? Int
		to = dictionary["to"] as? Int == nil ? 0 : dictionary["to"] as? Int
		total = dictionary["total"] as? Int == nil ? 0 : dictionary["total"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if categories != nil{
			var dictionaryElements = [NSDictionary]()
			for categoriesElement in categories {
				dictionaryElements.append(categoriesElement.toDictionary())
			}
			dictionary["categories"] = dictionaryElements
		}
		if currentPage != nil{
			dictionary["current_page"] = currentPage
		}
		if data != nil{
			var dictionaryElements = [NSDictionary]()
			for dataElement in data {
				dictionaryElements.append(dataElement.toDictionary())
			}
			dictionary["data"] = dictionaryElements
		}
		if from != nil{
			dictionary["from"] = from
		}
		if lastPage != nil{
			dictionary["last_page"] = lastPage
		}
		if perPage != nil{
			dictionary["per_page"] = perPage
		}
		if to != nil{
			dictionary["to"] = to
		}
		if total != nil{
			dictionary["total"] = total
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         categories = aDecoder.decodeObject(forKey: "categories") as? [TBProductDetailsCategory]
         currentPage = aDecoder.decodeObject(forKey: "current_page") as? Int
         data = aDecoder.decodeObject(forKey: "data") as? [TBProductDetailsData]
         from = aDecoder.decodeObject(forKey: "from") as? Int
         lastPage = aDecoder.decodeObject(forKey: "last_page") as? Int
         perPage = aDecoder.decodeObject(forKey: "per_page") as? Int
         to = aDecoder.decodeObject(forKey: "to") as? Int
         total = aDecoder.decodeObject(forKey: "total") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if categories != nil{
			aCoder.encode(categories, forKey: "categories")
		}
		if currentPage != nil{
			aCoder.encode(currentPage, forKey: "current_page")
		}
		if data != nil{
			aCoder.encode(data, forKey: "data")
		}
		if from != nil{
			aCoder.encode(from, forKey: "from")
		}
		if lastPage != nil{
			aCoder.encode(lastPage, forKey: "last_page")
		}
		if perPage != nil{
			aCoder.encode(perPage, forKey: "per_page")
		}
		if to != nil{
			aCoder.encode(to, forKey: "to")
		}
		if total != nil{
			aCoder.encode(total, forKey: "total")
		}

	}

}