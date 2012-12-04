//
//  BSGFormularioContatoViewController.h
//  ContatosIP67
//
//  Created by ios3109 on 28/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSGContato.h"
#import "BSGListaContatosProtocol.h"

@interface BSGFormularioContatoViewController : UIViewController

@property (strong) BSGContato* contato;


@property (weak) IBOutlet UITextField* txtNome;

@property (weak) IBOutlet UITextField* txtTel;

@property (weak) IBOutlet UITextField* txtEmail;

@property (weak) IBOutlet UITextField* txtEnd;

@property (weak) IBOutlet UITextField* txtSite;


@property (weak) id<BSGListaContatosProtocol> delegate;

- (void) cadastraContato; 

- (IBAction) proximoElemento: (UITextField*)sender; 

- (void) escondeFormulario;

- (id) initWithContato: (BSGContato*) _contato;

@end
