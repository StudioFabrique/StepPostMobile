import { QRScanner, QRScannerStatus } from '@ionic-native/qr-scanner/ngx';
import {
  Component,
  OnInit,
  Output,
  EventEmitter,
  OnDestroy,
} from '@angular/core';

@Component({
  selector: 'app-qrcode',
  templateUrl: './qrcode.component.html',
  styleUrls: ['./qrcode.component.scss'],
})
export class QrcodeComponent implements OnDestroy, OnInit {
  @Output() resultat = new EventEmitter<string>();
  result!: string;

  constructor(private qrScanner: QRScanner) {}

  ngOnDestroy(): void {
    this.qrScanner.destroy();
  }

  ngOnInit(): void {
    this.scancode();
  }

  scancode() {
    // Optionally request the permission early
    this.qrScanner
      .prepare()
      .then((status: QRScannerStatus) => {
        if (status.authorized) {
          // camera permission was granted

          // start scanning
          this.qrScanner.show();
          const scanSub = this.qrScanner.scan().subscribe((text: string) => {
            this.result = text;
            this.qrScanner.hide(); // hide camera preview
            scanSub.unsubscribe(); // stop scanning
            this.resultat.emit(this.result);
          });
        } else if (status.denied) {
          // camera permission was permanently denied
          // you must use QRScanner.openSettings() method to guide the user to the settings page
          // then they can grant the permission from there
        } else {
          // permission was denied, but not permanently. You can ask for permission again at a later time.
        }
      })
      .catch((e: any) => console.log('Error is', e));
  }
}
