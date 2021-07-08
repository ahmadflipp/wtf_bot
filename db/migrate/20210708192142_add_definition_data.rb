require 'csv'

class AddDefinitionData < ActiveRecord::Migration[6.1]
  CSV_STRING = <<~CSV
    Name,Definition
    Boomerang,Administrative Terms/Processes
    Confluence,Administrative Terms/Processes
    Evergreen,Budget that renews every month (typically on the performance network)
    Flyer Admin (Fadmin),Flyer Administration; ops system that houses all the flyer content we have. It is also the system our operations team uses to process flyers
    Genesis,Our Content production platform that allows us to automatically curate digital-first content for our partners.
    Iron Sharpens Iron (ISI),"Team sessions that are held to bring up any recurring issues with retailers, share new knowledge about the platform/UX experience, and train the team on objection handling."
    JIRA,"Interface used for creative inquiries, growth media inquiries and legal inquiries"
    Key Performance Indicators (KPI),Metrics used by retailers in order to deem a project successful
    Lighthouse Team,Flipp Exec Team + John Rebello
    Marketplace,Interface used by Finance to track budgets for retail flyer runs
    Merchant Admin (Madmin),Internal system that shows what merchants (retailers) are invoiced & billed for
    Merchant Partners,Retailers and CPG
    OGSM,"Objective, Goals, Strategy and Measure - Our guiding light"
    Omni Channel,
    Salesforce,"Interface used to track financial opportunities, key contacts and movement with our retailers. Salesforce is also used for analytics requests"
    User Experience (UX),"One of the core elements of the Flipp platform, the user experience is how a user interacts with the platform. In the Flipp platform, the User Experience is informed by personalization and dynamic content."
    # of Interactions,Count of Unique Engagements with a particular item.
    Always on,The retailer has provided Flipp with enough budget to never be in organic and always in premium
    Circular,"""Flyer"" in USA"
    Closing date,The date when the budget is booked.
    Cookie,A small text file on the user’s PC that identifies the user’s browser (and hence the user) so they’re ‘recognised’ when they re-visit a site. A cookie allows usernames to be stored and websites to personalise their offering.
    Custom Tiles,Type of store tile that can be customized. Typically on the retailer to create this and provide to Flipp atleast 5 business days before publication launch
    Customers,"Trick question! The retailers we work with are our partners, not customers."
    Dwell time,Time spent on the same page viewing an item(s).
    Fixed Rate,"Standard rate that Flipp charges per UEV; $0.29 for US, $0.31 for Canada"
    Flipp Rank,Retailer Bid x Quality Score x Personalization score
    FONO,Flipp Owned and Operated (consumer side)
    Hosted,Retailer's .com website
    In the Dark,Another way to say organic placement
    Indexing,Scraping content off retailer's website so that we can process content and transfer onto the Flipp Marketplace
    Marketplace,Flipp App + Native Media Network
    Noise,The amount of sales lift Flipp needs to generate to be meaningful to a retailer
    Organic,Unpaid section of Flipp. All flyer content will always be available on Flipp in the organic section 
    Premium,Content that is promoted on Flipp and is in the best position for the retailer (paid promotion)
    Rich item,"Item with rich content - example: User Reviews, Ratings, Related Items"
    STEP,Storefront Enterprise Platform (retailer side)
    Stock tiles,Type of store tile that has a templated design that content will fit into in standardized manner. Flipp automates this for the retailer and takes care of all heavy lifting here
    Store Tiles,"The first image shopper's see on the digital storefront for a retailer. Store tiles can be one of 3: Stock Premium Tiles, Custom Premium Tiles or Organic Tiles. These are the tiles that shoppers see on the homescreen or when they are browsing for content"
    Storefront,The digital identity of a retailer on the Flipp marketplace
    Waterfall,"When retailer is not always on, and Flipp app is prioritized first, with residual budget flowing into native and then Growth Media"
    Flipp App,Flipp's own O&O App. Growing at a rate of 300% YoY and run at the same pricing model as Native Media. 
    Growth Media,"Bridges the gap from Performance Network, Growth Media provides additional reach (Google, Facebook and Twitter)"
    Hosted,"Retailers owned and operated website, Flipp hosts their experience on their own sites, adding functionality and dynamic content."
    Native Network,Flyers are posted on multiple media partner websites until the engagements are hit.
    Performance Network,Both the Flipp App and the Native Network - this is the hardest working platform.
    Insertion Order (IO),"When an IO is signed by the retailer/agency, we need to make sure that the legal terms are in order. For our standard agreement, IOs are not necessary but some retailers and agencies require IOs for every media buys."
    Master Services Agreement (MSA),To be signed after the NDA. 
    Non-Disclosure Agreement (NDA),"To be signed prior to sending any decks etc to any retailer, ensures that all content is kept confidential."
    Attributed ROAS,"""Attributed Return on Ad Spend"" - ratio of sales/ budget - What was the retailer's return on budget spent?"
    Average Time on Flyer,Total time spent on flyer/# of sessions (seconds)
    Click (Flipp),"A consumer clicks on a flyer, but may not spend 6 seconds on it"
    Click Through Rate (CTR),The percentage of those clicking on a link from those to whom the link was displayed.
    Clicks,Clicks
    CPM,Cost Per Thousand Impressions —> (Investment/Number of Impressions)*1000
    Dark Week,Weeks when retailers have not created weekly circulars because they have already leveraged their print budgets.
    Data Management Platform (DMP),Provides data that is coming from the campaign
    DLX - Datalogix,DLX is an online to offline measurement company. They can match an online cookie. Can track everything online to a store purchase.
    eCPM,Effective CPM
    Engaged Visits,The number of users that interacted with the flyer (based on unique guaranteed read): Either by browsing for at least 6 seconds or interacting with the flyer
    Flyer ID,Flyer Run ID with a specific pricing zone
    Flyer Run ID,Specific timed publication 
    Flyer Type ID,Type of flyer -> weekly ads or seasonal ads
    Geofence,Area mapped around a retailers' store location to track in-store visits. 
    Heat Map,An image that can show a retailer how consumers are interacting with their flyer based on how often they view an item
    Impression,The number of times the flyer was visible to a user.
    Interaction Score,"Interaction Score is derived from the level of engagement with the product on the flyer. There is an algorithm that determines the interaction score based on a number of different factors including: how many times that item was clicked on, how many times it was added to a shopping list, how many times a consumer clicked on it and then shared it to Facebook/Twitter, etc. etc."
    Online Attribution,Online sales attributed to flyer readership (typically a 14-day window)
    Opens,The number of times the flyer was opened by a user.
    Quality Score,"Determines how engaged a user is, using indicators like click-thru rate, dwell time, and # of interactions."
    Shopping List Adds,An interaction when a user clips an item or adds an item to their shopping list from the flyer
    Store Trips,Number of times consumers both viewed a flyer and went to the  retailer's store within the publication date. The shopper must have also stayed within the store for a min of 7-10mins in store
    Transaction Logs (T-logs),Provided by the retailer. T-log data is all the purchases/transactions logged in store.
    Transfer to Merchant (TTM),Transfer to Merchant counts the number of times a user was redirected to the retailer’s site from the flyer (IE: when someone clicks on a banner that leads them to sign up for a loyalty program on site)
    Unique Guaranteed Read,"A consumer is on the flyer for 6 seconds or more, or takes a strong action that shows intent such as clicking on an item"
    View Score,"View Score is a relative index that allows us to gauge how much a product was looked at vs. other products in the publication. The view score should not be looked at as an indicator of the number of people that saw the product overall, as it is a relative index based on other products in the flyer. Things that will increase a view score are consumers zooming in on products, or having the product in the middle of their screen."
    Views, Count of how many users have viewed an item
    Ad Exchange,An ad exchange is a technology platform that facilitates the buying and selling of media advertising inventory from multiple ad networks. Prices for the inventory are determined through bidding.
    Big Box Ad,"A big box ad unit, aka medium rectangle, is one of standard creative ad units defined in IAB guidelines.The big box ad unit has a size of 300X 250 pixels in his classic form and 600 x 250 when expandable."
    Demand Side Platform (DSP),"A demand-side platform (DSP) is a piece of the technology puzzle that fits into the larger real-time bidding (RTB) ecosystem. Specifically, a DSP enables advertisers to purchase display ad inventory via RTB exchanges. The most well-known DSPs are: MediaMath; Turn; Invite Media; and, x+1."
    Leaderboard Ad,A Leaderboard Ad is a wide rectangular advertising space that measures 728-pixels-wide by 90-pixels-high (728×90) that can be seen at the top of website pages. It is the first ad seen on a page.
    Pixeling,A methodology to track ads. Retailers give flipp a small digital footprint (1x1pixels) to integrate onto a flyer to track when it is viewed.
    Real Time Bidding (RTB),Real-time auction for digital advertising space (ex. on Facebook/Twitter).
    Retargeting,"Behavioral retargeting (also known as behavioral remarketing, or simply, retargeting) is a form of online targeted advertising by which online advertising is targeted to consumers based on their previous Internet actions, in situations where these actions did not result in a sale or conversion."
    Search Advertising,"In Internet Marketing, Search Advertising is a method of placing online advertisements on web pages that show results from search engine queries. Through the same search-engine advertising services, ads can also be placed on Web pages with other published."
    Skyscraper Ad,"A skyscraper ad is a tall and narrow banner advertisement usually placed to the right of content on a Web page. Standard dimensions for a skyscraper ad are 160 X 600 pixels. Like another popular type of Internet ad, the leaderboard, the skyscraper offers an advertiser a large space for a message."
    Supply Side Platform (SSP),A supply-side platform or sell-side platform (SSP) is a technology platform with the single mission of enabling publishers to manage theiradvertising impression inventory and maximize revenue from digital media.
    Brand Marketing,"More CPG Leverage. Brand Marketing is more holistic (ex. TV ads) messaging that has an overall message about the brand. 
    Ex. Dove for Men makes you a Manlier Man"
    CPG,"Consumer Packaged Goods. CPGs are consumable goods such as food and beverages, footwear and apparel, tobacco, and cleaning products. In general, CPGs are things that get used up and have to be replaced frequently, in contrast to items that people usually keep for a long time"
    End-caps,The end of a grocery store aisle display
    QSR,Quick Service Restaurants
    Shopper Marketing,"Small, disappearing. Any type of marketing geared towards a specific type of shopper. Not related to price and promo (unlike trade marketing) Ex. What’s for Dinner Campaign? By Knorr (targeting the “on the go mother”)"
    Trade Marketing,More retailer leverage. Vendors are trading dollars for flyer space and real estate in the retailers' stores.
    API,Data pipe that feeds data from one place to another
    Auto-Stacking,Internal program/tool that moves flyers from horizontal scroll to vertical. Flyers can be automatically stacked vertically so they can fit better in a mobile experience and viewscreen
    Box-Drawing,Boxes that are drawn around products in a flyer
    Electronic Free Standing Insert (EFSI),Genesis (more things to distribute)
    Free Standing Insert (FSI),An FSI means different things to different retailers. Could mean an insert into one of their flyers (also on digital).
    M1000 Process,Midmarket retailers that have 20 stores or less are put on a automated processing tool. There are limitations to it because the item pops are not quality checked as in other processes.
    OKO,Operations Kick-Off - typically the first meeting between the retailer and the Flipp operations team to set up process. 
    Slicing,Technique for redesigning flyers to eliminate whitespace and make a better digital experience. Print flyer files are enhanced to make images more digital/mobile friendly
    Engagement Rates,"Measurement based on clicks, shares and likes on social media. "
    Growth Media Ads (GMA),Reaching the same size and scale as print through our relationships with Google and Facebook.
    # of Interactions,Count of Unique Engagements with a particular item.
    Always on,The retailer has provided Flipp with enough budget to never be in organic and always in premium
    Circular,"Flyer in USA"
    Closing date,The date when the budget is booked.
    Cookie,A small text file on the user’s PC that identifies the user’s browser (and hence the user) so they’re ‘recognised’ when they re-visit a site. A cookie allows usernames to be stored and websites to personalise their offering.
    Custom Tiles,Type of store tile that can be customized. Typically on the retailer to create this and provide to Flipp atleast 5 business days before publication launch
    Customers,"Trick question! The retailers we work with are our partners, not customers."
    Dwell time,Time spent on the same page viewing an item(s).
    Fixed Rate,"Standard rate that Flipp charges per UEV; $0.29 for US, $0.31 for Canada"
    Flipp Rank,Retailer Bid x Quality Score x Personalization score
    FONO,Flipp Owned and Operated (consumer side)
    Hosted,Retailer's .com website
    In the Dark,Another way to say organic placement
    Indexing,Scraping content off retailer's website so that we can process content and transfer onto the Flipp Marketplace
    Marketplace,Flipp App + Native Media Network
    Noise,The amount of sales lift Flipp needs to generate to be meaningful to a retailer
    Organic,Unpaid section of Flipp. All flyer content will always be available on Flipp in the organic section 
    Premium,Content that is promoted on Flipp and is in the best position for the retailer (paid promotion)
    Rich item,"Item with rich content - example: User Reviews, Ratings, Related Items"
    STEP,Storefront Enterprise Platform (retailer side)
    Stock tiles,Type of store tile that has a templated design that content will fit into in standardized manner. Flipp automates this for the retailer and takes care of all heavy lifting here
    Store Tiles,"The first image shopper's see on the digital storefront for a retailer. Store tiles can be one of 3: Stock Premium Tiles, Custom Premium Tiles or Organic Tiles. These are the tiles that shoppers see on the homescreen or when they are browsing for content"
    Storefront,The digital identity of a retailer on the Flipp marketplace
    Waterfall,"When retailer is not always on, and Flipp app is prioritized first, with residual budget flowing into native and then Growth Media"
    CPC,Cost Per Click
    Flyer ID,More Granular than Weekly
    Flyer Run ID,Weekly
    GDPR,(P&G Email)
    Masthead,Allows retailers to purchase a tile at the top of stack for a 24 hour period which means it will remain for 24 hours regardless of a user’s personalization. 
    MMM,Mixed Media Model
    MVVM,Model View ViewModel
    O&O,Owned & Operated (Walgreens)
    PII,Personally identifiable information
    Pixelling,
    RRRs,"Respect, Relationship, Results"
    SLA,Service Level Agreement
    UEV,Unique Engaged Visits
    PUEV, Premium Unique Engaged Visits
    EV, Engaged Visits
  CSV

  def change
    CSV.parse(CSV_STRING, :headers => true, :skip_blanks => true) do |row|
      name = row['Name']
      definition = row['Definition']

      next unless definition.present? && name.present?

      WtfEntry.create!(word: name.strip, description: definition.strip, author: 'system')
    end
  end
end
