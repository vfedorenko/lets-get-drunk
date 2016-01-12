package by.vfedorenko.letsgetdrunk.adapters;

import android.databinding.DataBindingUtil;
import android.databinding.ViewDataBinding;
import android.support.v4.util.SimpleArrayMap;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import java.util.List;

import by.vfedorenko.letsgetdrunk.BR;
import by.vfedorenko.letsgetdrunk.R;
import by.vfedorenko.letsgetdrunk.databinding.ItemEventBinding;
import by.vfedorenko.letsgetdrunk.realm.RealmEvent;
import by.vfedorenko.letsgetdrunk.viewmodels.EventViewModel;

public class EventsAdapter extends RecyclerView.Adapter<EventsAdapter.BindingHolder> {
	public class BindingHolder extends RecyclerView.ViewHolder {
		private ItemEventBinding binding;

		public BindingHolder(View rowView) {
			super(rowView);
			binding = DataBindingUtil.bind(rowView);
		}

		public ViewDataBinding getBinding() {
			return binding;
		}
	}

	private SimpleArrayMap<Long, RealmEvent> events = new SimpleArrayMap<>();

	public EventsAdapter(List<RealmEvent> data) {
		for (RealmEvent event: data) {
			events.put(event.getId(), event);
		}
	}

	@Override
	public BindingHolder onCreateViewHolder(ViewGroup parent, int viewType) {
		View v = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_event, parent, false);
		return new BindingHolder(v);
	}

	@Override
	public void onBindViewHolder(BindingHolder holder, int position) {
		RealmEvent event = events.valueAt(position);

//		OnOperationClickListener listener = new OnOperationClickListener() {
//			@Override
//			public void onOperationClick(long date) {
//				if (mTwoPane) {
//					getFragmentManager().beginTransaction()
//							.replace(R.id.operation_detail_container, OperationDetailFragment.buildFragment(date))
//							.commit();
//				} else {
//					startActivity(OperationDetailActivity.buildIntent(getActivity(), date));
//				}
//			}
//		};

		holder.getBinding().setVariable(BR.event, new EventViewModel(event));
		holder.getBinding().executePendingBindings();
	}

	@Override
	public int getItemCount() {
		return events.size();
	}

	public void updateEvent(RealmEvent event) {
		long eventId = event.getId();
		if (events.containsKey(eventId)) {
			int index = events.indexOfKey(eventId);

			events.setValueAt(index, event);
			notifyItemChanged(index);
		}
	}

	public void addEvent(RealmEvent event) {
		events.put(event.getId(), event);
		notifyItemInserted(events.indexOfKey(event.getId()));
	}
}
