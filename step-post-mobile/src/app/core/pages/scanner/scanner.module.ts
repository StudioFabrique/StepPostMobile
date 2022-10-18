import { QrcodeComponent } from '../../components/qrcode/qrcode.component';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { IonicModule } from '@ionic/angular';
import { ScannerPageRoutingModule } from './scanner-routing.module';
import { ScannerPage } from './scanner.page';
import { SaisieManuelleComponent } from '../../components/saisie-manuelle/saisie-manuelle.component';
import { SharedModule } from '../../../shared/shared.module';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    ScannerPageRoutingModule,
    SharedModule,
  ],
  declarations: [ScannerPage, SaisieManuelleComponent, QrcodeComponent],
})
export class ScannerPageModule {}
