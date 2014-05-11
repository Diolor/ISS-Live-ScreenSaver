//
//  ISS_ScreensaverView.m
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

#import "ISS_ScreensaverView.h"

#import <WebKit/WebKit.h>

#define REFRESH_DISABLED 0
#define REFRESH_SECONDS 1
#define REFRESH_MINUTES 2
#define REFRESH_HOURS 3

@implementation ISS_ScreensaverView

static NSString * const ModuleName = @"diolor.ISS";

static NSString * const URL_KEY = @"URL";
static NSString * const REFRESH_INTERVAL_KEY = @"RefreshInterval";
static NSString * const REFRESH_UNITS_KEY = @"RefreshUnits";

static NSString * const DEFAULT_URL = @"http://www.ustream.tv/embed/17074538?v=3&wmode=direct&autoplay=true";
static double const DEFAULT_REFRESH_INTERVAL = 0;
static long const DEFAULT_REFRESH_UNITS = REFRESH_MINUTES;

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        refreshTimer = nil;
        
		defaults = [ScreenSaverDefaults defaultsForModuleWithName:ModuleName];
        
		[defaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:
									DEFAULT_URL, URL_KEY,
                                    [NSNumber numberWithDouble:DEFAULT_REFRESH_INTERVAL], REFRESH_INTERVAL_KEY,
                                    [NSNumber numberWithLong:DEFAULT_REFRESH_UNITS], REFRESH_UNITS_KEY,
									nil]];
        
		webView = [[WebView alloc] initWithFrame:[self bounds] frameName:nil groupName:nil];
        [webView setFrameLoadDelegate:self];
		[self addSubview:webView];
        
        [self loadWebView];
    }
    return self;
}

- (BOOL)hasConfigureSheet
{
	return NO;
}

- (NSString *)url
{
    return [defaults valueForKey: URL_KEY];
}
- (long)refreshUnits
{
    return [(NSNumber *)[defaults valueForKey:REFRESH_UNITS_KEY] longValue];
}
- (double)refreshInterval
{
    return [(NSNumber *)[defaults valueForKey:REFRESH_INTERVAL_KEY] doubleValue];
}



- (void)loadWebView
{
    
    
	[url setStringValue:[self url]];
	[refreshInterval setDoubleValue:[self refreshInterval]];
    [refreshUnits selectItemWithTag:[self refreshUnits]];
    
    [webView setMainFrameURL:[defaults valueForKey:URL_KEY]];
    
    if (refreshTimer)
    {
        [refreshTimer invalidate];
        refreshTimer = nil;
    }
    
}




@end

