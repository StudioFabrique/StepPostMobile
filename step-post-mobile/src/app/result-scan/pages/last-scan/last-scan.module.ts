import { UpdateButtonComponent } from '../../components/update-button/update-button.component';
import { SignatureComponent } from '../../components/signature/signature.component';
import { SharedModule } from './../../../shared/shared.module';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { IonicModule } from '@ionic/angular';
import { LastScanPageRoutingModule } from './last-scan-routing.module';
import { LastScanPage } from './last-scan.page';
import { ResultatRechercheComponent } from '../../components/resultat-recherche/resultat-recherche.component';
import { UpdateStatutComponent } from '../../components/update-statut/update-statut.component';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    LastScanPageRoutingModule,
    SharedModule,
  ],
  declarations: [
    LastScanPage,
    ResultatRechercheComponent,
    UpdateButtonComponent,
    UpdateStatutComponent,
    SignatureComponent,
  ],
})
export class LastScanPageModule {}
