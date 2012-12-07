//
//  BSGContatosNoMapaViewController.m
//  ContatosIP67
//
//  Created by ios3109 on 05/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BSGContatosNoMapaViewController.h"
#import <MapKit/MKUserTrackingBarButtonItem.h>
#import <MapKit/MKPinAnnotationView.h>
#import <MapKit/MKUserLocation.h>
#import "BSGContato.h"

@interface BSGContatosNoMapaViewController ()

@end

@implementation BSGContatosNoMapaViewController

@synthesize mapa = _mapa;

@synthesize contatos = _contatos;

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

-(void)viewWillAppear:(BOOL)animated {
    [self.mapa addAnnotations:self.contatos];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.mapa removeAnnotations:self.contatos];
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


-(MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString * ident = @"pino";
    MKPinAnnotationView *pino = (MKPinAnnotationView*)[self.mapa dequeueReusableAnnotationViewWithIdentifier: ident];
    
    if(!pino) {
        pino = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:ident]; 
    } else {
        pino.annotation = annotation;
    }
    
    BSGContato* contato = (BSGContato*) annotation;

    pino.pinColor = MKPinAnnotationColorRed;

    pino.canShowCallout = YES;

    if (contato.photo) {
        UIImageView *imagemContato = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
        imagemContato.image = contato.photo;
        pino.leftCalloutAccessoryView = imagemContato;
    }

    return pino;
    
}

@end
