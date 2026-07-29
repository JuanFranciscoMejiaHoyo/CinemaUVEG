import { Routes } from '@angular/router';
import { MovieListComponent } from './componentes/movie-list/movie-list';
import { MovieDetailComponent } from './componentes/movie-detail/movie-detail';

export const routes: Routes = [
  { path: '', component: MovieListComponent },
  { path: 'movie/:id', component: MovieDetailComponent },
  { path: '**', redirectTo: '' }
];