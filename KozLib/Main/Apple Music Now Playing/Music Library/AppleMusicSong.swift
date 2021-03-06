//
//  AppleMusicSong.swift
//  KozLibrary
//
//  Created by Kelvin Kosbab on 1/24/19.
//  Copyright © 2019 Kozinga. All rights reserved.
//

import Foundation

struct AppleMusicSong {
  
  let id: UUID
  let title: String
  let duration: TimeInterval
  let artist: String
  let imageName: String?
  
  init(title: String, duration: TimeInterval, artist: String, imageName: String?) {
    self.id = UUID()
    self.title = title
    self.duration = duration
    self.artist = artist
    self.imageName = imageName
  }
}

extension AppleMusicSong : Hashable {
  
  var hashValue: Int {
    return id.hashValue
  }
  
  static func ==(lhs: AppleMusicSong, rhs: AppleMusicSong) -> Bool {
    return lhs.hashValue == rhs.hashValue
  }
}
