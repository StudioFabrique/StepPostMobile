import { Component, Input, OnInit, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'app-modal-two-buttons',
  templateUrl: './modal-two-buttons.component.html',
  styleUrls: ['./modal-two-buttons.component.scss'],
})
export class ModalTwoButtonsComponent implements OnInit {
  @Output() reponse = new EventEmitter<boolean>();
  @Input() etat!: string;

  constructor() {}

  ngOnInit() {}

  onCancel(): void {
    this.reponse.emit(false);
  }

  onConfirmer(): void {
    this.reponse.emit(true);
  }
}
