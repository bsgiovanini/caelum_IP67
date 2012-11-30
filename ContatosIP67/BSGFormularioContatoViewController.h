//
//  BSGFormularioContatoViewController.h
//  ContatosIP67
//
//  Created by ios3109 on 28/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSGFormularioContatoViewController : UIViewController

@property (strong) NSMutableArray* contatos;

@property (weak) IBOutlet UITextField* txtNome;

@property (weak) IBOutlet UITextField* txtTel;

@property (weak) IBOutlet UITextField* txtEmail;

@property (weak) IBOutlet UITextField* txtEnd;

@property (weak) IBOutlet UITextField* txtSite;

- (IBAction) cadastraContato: (id)sender; 

- (IBAction) proximoElemento: (UITextField*)sender; 

@end
