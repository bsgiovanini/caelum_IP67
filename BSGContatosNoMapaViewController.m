//
//  BSGContatosNoMapaViewController.m
//  ContatosIP67
//
//  Created by ios3109 on 05/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BSGContatosNoMapaViewController.h"
#import <MapKit/MKUserTrackingBarButtonItem.h>

@interface BSGContatosNoMapaViewController ()

@end

@implementation BSGContatosNoMapaViewController

@synthesize mapa = _mapa;

- (id)init {
    
    self = [super init];
    
    if (self) {
        
    
        UIImage * imageTabItem = [UIImage imageNamed:@"mapa-contatos.png"];
    
        UITabBarItem * tabItem = [[UITabBarItem alloc] initWithTitle:@"Mapa" image:imageTabItem tag:0];
    
        self.tabBarItem = tabItem;
        
        self.navigationItem.title = @"Localização";
    }
    
    return self;
    

}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MKUserTrackingBarButtonItem * botaoLocalizacao = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapa];
    self.navigationItem.leftBarButtonItem = botaoLocalizacao;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
