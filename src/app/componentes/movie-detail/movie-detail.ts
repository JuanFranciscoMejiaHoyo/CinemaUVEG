import { Component, OnInit, inject, signal } from '@angular/core';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { TmdbService } from '../../servicios/tmdb';
import { Movie } from '../../models/movie';

@Component({
  selector: 'app-movie-detail',
  standalone: true,
  imports: [RouterLink],
  templateUrl: './movie-detail.html',
  styleUrls: ['./movie-detail.css']
})
export class MovieDetailComponent implements OnInit {
  private route = inject(ActivatedRoute);
  private tmdbService = inject(TmdbService);

  // Signal para refrescar la vista
  movie = signal<Movie | null>(null);

  ngOnInit(): void {
    const id = Number(this.route.snapshot.paramMap.get('id'));
    if (id) {
      this.tmdbService.getMovieDetails(id).subscribe({
        next: (data) => this.movie.set(data),
        error: (err) => console.error('Error cargando detalle', err)
      });
    }
  }
}