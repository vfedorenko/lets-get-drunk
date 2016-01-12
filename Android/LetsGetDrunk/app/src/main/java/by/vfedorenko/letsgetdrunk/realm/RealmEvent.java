package by.vfedorenko.letsgetdrunk.realm;

import io.realm.RealmObject;
import io.realm.annotations.PrimaryKey;

public class RealmEvent extends RealmObject {
	@PrimaryKey
	private long id;
	private String title;
	private String description;
	private long lastUpdate;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public long getLastUpdate() {
		return lastUpdate;
	}

	public void setLastUpdate(long lastUpdate) {
		this.lastUpdate = lastUpdate;
	}
}
