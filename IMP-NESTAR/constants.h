//
//  constants.h
//  IMP-NESTAR
//
//  Created by Julian Vogels on 2/4/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#ifndef IMP_NESTAR_constants_h
#define IMP_NESTAR_constants_h

#define kIMPbaseURL @"http://imp-nestar.com/"
//#define kIMPrequestURL @"http://julianvogels.de/IMP/media_item_request2.php"
//#define kIMPrequestURL @"http://posttestserver.com/post.php?dir=IMP"
#define kIMPrequestURL @"http://imp-nestar.com/data/request-scan.php"

//#define kIMPexperimentsURL @"https://maps.googleapis.com/maps/api/place/textsearch/json?query=clubs+in+berlin&sensor=false&key=AIzaSyBXeSbcBfJHHoVZJom7VGF_paR4LSy2_oI"

//#define kIMPexperimentsURL @"http://www.julianvogels.de/IMP/imp.json"
#define kIMPexperimentsURL @"http://imp-nestar.com/data/request-experiments.php"

//#define kIMPuploadURL @"http://posttestserver.com/post.php?dir=IMP"
#define kIMPuploadURL @"http://imp-nestar.com/data/request-results.php"


// DEBUG TEST SERVER (for uploads)
//#define kIMPbaseURL @"http://posttestserver.com/"
//#define kIMPrequestURL @"post.php?dir=IMP"

// Help URLs

#define kIMPhelpGeneralURL @"http://www.example.com"
#define kIMPhelpBugsURL @"http://www.example.com"
#define kIMPhelpInvestigatorURL @"http://www.example.com"
#define kIMPhelpScannerURL @"http://www.example.com"
#define kIMPhelpAboutURL @"http://www.example.com"
#define kIMPhelpContactURL @"http://www.example.com"

#define kIMPvisualisationURL @"http://www.example.com"

#define IS_WIDESCREEN ( fabs( ( double )[[UIScreen mainScreen] bounds].size.height - ( double )568 ) < DLB_EPSILON )

#endif

typedef NS_ENUM(NSUInteger, MediaType) {
    image,
    audio,
    video
};
