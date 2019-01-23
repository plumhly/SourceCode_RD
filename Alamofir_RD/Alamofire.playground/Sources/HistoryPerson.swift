//
//	HistoryPerson.swift
//
//	Create by plum on 23/1/2019
//	Copyright © 2019. All rights reserved.


import Foundation

public struct HistoryPerson {

    public var id : String!
    public var day : Int!
	public var des : String!
	public var lunar : String!
	public var month : Int!
	public var pic : String!
	public var title : String!
	public var year : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary: [String:Any]){
		id = dictionary["_id"] as? String
		day = dictionary["day"] as? Int
		des = dictionary["des"] as? String
		lunar = dictionary["lunar"] as? String
		month = dictionary["month"] as? Int
		pic = dictionary["pic"] as? String
		title = dictionary["title"] as? String
		year = dictionary["year"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	public  func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if id != nil{
			dictionary["_id"] = id
		}
		if day != nil{
			dictionary["day"] = day
		}
		if des != nil{
			dictionary["des"] = des
		}
		if lunar != nil{
			dictionary["lunar"] = lunar
		}
		if month != nil{
			dictionary["month"] = month
		}
		if pic != nil{
			dictionary["pic"] = pic
		}
		if title != nil{
			dictionary["title"] = title
		}
		if year != nil{
			dictionary["year"] = year
		}
		return dictionary
	}

}
