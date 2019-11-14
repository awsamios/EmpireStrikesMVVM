//
//  json.swift
//  EmpireStrikesMVVMTests
//
//  Created by Samira CHALAL on 30/10/2019.
//  Copyright © 2019 ACME. All rights reserved.
//

import Foundation
let json = """
[
   {
      "id":1,
      "pilot":{
         "name":"Dark Vador",
         "avatar":"/static/dark-vador.png",
         "rating":5
      },
      "distance":{
         "value":2478572,
         "unit":"km"
      },
      "duration":19427000,
      "pick_up":{
         "name":"Yavin 4",
         "picture":"/static/yavin-4.png",
         "date":"2017-12-09T14:12:51Z"
      },
      "drop_off":{
         "name":"",
         "picture":"",
         "date":"2017-12-09T19:35:51Z"
      }
   },
   {
      "id":2,
      "pilot":{
         "name":"Admiral Ackbar",
         "avatar":"/static/admiral-ackbar.png",
         "rating":0
      },
      "drop_off":{
         "name":"Coruscant",
         "picture":"/static/coruscant.png",
         "date":"2017-12-09T19:35:51Z"
      },
      "pick_up":{
         "name":"Naboo",
         "picture":"/static/naboo.png",
         "date":"2017-12-09T19:35:51Z"
      },
      "distance":{
         "value":24785727853,
         "unit":"km"
      },
      "duration":19427000
   }
]
""".data(using: .utf8)
