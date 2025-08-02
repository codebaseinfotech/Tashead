//
//	TBOrderDetailOrderItem.swift
//
//	Create by iMac on 1/1/2024
//	Copyright © 2024. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBOrderDetailOrderItem : NSObject, NSCoding{

	var discount : String!
	var netPrice : String!
	var price : String!
	var productId : Int!
	var productName : String!
	var productPriceId : Int!
	var productUnitId : Int!
	var quantity : Int!
	var supplierId : Int!
	var supplierName : String!
	var total : String!
	var unitType : String!
	var weightId : Int!
	var weightName : String!
    var weight : Int!
    var weight_type : String!
    var image : String!
    var is_supplier_detail_show : Int!


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
		discount = dictionary["discount"] as? String == nil ? "" : dictionary["discount"] as? String
		netPrice = dictionary["net_price"] as? String == nil ? "" : dictionary["net_price"] as? String
		price = dictionary["price"] as? String == nil ? "" : dictionary["price"] as? String
		productId = dictionary["product_id"] as? Int == nil ? 0 : dictionary["product_id"] as? Int
		productName = dictionary["product_name"] as? String == nil ? "" : dictionary["product_name"] as? String
		productPriceId = dictionary["product_price_id"] as? Int == nil ? 0 : dictionary["product_price_id"] as? Int
		productUnitId = dictionary["product_unit_id"] as? Int == nil ? 0 : dictionary["product_unit_id"] as? Int
		quantity = dictionary["quantity"] as? Int == nil ? 0 : dictionary["quantity"] as? Int
		supplierId = dictionary["supplier_id"] as? Int == nil ? 0 : dictionary["supplier_id"] as? Int
		supplierName = dictionary["supplier_name"] as? String == nil ? "" : dictionary["supplier_name"] as? String
		total = dictionary["total"] as? String == nil ? "" : dictionary["total"] as? String
		unitType = dictionary["unit_type"] as? String == nil ? "" : dictionary["unit_type"] as? String
		weightId = dictionary["weight_id"] as? Int == nil ? 0 : dictionary["weight_id"] as? Int
		weightName = dictionary["weight_name"] as? String == nil ? "" : dictionary["weight_name"] as? String
        
        weight = dictionary["weight"] as? Int == nil ? 0 : dictionary["weight"] as? Int
        weight_type = dictionary["weight_type"] as? String == nil ? "" : dictionary["weight_type"] as? String
        image = dictionary["image"] as? String == nil ? "" : dictionary["image"] as? String
        is_supplier_detail_show = dictionary["is_supplier_detail_show"] as? Int == nil ? 0 : dictionary["is_supplier_detail_show"] as? Int

	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if discount != nil{
			dictionary["discount"] = discount
		}
		if netPrice != nil{
			dictionary["net_price"] = netPrice
		}
		if price != nil{
			dictionary["price"] = price
		}
		if productId != nil{
			dictionary["product_id"] = productId
		}
		if productName != nil{
			dictionary["product_name"] = productName
		}
		if productPriceId != nil{
			dictionary["product_price_id"] = productPriceId
		}
		if productUnitId != nil{
			dictionary["product_unit_id"] = productUnitId
		}
		if quantity != nil{
			dictionary["quantity"] = quantity
		}
		if supplierId != nil{
			dictionary["supplier_id"] = supplierId
		}
		if supplierName != nil{
			dictionary["supplier_name"] = supplierName
		}
		if total != nil{
			dictionary["total"] = total
		}
		if unitType != nil{
			dictionary["unit_type"] = unitType
		}
		if weightId != nil{
			dictionary["weight_id"] = weightId
		}
		if weightName != nil{
			dictionary["weight_name"] = weightName
		}
        
        if weight != nil{
            dictionary["weight"] = weight
        }
        if weight_type != nil{
            dictionary["weight_type"] = weight_type
        }
        if is_supplier_detail_show != nil{
            dictionary["is_supplier_detail_show"] = is_supplier_detail_show
        }
        if image != nil{
            dictionary["image"] = image
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         discount = aDecoder.decodeObject(forKey: "discount") as? String
         netPrice = aDecoder.decodeObject(forKey: "net_price") as? String
         price = aDecoder.decodeObject(forKey: "price") as? String
         productId = aDecoder.decodeObject(forKey: "product_id") as? Int
         productName = aDecoder.decodeObject(forKey: "product_name") as? String
         productPriceId = aDecoder.decodeObject(forKey: "product_price_id") as? Int
         productUnitId = aDecoder.decodeObject(forKey: "product_unit_id") as? Int
         quantity = aDecoder.decodeObject(forKey: "quantity") as? Int
         supplierId = aDecoder.decodeObject(forKey: "supplier_id") as? Int
         supplierName = aDecoder.decodeObject(forKey: "supplier_name") as? String
         total = aDecoder.decodeObject(forKey: "total") as? String
         unitType = aDecoder.decodeObject(forKey: "unit_type") as? String
         weightId = aDecoder.decodeObject(forKey: "weight_id") as? Int
         weightName = aDecoder.decodeObject(forKey: "weight_name") as? String
        
        weight = aDecoder.decodeObject(forKey: "weight") as? Int
        weight_type = aDecoder.decodeObject(forKey: "weight_type") as? String
        image = aDecoder.decodeObject(forKey: "image") as? String
        is_supplier_detail_show = aDecoder.decodeObject(forKey: "is_supplier_detail_show") as? Int


	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if discount != nil{
			aCoder.encode(discount, forKey: "discount")
		}
		if netPrice != nil{
			aCoder.encode(netPrice, forKey: "net_price")
		}
		if price != nil{
			aCoder.encode(price, forKey: "price")
		}
		if productId != nil{
			aCoder.encode(productId, forKey: "product_id")
		}
		if productName != nil{
			aCoder.encode(productName, forKey: "product_name")
		}
		if productPriceId != nil{
			aCoder.encode(productPriceId, forKey: "product_price_id")
		}
		if productUnitId != nil{
			aCoder.encode(productUnitId, forKey: "product_unit_id")
		}
		if quantity != nil{
			aCoder.encode(quantity, forKey: "quantity")
		}
		if supplierId != nil{
			aCoder.encode(supplierId, forKey: "supplier_id")
		}
		if supplierName != nil{
			aCoder.encode(supplierName, forKey: "supplier_name")
		}
		if total != nil{
			aCoder.encode(total, forKey: "total")
		}
		if unitType != nil{
			aCoder.encode(unitType, forKey: "unit_type")
		}
		if weightId != nil{
			aCoder.encode(weightId, forKey: "weight_id")
		}
		if weightName != nil{
			aCoder.encode(weightName, forKey: "weight_name")
		}
        
        if weight != nil{
            aCoder.encode(weight, forKey: "weight")
        }
        if weight_type != nil{
            aCoder.encode(weight_type, forKey: "weight_type")
        }
        if image != nil{
            aCoder.encode(image, forKey: "image")
        }
        if is_supplier_detail_show != nil{
            aCoder.encode(is_supplier_detail_show, forKey: "is_supplier_detail_show")
        }


	}

}
