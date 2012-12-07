//
//  BSGContatosNoMapaViewController.h
//  ContatosIP67
//
//  Created by ios3109 on 05/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MKMapView.h>

@interface BSGContatosNoMapaViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapa;

@property (nonatomic, weak) NSMutableArray *contatos;

@end
