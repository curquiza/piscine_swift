//
//  Model.swift
//  death-note
//
//  Created by Clementine URQUIZAR on 3/8/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import Foundation

struct Note {
    var name: String
    var date: Date
    var description: String
}

struct Data {
    static let deathNotes: [Note] = [
        Note(name: "Coco", date: Date(), description: "en codant du PHP"),
        Note(name: "Titi", date: Date(), description: "en codant du JS"),
        Note(name: "Tutu", date: Date(), description: "en codant du Swift. Swift est un langage de programmation objet compilé, multi-paradigmes ayant pour objectif d'être simple, haute-performance et sûr, il est développé en open source.\nLe projet de développement de Swift est géré par Apple qui en est également le principal contributeur mais de nombreux membres de la communauté Swift ainsi que d'autres acteurs tels que Google et IBM participent activement à son développement. Swift est officiellement supporté sur les systèmes d'exploitation Linux Ubuntu, iOS, macOS, watchOS et tvOS. Un support non officiel (géré par la communauté) existe sur d'autres plateformes Linux telles que Debian et Fedora.\nUn manuel officiel en anglais est disponible en ligne3.\nSwift dispose d'une interopérabilité avec le langage C ainsi qu'avec l'Objective-C sur les plateformes d'Apple.\nLe compilateur de Swift utilise LLVM pour la génération du code machine."),
    ]
}
