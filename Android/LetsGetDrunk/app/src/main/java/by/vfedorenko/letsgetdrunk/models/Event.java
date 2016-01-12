package by.vfedorenko.letsgetdrunk.models;

import android.util.Log;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import by.vfedorenko.letsgetdrunk.realm.RealmEvent;

public class Event {
	@Expose(serialize = false)
	public long id;

	public String title;
	public String description;

	@SerializedName("updated_at")
	@Expose(serialize = false)
	public String lastUpdate;

	public static Event fromRealm(RealmEvent realmEvent) {
		Event event = new Event();
		event.id = realmEvent.getId();
		event.title = realmEvent.getTitle();
		event.description = realmEvent.getDescription();

		return event;
	}

	public RealmEvent toRealm() {
		RealmEvent event = new RealmEvent();
		event.setId(id);
		event.setTitle(title);
		event.setDescription(description);
		event.setLastUpdate(getLastUpdateInMillis());

		return event;
	}

	public long getLastUpdateInMillis() {
		SimpleDateFormat lastUpdateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale.getDefault());
		try {
			Date date = lastUpdateFormat.parse(lastUpdate);
			return date.getTime();
		} catch (ParseException e) {
			Log.e(Event.class.getName(), "Failed to parse last update("+lastUpdate+"):", e);
			return 0;
		}
	}
}
