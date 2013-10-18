//
//  NSManagedObjectContext+Background.m
//  Pods
//
//  Created by Robert Lis on 18/10/2013.
//
//

#import "NSManagedObjectContext+Background.h"
#import "CoreDataManager.h"

@implementation NSManagedObjectContext (Background)

+(void)performInBackground:(void(^)(NSManagedObjectContext *backgroundContext))job
{
    NSAssert([NSThread isMainThread], @"Method should only be called from the main thread!", nil);
    NSManagedObjectContext *mainContext = [[CoreDataManager sharedManager] managedObjectContext];
    NSManagedObjectContext *backgroundContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    backgroundContext.parentContext = mainContext;
    [backgroundContext performBlock:^{
        if(job) job(backgroundContext);
        NSError *backgroundError;
        [backgroundContext save:&backgroundError];
        if(backgroundError)
        {
            NSLog(@"Error saving background context %@", backgroundError);
        }
        
        [mainContext performBlock:^{
            NSError *mainContextError;
            [mainContext save:&mainContextError];
            if(mainContextError)
            {
                NSLog(@"Error saving main context %@", mainContextError);
            }
        }];
    }];
}

@end
