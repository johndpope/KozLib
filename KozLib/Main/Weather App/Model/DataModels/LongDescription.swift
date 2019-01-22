//
//  LongDescription.swift
//  KozLibrary
//
//  Created by Haiyan Ma on 09/06/2017.
//  Copyright © 2017 Tsubame. All rights reserved.
//

import SwiftyJSON

struct WeatherLongDescription {
  let description: String?
  init(json: JSON) {
    self.description = json.stringValue
  }
}
