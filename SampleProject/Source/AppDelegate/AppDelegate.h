//
//  AppDelegate.h
//  SampleProject
//
//  Created by Gorilla Expense on 8/25/17.
//  Copyright © 2017 Gorilla Expense. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;
- (NSManagedObjectContext*)managedObjectContext;

@end

