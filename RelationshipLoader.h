//
//  RelationshipLoader.h
//  FM10SX
//
//  Created by Amy Kettlewell on 09/11/14.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Relationship.h"

@interface RelationshipLoader : NSObject {

}

+ (Relationship *)readFromData:(NSData *)data atOffset:(unsigned int *)byteOffset;

@end
