import { SignatureComponent } from './../../components/signature/signature.component';
import { UpdateStatutComponent } from './../../components/update-statut/update-statut.component';
import { UpdateButtonComponent } from './../../components/update-button/update-button.component';
import { ResultatRechercheComponent } from './../../components/resultat-recherche/resultat-recherche.component';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { IonicModule } from '@ionic/angular';
import { LastScanPageRoutingModule } from './last-scan-routing.module';
import { LastScanPage } from './last-scan.page';

@NgModule({
  imports: [CommonModule, FormsModule, IonicModule, LastScanPageRoutingModule],
  declarations: [
    LastScanPage,
    ResultatRechercheComponent,
    UpdateButtonComponent,
    UpdateStatutComponent,
    SignatureComponent,
  ],
})
export class LastScanPageModule {}
