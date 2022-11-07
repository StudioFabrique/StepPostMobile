import { SharedModule } from './../../../shared/shared.module';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular';

import { RecherchePageRoutingModule } from './recherche-routing.module';

import { RecherchePage } from './recherche.page';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    RecherchePageRoutingModule,
    SharedModule,
  ],
  declarations: [RecherchePage],
})
export class RecherchePageModule {}
