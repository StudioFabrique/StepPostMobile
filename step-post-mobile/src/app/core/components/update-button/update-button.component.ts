import { InfosCourrier } from './../../models/infos-courrier.model';
import { Component, Input, OnInit, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'app-update-button',
  templateUrl: './update-button.component.html',
  styleUrls: ['./update-button.component.scss'],
})
export class UpdateButtonComponent implements OnInit {
  @Output() action = new EventEmitter<number>();
  @Input() etat!: any;

  constructor() {}

  ngOnInit() {}

  onUpdate(): void {
    console.log(this.etat);

    this.action.emit(this.etat.id);
  }
}
