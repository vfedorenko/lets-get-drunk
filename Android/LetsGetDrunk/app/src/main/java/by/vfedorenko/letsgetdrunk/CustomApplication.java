package by.vfedorenko.letsgetdrunk;

import android.app.Application;

import io.realm.Realm;
import io.realm.RealmConfiguration;
import retrofit.GsonConverterFactory;
import retrofit.Retrofit;
import retrofit.RxJavaCallAdapterFactory;

public class CustomApplication extends Application {
	private static final String API_URL = "http://192.168.3.64:3000";

	private static Retrofit retrofit;

	@Override
	public void onCreate() {
		super.onCreate();

		RealmConfiguration config = new RealmConfiguration.Builder(this)
				.deleteRealmIfMigrationNeeded().build();
		Realm.setDefaultConfiguration(config);

		retrofit = new Retrofit.Builder()
				.baseUrl(API_URL)
				.addConverterFactory(GsonConverterFactory.create())
				.addCallAdapterFactory(RxJavaCallAdapterFactory.create())
				.build();
	}

	public static Retrofit getRetrofit() {
		return retrofit;
	}
}
