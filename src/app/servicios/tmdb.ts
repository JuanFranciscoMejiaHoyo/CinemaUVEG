import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { TmdbResponse, Movie } from '../models/movie';

@Injectable({
  providedIn: 'root'
})
export class TmdbService {
  private baseUrl = 'https://api.themoviedb.org/3';
  
  // Pega tu token de Postman aquí
  private token = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5MDlkZmNhOWUwYTMxOWEzOGYyYzI0MjBiODMwMzdmNSIsIm5iZiI6MTc4NTI5MjQwMi4zNDUsInN1YiI6IjZhNjk2NjcyNGUxN2E1ODhmNjI0MDJiYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GNXB2Bv3Bo5tDamGzu53CJzpyvh5mwwaXDQgr8H2mYI';

  constructor(private http: HttpClient) {}

  // Construimos la cabecera obligatoria
  private getHeaders(): HttpHeaders {
    return new HttpHeaders({
      'Authorization': `Bearer ${this.token}`, // <-- ¡OJO AQUÍ! Lleva 'Bearer ' antes del token
      'accept': 'application/json'
    });
  }

  getTopRatedMovies(): Observable<TmdbResponse> {
    return this.http.get<TmdbResponse>(
      `${this.baseUrl}/movie/top_rated?language=es-MX&page=1`,
      { headers: this.getHeaders() }
    );
  }

  getMovieDetails(id: number): Observable<Movie> {
    return this.http.get<Movie>(
      `${this.baseUrl}/movie/${id}?language=es-MX`,
      { headers: this.getHeaders() }
    );
  }
}