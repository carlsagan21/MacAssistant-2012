//
//  AlternativeStadiumSaver.h
//  FM10SX
//
//  Created by Amy Kettlewell on 09/12/23.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AlternativeStadium.h"

@interface AlternativeStadiumSaver : NSObject {

}

+ (void)saveStadium:(AlternativeStadium *)object toData:(NSMutableData *)data;

@end
