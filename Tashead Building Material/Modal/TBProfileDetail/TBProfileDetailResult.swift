//
//	TBProfileDetailResult.swift
//
//	Create by iMac on 20/12/2023
//	Copyright © 2023. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TBProfileDetailResult : NSObject, NSCoding{

	var addresses : [TBProfileDetailAddresse]!
	var agreeTermsConditions : Int!
	var comment : String!
	var countryCode : Int!
	var createdAt : String!
	var email : String!
	var emailVerifiedAt : String!
	var id : Int!
	var isSocial : Int!
	var language : String!
	var mobileNumber : Int!
	var name : String!
	var profilePicture : String!
	var profilePictureUrl : String!
	var socialId : String!
	var status : Int!
	var updatedAt : String!
	var userType : Int!
    var is_show_credit : Int!

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
		addresses = [TBProfileDetailAddresse]()
		if let addressesArray = dictionary["addresses"] as? [NSDictionary]{
			for dic in addressesArray{
				let value = TBProfileDetailAddresse(fromDictionary: dic)
				addresses.append(value)
			}
		}
		agreeTermsConditions = dictionary["agree_terms_conditions"] as? Int == nil ? 0 : dictionary["agree_terms_conditions"] as? Int
		comment = dictionary["comment"] as? String == nil ? "" : dictionary["comment"] as? String
		countryCode = dictionary["country_code"] as? Int == nil ? 0 : dictionary["country_code"] as? Int
		createdAt = dictionary["created_at"] as? String == nil ? "" : dictionary["created_at"] as? String
		email = dictionary["email"] as? String == nil ? "" : dictionary["email"] as? String
		emailVerifiedAt = dictionary["email_verified_at"] as? String == nil ? "" : dictionary["email_verified_at"] as? String
		id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
		isSocial = dictionary["is_social"] as? Int == nil ? 0 : dictionary["is_social"] as? Int
		language = dictionary["language"] as? String == nil ? "" : dictionary["language"] as? String
		mobileNumber = dictionary["mobile_number"] as? Int == nil ? 0 : dictionary["mobile_number"] as? Int
		name = dictionary["name"] as? String == nil ? "" : dictionary["name"] as? String
		profilePicture = dictionary["profile_picture"] as? String == nil ? "" : dictionary["profile_picture"] as? String
		profilePictureUrl = dictionary["profile_picture_url"] as? String == nil ? "" : dictionary["profile_picture_url"] as? String
		socialId = dictionary["social_id"] as? String == nil ? "" : dictionary["social_id"] as? String
		status = dictionary["status"] as? Int == nil ? 0 : dictionary["status"] as? Int
		updatedAt = dictionary["updated_at"] as? String == nil ? "" : dictionary["updated_at"] as? String
        userType = dictionary["user_type"] as? Int == nil ? 0 : dictionary["user_type"] as? Int
        is_show_credit = dictionary["is_show_credit"] as? Int == nil ? 0 : dictionary["is_show_credit"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if addresses != nil{
			var dictionaryElements = [NSDictionary]()
			for addressesElement in addresses {
				dictionaryElements.append(addressesElement.toDictionary())
			}
			dictionary["addresses"] = dictionaryElements
		}
		if agreeTermsConditions != nil{
			dictionary["agree_terms_conditions"] = agreeTermsConditions
		}
		if comment != nil{
			dictionary["comment"] = comment
		}
		if countryCode != nil{
			dictionary["country_code"] = countryCode
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if email != nil{
			dictionary["email"] = email
		}
		if emailVerifiedAt != nil{
			dictionary["email_verified_at"] = emailVerifiedAt
		}
		if id != nil{
			dictionary["id"] = id
		}
		if isSocial != nil{
			dictionary["is_social"] = isSocial
		}
		if language != nil{
			dictionary["language"] = language
		}
		if mobileNumber != nil{
			dictionary["mobile_number"] = mobileNumber
		}
		if name != nil{
			dictionary["name"] = name
		}
		if profilePicture != nil{
			dictionary["profile_picture"] = profilePicture
		}
		if profilePictureUrl != nil{
			dictionary["profile_picture_url"] = profilePictureUrl
		}
		if socialId != nil{
			dictionary["social_id"] = socialId
		}
		if status != nil{
			dictionary["status"] = status
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt
		}
		if userType != nil{
			dictionary["user_type"] = userType
		}
        if is_show_credit != nil{
            dictionary["is_show_credit"] = is_show_credit
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         addresses = aDecoder.decodeObject(forKey: "addresses") as? [TBProfileDetailAddresse]
         agreeTermsConditions = aDecoder.decodeObject(forKey: "agree_terms_conditions") as? Int
         comment = aDecoder.decodeObject(forKey: "comment") as? String
         countryCode = aDecoder.decodeObject(forKey: "country_code") as? Int
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         email = aDecoder.decodeObject(forKey: "email") as? String
         emailVerifiedAt = aDecoder.decodeObject(forKey: "email_verified_at") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         isSocial = aDecoder.decodeObject(forKey: "is_social") as? Int
         language = aDecoder.decodeObject(forKey: "language") as? String
         mobileNumber = aDecoder.decodeObject(forKey: "mobile_number") as? Int
         name = aDecoder.decodeObject(forKey: "name") as? String
         profilePicture = aDecoder.decodeObject(forKey: "profile_picture") as? String
         profilePictureUrl = aDecoder.decodeObject(forKey: "profile_picture_url") as? String
         socialId = aDecoder.decodeObject(forKey: "social_id") as? String
         status = aDecoder.decodeObject(forKey: "status") as? Int
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         userType = aDecoder.decodeObject(forKey: "user_type") as? Int
        is_show_credit = aDecoder.decodeObject(forKey: "is_show_credit") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if addresses != nil{
			aCoder.encode(addresses, forKey: "addresses")
		}
		if agreeTermsConditions != nil{
			aCoder.encode(agreeTermsConditions, forKey: "agree_terms_conditions")
		}
		if comment != nil{
			aCoder.encode(comment, forKey: "comment")
		}
		if countryCode != nil{
			aCoder.encode(countryCode, forKey: "country_code")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if email != nil{
			aCoder.encode(email, forKey: "email")
		}
		if emailVerifiedAt != nil{
			aCoder.encode(emailVerifiedAt, forKey: "email_verified_at")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if isSocial != nil{
			aCoder.encode(isSocial, forKey: "is_social")
		}
		if language != nil{
			aCoder.encode(language, forKey: "language")
		}
		if mobileNumber != nil{
			aCoder.encode(mobileNumber, forKey: "mobile_number")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if profilePicture != nil{
			aCoder.encode(profilePicture, forKey: "profile_picture")
		}
		if profilePictureUrl != nil{
			aCoder.encode(profilePictureUrl, forKey: "profile_picture_url")
		}
		if socialId != nil{
			aCoder.encode(socialId, forKey: "social_id")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if userType != nil{
			aCoder.encode(userType, forKey: "user_type")
		}
        if is_show_credit != nil{
            aCoder.encode(is_show_credit, forKey: "is_show_credit")
        }

	}

}
