//
//  AuxiliarData.swift
//  Raiva
//
//  Created by Jesus Ortega on 29/03/25.
//

import Foundation

let communityData: Community = .init(
    communityName: "CholesEstudiantes",
    communityDescription: "Prueba de descripcion de comunidad",
    communityProfileImage: "logo",
    communityPortraitImage: "portraitImage",
    communityOwner: "OMVx_zLKidSzuepp_pr"
)


let userData: User = .init(userName: "Jesus Ortega A.", profilePicture: "raiva", etnia: EtniasEnum.chol.rawValue)

let forumData: Forum = .init(
    userID: "OMVx_zLKidSzuepp_pr",
    communityID: "OMVzlSyTMeiKDZ6pdGA",
    title: "Lorem ipsum dolor sit amet",
    body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    likes: 1,
    commentCount: 10000000
)
