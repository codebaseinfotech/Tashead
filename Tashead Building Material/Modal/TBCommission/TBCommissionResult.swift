//
//	TBCommissionResult.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBCommissionResult : NSObject, NSCoding{

	var totalCommissionAmount : String!
	var totalPaidCommissionAmount : String!
	var totalUnpaidCommissionAmount : String!
	var userOrderedDiscounts : [TBCommissionUserOrderedDiscount]!


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
		totalCommissionAmount = dictionary["total_commission_amount"] as? String == nil ? "" : dictionary["total_commission_amount"] as? String
		totalPaidCommissionAmount = dictionary["total_paid_commission_amount"] as? String == nil ? "" : dictionary["total_paid_commission_amount"] as? String
		totalUnpaidCommissionAmount = dictionary["total_unpaid_commission_amount"] as? String == nil ? "" : dictionary["total_unpaid_commission_amount"] as? String
		userOrderedDiscounts = [TBCommissionUserOrderedDiscount]()
		if let userOrderedDiscountsArray = dictionary["user_ordered_discounts"] as? [NSDictionary]{
			for dic in userOrderedDiscountsArray{
				let value = TBCommissionUserOrderedDiscount(fromDictionary: dic)
				userOrderedDiscounts.append(value)
			}
		}
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if totalCommissionAmount != nil{
			dictionary["total_commission_amount"] = totalCommissionAmount
		}
		if totalPaidCommissionAmount != nil{
			dictionary["total_paid_commission_amount"] = totalPaidCommissionAmount
		}
		if totalUnpaidCommissionAmount != nil{
			dictionary["total_unpaid_commission_amount"] = totalUnpaidCommissionAmount
		}
		if userOrderedDiscounts != nil{
			var dictionaryElements = [NSDictionary]()
			for userOrderedDiscountsElement in userOrderedDiscounts {
				dictionaryElements.append(userOrderedDiscountsElement.toDictionary())
			}
			dictionary["user_ordered_discounts"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         totalCommissionAmount = aDecoder.decodeObject(forKey: "total_commission_amount") as? String
         totalPaidCommissionAmount = aDecoder.decodeObject(forKey: "total_paid_commission_amount") as? String
         totalUnpaidCommissionAmount = aDecoder.decodeObject(forKey: "total_unpaid_commission_amount") as? String
         userOrderedDiscounts = aDecoder.decodeObject(forKey: "user_ordered_discounts") as? [TBCommissionUserOrderedDiscount]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if totalCommissionAmount != nil{
			aCoder.encode(totalCommissionAmount, forKey: "total_commission_amount")
		}
		if totalPaidCommissionAmount != nil{
			aCoder.encode(totalPaidCommissionAmount, forKey: "total_paid_commission_amount")
		}
		if totalUnpaidCommissionAmount != nil{
			aCoder.encode(totalUnpaidCommissionAmount, forKey: "total_unpaid_commission_amount")
		}
		if userOrderedDiscounts != nil{
			aCoder.encode(userOrderedDiscounts, forKey: "user_ordered_discounts")
		}

	}

}