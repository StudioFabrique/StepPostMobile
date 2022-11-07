import { ScanComponent } from '../../../shared/components/scan/scan.component';
import { SharedModule } from '../../../shared/shared.module';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular';

import { MesScansPageRoutingModule } from './mes-scans-routing.module';

import { MesScansPage } from './mes-scans.page';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    MesScansPageRoutingModule,
    SharedModule,
  ],
  declarations: [MesScansPage],
})
export class MesScansPageModule {}
