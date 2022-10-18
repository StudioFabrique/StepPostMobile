import { Courrier } from 'src/app/core/models/courrier.model';

export interface MesScans {
  date: Date;
  statutId: number;
  courrier: Courrier;
}
