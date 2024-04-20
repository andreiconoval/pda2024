//
//  TeamParser.swift
//  teammate
//
//  Created by user256828 on 4/20/24.
//

import Foundation


class TeamParser: NSObject, XMLParserDelegate {
    
    var currentElement: String = ""
    var currentTeam: TeamItem?
    var teams: [TeamItem] = []
    
    // Function to parse XML data
    func parseXML(xmlData: Data) -> [TeamItem]? {
        let parser = XMLParser(data: xmlData)
        parser.delegate = self
        parser.parse()
        return teams
    }
    
    
    // Called when an opening tag is encountered
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if elementName == "teams" {
            currentTeam = TeamItem(id: "", name: "", shortName: "", tla: "", crest: "", address: "", website: "", founded: "", clubColors: "", venue: "", lastUpdated: "")
        }
    }
    
    func parseXML() -> [TeamItem]? {
        if let xmlURL = Bundle.main.url(forResource: "teams", withExtension: "xml"),
           let xmlData = try? Data(contentsOf: xmlURL) {
            let parser = XMLParser(data: xmlData)
            parser.delegate = self
            parser.parse()
            return teams
        }
        return nil
    }
    
    // Called when characters are found within an element
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let trimmedString = string.trimmingCharacters(in: .whitespacesAndNewlines)
        switch currentElement {
        case "id":
            currentTeam?.id += trimmedString
        case "name":
            currentTeam?.name += trimmedString
        case "shortName":
            currentTeam?.shortName += trimmedString
        case "tla":
            currentTeam?.tla += trimmedString
        case "crest":
            currentTeam?.crest += trimmedString
        case "address":
            currentTeam?.address += trimmedString
        case "website":
            currentTeam?.website += trimmedString
        case "founded":
            currentTeam?.founded += trimmedString
        case "clubColors":
            currentTeam?.clubColors += trimmedString
        case "venue":
            currentTeam?.venue += trimmedString
        case "lastUpdated":
            currentTeam?.lastUpdated += trimmedString
        default:
            break
        }
    }
    
    // Called when a closing tag is encountered
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "teams", let team = currentTeam {
            teams.append(team)
            currentTeam = nil
        }
        currentElement = ""
    }
    
    // Called when there's an error in parsing
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("XML Parse Error: \(parseError.localizedDescription)")
    }
}

