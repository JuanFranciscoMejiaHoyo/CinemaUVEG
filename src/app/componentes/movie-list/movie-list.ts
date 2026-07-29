import { Component, OnInit, inject, signal } from '@angular/core';
import { RouterLink } from '@angular/router';
import { TmdbService } from '../../servicios/tmdb';
import { Movie } from '../../models/movie';

@Component({
  selector: 'app-movie-list',
  standalone: true,
  imports: [RouterLink],
  templateUrl: './movie-list.html',
  styleUrls: ['./movie-list.css']
})
export class MovieListComponent implements OnInit {
  private tmdbService = inject(TmdbService);
  
  // Usamos un Signal para que Angular zoneless reaccione al cambio
  movies = signal<Movie[]>([]);

  ngOnInit(): void {
    this.tmdbService.getTopRatedMovies().subscribe({
      next: (response: any) => {
        this.movies.set(response.results); // Actualizamos el Signal
      },
      error: (err) => console.error('Error al traer películas', err)
    });
  }
}