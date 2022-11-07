import { ScanComponent } from './components/scan/scan.component';
import { ModalTwoButtonsComponent } from './components/modal-two-buttons/modal-two-buttons.component';
import { CardCourrierComponent } from './components/card-courrier/card-courrier.component';
import { FabComponent } from './components/fab/fab.component';
import { IonicModule } from '@ionic/angular';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule } from '@angular/forms';

@NgModule({
  declarations: [
    CardCourrierComponent,
    FabComponent,
    ModalTwoButtonsComponent,
    ScanComponent,
  ],
  imports: [CommonModule, IonicModule.forRoot(), ReactiveFormsModule],
  exports: [
    ReactiveFormsModule,
    CardCourrierComponent,
    FabComponent,
    ModalTwoButtonsComponent,
    ScanComponent,
  ],
})
export class SharedModule {}
