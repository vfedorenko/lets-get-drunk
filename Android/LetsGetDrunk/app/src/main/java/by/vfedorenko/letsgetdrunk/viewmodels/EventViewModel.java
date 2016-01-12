package by.vfedorenko.letsgetdrunk.viewmodels;

import android.content.Context;
import android.text.Editable;
import android.util.Log;
import android.view.View;

import by.vfedorenko.letsgetdrunk.CustomApplication;
import by.vfedorenko.letsgetdrunk.activities.EventActivity;
import by.vfedorenko.letsgetdrunk.models.Event;
import by.vfedorenko.letsgetdrunk.realm.RealmEvent;
import by.vfedorenko.letsgetdrunk.webapi.EventsApi;
import io.realm.Realm;

public class EventViewModel {
	private RealmEvent event;
	private EventActivity.LaunchType type;

	public EventViewModel(RealmEvent event) {
		this.event = event;
	}

	public EventViewModel(RealmEvent event, EventActivity.LaunchType type) {
		this.type = type;
		this.event = event;
	}

	public String getTitle() {
		return event.getTitle();
	}

	public String getDescription() {
		return event.getDescription();
	}

	public boolean isEdit() {
		return type == EventActivity.LaunchType.EDIT;
	}

	public void onEventClick(View v) {
		Context context = v.getContext();
		context.startActivity(EventActivity.createIntent(context, EventActivity.LaunchType.EDIT, event.getId()));
	}

	public boolean onEventLongClick(View v) {
		Log.d("111", "long click");
		return true;
	}

	public void onTitleChanged(Editable str) {
		Realm realm = Realm.getDefaultInstance();

		realm.beginTransaction();
		event.setTitle(str.toString());
		realm.commitTransaction();
	}

	public void onDescriptionChanged(Editable str) {
		event.setDescription(str.toString());
	}

	public void onCreateUpdateClick(final View v) {
		EventsApi api = CustomApplication.getRetrofit().create(EventsApi.class);

		if (type == EventActivity.LaunchType.EDIT) {
			api.updateEvent(event.getId(), Event.fromRealm(event));
		} else {
			api.createEvent(Event.fromRealm(event));
		}
	}
}
