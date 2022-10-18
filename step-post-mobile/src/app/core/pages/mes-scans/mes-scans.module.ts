import { ScanComponent } from './../../components/scan/scan.component';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular';

import { MesScansPageRoutingModule } from './mes-scans-routing.module';

import { MesScansPage } from './mes-scans.page';

@NgModule({
  imports: [CommonModule, FormsModule, IonicModule, MesScansPageRoutingModule],
  declarations: [MesScansPage, ScanComponent],
})
export class MesScansPageModule {}
