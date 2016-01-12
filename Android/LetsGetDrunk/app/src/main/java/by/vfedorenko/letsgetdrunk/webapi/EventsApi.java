package by.vfedorenko.letsgetdrunk.webapi;

import java.util.List;

import by.vfedorenko.letsgetdrunk.models.Event;
import retrofit.http.Body;
import retrofit.http.DELETE;
import retrofit.http.GET;
import retrofit.http.Headers;
import retrofit.http.POST;
import retrofit.http.PUT;
import retrofit.http.Path;
import rx.Observable;

public interface EventsApi {
	@GET("/api/events")
	Observable<List<Event>> getEvents();

	@Headers("Content-Type:application/json")
	@POST("/api/events")
	Observable<Event> createEvent(@Body Event event);

	@Headers("Content-Type:application/json")
	@PUT("/api/events/{event_id}")
	Observable<Event> updateEvent(@Path("event_id") long eventId, @Body Event event);

	@DELETE("/api/events/{event_id}")
	Observable deleteEvent(@Path("event_id") long eventId);
}
