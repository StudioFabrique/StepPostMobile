export interface InfosCourrier {
  id: number;
  bordereau: number;
  type: number;
  nom: string;
  prenom: string;
  civilite: string;
  adresse: string;
  complement?: any;
  codePostal: string;
  ville: string;
  etat: number;
  date: Date;
}
