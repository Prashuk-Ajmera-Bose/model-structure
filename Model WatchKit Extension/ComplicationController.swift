//
//  ComplicationController.swift
//  Model WatchKit Extension
//
//  Created by Prashuk Ajmera on 8/29/19.
//  Copyright © 2019 Prashuk Ajmera. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // Sample data
    let timeLineText = ["1st Hour", "2nd Hour"]
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        let currentDate = NSDate()
        handler(currentDate as Date)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        let currentDate = NSDate()
        let endDate = currentDate.addingTimeInterval(TimeInterval(2 * 60 * 60))
        handler(endDate as Date)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry
        if complication.family == .modularLarge {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm"
            let timeString = dateFormatter.string(from: NSDate() as Date)
            let entry = createTimeLineEntry(headerText: timeString, bodyText: timeLineText[0], date: NSDate())
            handler(entry)
        } else {
            handler(nil)
        }
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        var timeLineEntryArray = [CLKComplicationTimelineEntry]()
        var nextDate = NSDate(timeIntervalSinceNow: 1 * 60 * 60)

        for index in 1...1 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm"
            let timeString = dateFormatter.string(from: nextDate as Date)
            let entry = createTimeLineEntry(headerText: timeString, bodyText: timeLineText[index], date: nextDate)
            timeLineEntryArray.append(entry)
            nextDate = nextDate.addingTimeInterval(1 * 60 * 60)
        }
        handler(timeLineEntryArray)
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        let template = CLKComplicationTemplateModularLargeStandardBody()
        let beerGlass = UIImage(named: "beer_glass")
        template.headerImageProvider = CLKImageProvider(onePieceImage: beerGlass!)
        template.headerTextProvider = CLKSimpleTextProvider(text: "Sample Header")
        template.body1TextProvider = CLKSimpleTextProvider(text: "Sample Body")
        handler(nil)
    }
    
    func createTimeLineEntry(headerText: String, bodyText: String, date: NSDate) -> CLKComplicationTimelineEntry {
        let template = CLKComplicationTemplateModularLargeStandardBody()
        let beerGlass = UIImage(named: "beer_glass")
        template.headerImageProvider = CLKImageProvider(onePieceImage: beerGlass!)
        template.headerTextProvider = CLKSimpleTextProvider(text: headerText)
        template.body1TextProvider = CLKSimpleTextProvider(text: bodyText)
        let entry = CLKComplicationTimelineEntry(date: date as Date, complicationTemplate: template)
        return(entry)
    }
    
}
