//
//  ISS_ScreensaverView.h
//  ISS Screensaver
//
//  Created by Dionysis Lorentzos on 11/5/14.
//  Copyright (c) 2014 Dionysis Lorentzos. All rights reserved.
//
//
//  Library contains code based on the following authors:
//
//  Created by Thomas Robinson on 10/13/09.
//  Modified by Pekka Nikander in May 2012.
//  Copyright (c) 2013, Thomas Robinson. All rights reserved.
//  Copyright (c) 2012, Senseg.  All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>
#import <WebKit/WebKit.h>

@interface ISS_ScreensaverView  : ScreenSaverView
{
    
	IBOutlet NSTextField *url;
	IBOutlet NSTextView *userScript;
	IBOutlet NSTextField *refreshInterval;
	IBOutlet NSPopUpButton *refreshUnits;
    
    ScreenSaverDefaults *defaults;
	WebView *webView;
    NSTimer *refreshTimer;
}

- (void)loadWebView;


@end
