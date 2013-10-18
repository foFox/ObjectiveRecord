//
//  NSManagedObjectContext+Background.h
//  Pods
//
//  Created by Robert Lis on 18/10/2013.
//
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (Background)
//Perform Core Data work in the background, background context is passed in, to the block.
//Background context & main context are saved for you automatically.
//Usage restictions :
//  Do not use any other context inside the block, that was not created inside that block.
//  Do not pass existing NSManagedObjects directly to the block, but rather use ObjectID's & backgroundContext to do so.
//  When creating/dealing with NSManagedObjects use the 'inContext:' method variants and pass backgroundContext. (VERY IMPORTANT).
//  Do not call this method from anyother thread than main thread.

+(void)performInBackground:(void(^)(NSManagedObjectContext *backgroundContext))job;
@end
