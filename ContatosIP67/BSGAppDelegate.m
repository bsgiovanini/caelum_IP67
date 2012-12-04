//
//  BSGAppDelegate.m
//  ContatosIP67
//
//  Created by ios3109 on 28/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BSGAppDelegate.h"
#import "BSGFormularioContatoViewController.h"
#import "BSGListaContatosViewController.h"

@implementation BSGAppDelegate

@synthesize window = _window;

@synthesize contatos = _contatos;

@synthesize arquivoContato = _arquivoContato;

- (id)init {
    
    self = [super init];
    
    NSArray * ud = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString * dd = [ud objectAtIndex: 0];
    
    self.arquivoContato = [NSString stringWithFormat:@"%@/Contatos",dd];
    
    return self;
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
   
    
    NSLog(@"%@", self.arquivoContato);
    self.contatos = [NSKeyedUnarchiver unarchiveObjectWithFile: self.arquivoContato];
    if (!self.contatos) {
         self.contatos = [[NSMutableArray alloc] init];
    }
    
    
    BSGListaContatosViewController * lista = [[BSGListaContatosViewController alloc] init];
    
    lista.contatos = self.contatos;
    
    UINavigationController * nav = [[UINavigationController alloc ] initWithRootViewController:lista];
    
    //BSGFormularioContatoViewController * form = [[BSGFormularioContatoViewController alloc] init];
    
    [self.window setRootViewController:nav];
    
    NSLog(@"lauchOptions %@", launchOptions);
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor grayColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}



- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    
    NSLog(self.arquivoContato);
    
    [NSKeyedArchiver archiveRootObject:self.contatos toFile:self.arquivoContato];
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
