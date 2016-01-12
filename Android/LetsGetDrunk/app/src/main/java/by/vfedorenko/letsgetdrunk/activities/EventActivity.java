package by.vfedorenko.letsgetdrunk.activities;

import android.content.Context;
import android.content.Intent;
import android.databinding.DataBindingUtil;
import android.os.Bundle;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.view.MenuItem;

import by.vfedorenko.letsgetdrunk.R;
import by.vfedorenko.letsgetdrunk.databinding.ActivityEventBinding;
import by.vfedorenko.letsgetdrunk.realm.RealmEvent;
import by.vfedorenko.letsgetdrunk.viewmodels.EventViewModel;
import io.realm.Realm;

public class EventActivity extends AppCompatActivity {
	public enum LaunchType {
		CREATE, EDIT
	}

	private static final String EXTRA_LAUNCH_TYPE = "launch_type";
	private static final String EXTRA_EVENT_ID = "event_id";

	public static Intent createIntent(Context context, LaunchType type, long eventId) {
		Intent i = new Intent(context, EventActivity.class);
		i.putExtra(EXTRA_LAUNCH_TYPE, type);
		i.putExtra(EXTRA_EVENT_ID, eventId);
		return i;
	}

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		ActionBar actionBar = getSupportActionBar();
		if (actionBar != null) {
			actionBar.setDisplayHomeAsUpEnabled(true);
		}

		LaunchType type = (LaunchType) getIntent().getSerializableExtra(EXTRA_LAUNCH_TYPE);
		long eventId = getIntent().getLongExtra(EXTRA_EVENT_ID, 0);

		RealmEvent event = new RealmEvent();

		if (type == LaunchType.EDIT) {
			event = Realm.getDefaultInstance().where(RealmEvent.class).equalTo("id", eventId).findFirst();
		}

		ActivityEventBinding binding = DataBindingUtil.setContentView(this, R.layout.activity_event);
		EventViewModel viewModel = new EventViewModel(event, type);
		binding.setEvent(viewModel);
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		// Handle action bar item clicks here. The action bar will
		// automatically handle clicks on the Home/Up button, so long
		// as you specify a parent activity in AndroidManifest.xml.
		int id = item.getItemId();

		//noinspection SimplifiableIfStatement
		if (id == android.R.id.home) {
			finish();
			return true;
		}

		return super.onOptionsItemSelected(item);
	}
}
