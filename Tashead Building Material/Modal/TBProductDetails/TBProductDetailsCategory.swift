//
//	TBProductDetailsCategory.swift
//
//	Create by Ankit Gabani on 24/7/2024
//	Copyright © 2024. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBProductDetailsCategory : NSObject, NSCoding{

	var categoryImage : String!
	var id : Int!
	var isStepCategory : Int!
	var level : Int!
	var name : String!
	var orderByChildCategory : Int!
	var orderByMasterCategory : Int!
	var orderBySubCategory : Int!
	var parentId : Int!
	var status : Int!


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
		categoryImage = dictionary["category_image"] as? String == nil ? "" : dictionary["category_image"] as? String
		id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
		isStepCategory = dictionary["is_step_category"] as? Int == nil ? 0 : dictionary["is_step_category"] as? Int
		level = dictionary["level"] as? Int == nil ? 0 : dictionary["level"] as? Int
		name = dictionary["name"] as? String == nil ? "" : dictionary["name"] as? String
		orderByChildCategory = dictionary["order_by_child_category"] as? Int == nil ? 0 : dictionary["order_by_child_category"] as? Int
		orderByMasterCategory = dictionary["order_by_master_category"] as? Int == nil ? 0 : dictionary["order_by_master_category"] as? Int
		orderBySubCategory = dictionary["order_by_sub_category"] as? Int == nil ? 0 : dictionary["order_by_sub_category"] as? Int
		parentId = dictionary["parent_id"] as? Int == nil ? 0 : dictionary["parent_id"] as? Int
		status = dictionary["status"] as? Int == nil ? 0 : dictionary["status"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if categoryImage != nil{
			dictionary["category_image"] = categoryImage
		}
		if id != nil{
			dictionary["id"] = id
		}
		if isStepCategory != nil{
			dictionary["is_step_category"] = isStepCategory
		}
		if level != nil{
			dictionary["level"] = level
		}
		if name != nil{
			dictionary["name"] = name
		}
		if orderByChildCategory != nil{
			dictionary["order_by_child_category"] = orderByChildCategory
		}
		if orderByMasterCategory != nil{
			dictionary["order_by_master_category"] = orderByMasterCategory
		}
		if orderBySubCategory != nil{
			dictionary["order_by_sub_category"] = orderBySubCategory
		}
		if parentId != nil{
			dictionary["parent_id"] = parentId
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
         categoryImage = aDecoder.decodeObject(forKey: "category_image") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         isStepCategory = aDecoder.decodeObject(forKey: "is_step_category") as? Int
         level = aDecoder.decodeObject(forKey: "level") as? Int
         name = aDecoder.decodeObject(forKey: "name") as? String
         orderByChildCategory = aDecoder.decodeObject(forKey: "order_by_child_category") as? Int
         orderByMasterCategory = aDecoder.decodeObject(forKey: "order_by_master_category") as? Int
         orderBySubCategory = aDecoder.decodeObject(forKey: "order_by_sub_category") as? Int
         parentId = aDecoder.decodeObject(forKey: "parent_id") as? Int
         status = aDecoder.decodeObject(forKey: "status") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if categoryImage != nil{
			aCoder.encode(categoryImage, forKey: "category_image")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if isStepCategory != nil{
			aCoder.encode(isStepCategory, forKey: "is_step_category")
		}
		if level != nil{
			aCoder.encode(level, forKey: "level")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if orderByChildCategory != nil{
			aCoder.encode(orderByChildCategory, forKey: "order_by_child_category")
		}
		if orderByMasterCategory != nil{
			aCoder.encode(orderByMasterCategory, forKey: "order_by_master_category")
		}
		if orderBySubCategory != nil{
			aCoder.encode(orderBySubCategory, forKey: "order_by_sub_category")
		}
		if parentId != nil{
			aCoder.encode(parentId, forKey: "parent_id")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}

	}

}