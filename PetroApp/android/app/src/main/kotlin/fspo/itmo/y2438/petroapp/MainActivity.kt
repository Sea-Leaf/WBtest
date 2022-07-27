package fspo.itmo.y2438.petroapp

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("756b44e9-a2e9-4b0c-b08f-84aa06cf94bb") // Your generated API key
        super.configureFlutterEngine(flutterEngine)
    }
}