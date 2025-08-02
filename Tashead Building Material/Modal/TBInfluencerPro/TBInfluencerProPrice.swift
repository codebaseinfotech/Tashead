//
//	TBInfluencerProPrice.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBInfluencerProPrice : NSObject, NSCoding{

	var discount : Int!
	var discountAmount : String!
	var discountPrice : String!
	var factoryProduct : Int!
	var factoryQuantity : Int!
	var height : Int!
	var heightType : String!
	var length : Int!
	var lengthType : String!
	var minusQuantity : Int!
	var netPrice : Float!
	var originalPrice : String!
	var percentageFlatDiscount : String!
	var price : String!
	var productId : Int!
	var productPriceId : Int!
	var quantity : Int!
	var supplierId : Int!
	var supplierImage : String!
	var value : String!
	var weight : Float!
	var weightType : String!
	var width : Int!
	var widthType : String!


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
		discount = dictionary["discount"] as? Int == nil ? 0 : dictionary["discount"] as? Int
		discountAmount = dictionary["discount_amount"] as? String == nil ? "" : dictionary["discount_amount"] as? String
		discountPrice = dictionary["discount_price"] as? String == nil ? "" : dictionary["discount_price"] as? String
		factoryProduct = dictionary["factory_product"] as? Int == nil ? 0 : dictionary["factory_product"] as? Int
		factoryQuantity = dictionary["factory_quantity"] as? Int == nil ? 0 : dictionary["factory_quantity"] as? Int
		height = dictionary["height"] as? Int == nil ? 0 : dictionary["height"] as? Int
		heightType = dictionary["height_type"] as? String == nil ? "" : dictionary["height_type"] as? String
		length = dictionary["length"] as? Int == nil ? 0 : dictionary["length"] as? Int
		lengthType = dictionary["length_type"] as? String == nil ? "" : dictionary["length_type"] as? String
		minusQuantity = dictionary["minus_quantity"] as? Int == nil ? 0 : dictionary["minus_quantity"] as? Int
		netPrice = dictionary["net_price"] as? Float == nil ? 0 : dictionary["net_price"] as? Float
		originalPrice = dictionary["original_price"] as? String == nil ? "" : dictionary["original_price"] as? String
		percentageFlatDiscount = dictionary["percentage_flat_discount"] as? String == nil ? "" : dictionary["percentage_flat_discount"] as? String
		price = dictionary["price"] as? String == nil ? "" : dictionary["price"] as? String
		productId = dictionary["product_id"] as? Int == nil ? 0 : dictionary["product_id"] as? Int
		productPriceId = dictionary["product_price_id"] as? Int == nil ? 0 : dictionary["product_price_id"] as? Int
		quantity = dictionary["quantity"] as? Int == nil ? 0 : dictionary["quantity"] as? Int
		supplierId = dictionary["supplier_id"] as? Int == nil ? 0 : dictionary["supplier_id"] as? Int
		supplierImage = dictionary["supplier_image"] as? String == nil ? "" : dictionary["supplier_image"] as? String
		value = dictionary["value"] as? String == nil ? "" : dictionary["value"] as? String
		weight = dictionary["weight"] as? Float == nil ? 0 : dictionary["weight"] as? Float
		weightType = dictionary["weight_type"] as? String == nil ? "" : dictionary["weight_type"] as? String
		width = dictionary["width"] as? Int == nil ? 0 : dictionary["width"] as? Int
		widthType = dictionary["width_type"] as? String == nil ? "" : dictionary["width_type"] as? String
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
		if discountAmount != nil{
			dictionary["discount_amount"] = discountAmount
		}
		if discountPrice != nil{
			dictionary["discount_price"] = discountPrice
		}
		if factoryProduct != nil{
			dictionary["factory_product"] = factoryProduct
		}
		if factoryQuantity != nil{
			dictionary["factory_quantity"] = factoryQuantity
		}
		if height != nil{
			dictionary["height"] = height
		}
		if heightType != nil{
			dictionary["height_type"] = heightType
		}
		if length != nil{
			dictionary["length"] = length
		}
		if lengthType != nil{
			dictionary["length_type"] = lengthType
		}
		if minusQuantity != nil{
			dictionary["minus_quantity"] = minusQuantity
		}
		if netPrice != nil{
			dictionary["net_price"] = netPrice
		}
		if originalPrice != nil{
			dictionary["original_price"] = originalPrice
		}
		if percentageFlatDiscount != nil{
			dictionary["percentage_flat_discount"] = percentageFlatDiscount
		}
		if price != nil{
			dictionary["price"] = price
		}
		if productId != nil{
			dictionary["product_id"] = productId
		}
		if productPriceId != nil{
			dictionary["product_price_id"] = productPriceId
		}
		if quantity != nil{
			dictionary["quantity"] = quantity
		}
		if supplierId != nil{
			dictionary["supplier_id"] = supplierId
		}
		if supplierImage != nil{
			dictionary["supplier_image"] = supplierImage
		}
		if value != nil{
			dictionary["value"] = value
		}
		if weight != nil{
			dictionary["weight"] = weight
		}
		if weightType != nil{
			dictionary["weight_type"] = weightType
		}
		if width != nil{
			dictionary["width"] = width
		}
		if widthType != nil{
			dictionary["width_type"] = widthType
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         discount = aDecoder.decodeObject(forKey: "discount") as? Int
         discountAmount = aDecoder.decodeObject(forKey: "discount_amount") as? String
         discountPrice = aDecoder.decodeObject(forKey: "discount_price") as? String
         factoryProduct = aDecoder.decodeObject(forKey: "factory_product") as? Int
         factoryQuantity = aDecoder.decodeObject(forKey: "factory_quantity") as? Int
         height = aDecoder.decodeObject(forKey: "height") as? Int
         heightType = aDecoder.decodeObject(forKey: "height_type") as? String
         length = aDecoder.decodeObject(forKey: "length") as? Int
         lengthType = aDecoder.decodeObject(forKey: "length_type") as? String
         minusQuantity = aDecoder.decodeObject(forKey: "minus_quantity") as? Int
         netPrice = aDecoder.decodeObject(forKey: "net_price") as? Float
         originalPrice = aDecoder.decodeObject(forKey: "original_price") as? String
         percentageFlatDiscount = aDecoder.decodeObject(forKey: "percentage_flat_discount") as? String
         price = aDecoder.decodeObject(forKey: "price") as? String
         productId = aDecoder.decodeObject(forKey: "product_id") as? Int
         productPriceId = aDecoder.decodeObject(forKey: "product_price_id") as? Int
         quantity = aDecoder.decodeObject(forKey: "quantity") as? Int
         supplierId = aDecoder.decodeObject(forKey: "supplier_id") as? Int
         supplierImage = aDecoder.decodeObject(forKey: "supplier_image") as? String
         value = aDecoder.decodeObject(forKey: "value") as? String
         weight = aDecoder.decodeObject(forKey: "weight") as? Float
         weightType = aDecoder.decodeObject(forKey: "weight_type") as? String
         width = aDecoder.decodeObject(forKey: "width") as? Int
         widthType = aDecoder.decodeObject(forKey: "width_type") as? String

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
		if discountAmount != nil{
			aCoder.encode(discountAmount, forKey: "discount_amount")
		}
		if discountPrice != nil{
			aCoder.encode(discountPrice, forKey: "discount_price")
		}
		if factoryProduct != nil{
			aCoder.encode(factoryProduct, forKey: "factory_product")
		}
		if factoryQuantity != nil{
			aCoder.encode(factoryQuantity, forKey: "factory_quantity")
		}
		if height != nil{
			aCoder.encode(height, forKey: "height")
		}
		if heightType != nil{
			aCoder.encode(heightType, forKey: "height_type")
		}
		if length != nil{
			aCoder.encode(length, forKey: "length")
		}
		if lengthType != nil{
			aCoder.encode(lengthType, forKey: "length_type")
		}
		if minusQuantity != nil{
			aCoder.encode(minusQuantity, forKey: "minus_quantity")
		}
		if netPrice != nil{
			aCoder.encode(netPrice, forKey: "net_price")
		}
		if originalPrice != nil{
			aCoder.encode(originalPrice, forKey: "original_price")
		}
		if percentageFlatDiscount != nil{
			aCoder.encode(percentageFlatDiscount, forKey: "percentage_flat_discount")
		}
		if price != nil{
			aCoder.encode(price, forKey: "price")
		}
		if productId != nil{
			aCoder.encode(productId, forKey: "product_id")
		}
		if productPriceId != nil{
			aCoder.encode(productPriceId, forKey: "product_price_id")
		}
		if quantity != nil{
			aCoder.encode(quantity, forKey: "quantity")
		}
		if supplierId != nil{
			aCoder.encode(supplierId, forKey: "supplier_id")
		}
		if supplierImage != nil{
			aCoder.encode(supplierImage, forKey: "supplier_image")
		}
		if value != nil{
			aCoder.encode(value, forKey: "value")
		}
		if weight != nil{
			aCoder.encode(weight, forKey: "weight")
		}
		if weightType != nil{
			aCoder.encode(weightType, forKey: "weight_type")
		}
		if width != nil{
			aCoder.encode(width, forKey: "width")
		}
		if widthType != nil{
			aCoder.encode(widthType, forKey: "width_type")
		}

	}

}