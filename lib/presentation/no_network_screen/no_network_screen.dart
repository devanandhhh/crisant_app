
import 'package:crisant_app/presentation/widgets/custom_app_bar.dart';
import 'package:crisant_app/presentation/widgets/custom_snakbar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../others/network_checker.dart';
import '../home_screen/home_screen.dart'; // adjust import path if needed

// ignore: must_be_immutable
class NoNetworkPage extends StatefulWidget {
   ConnectivityService connectivityService;
   NoNetworkPage({super.key, required this.connectivityService});

  @override
  State<NoNetworkPage> createState() => _NoNetworkPageState();
}

class _NoNetworkPageState extends State<NoNetworkPage> {
  late final ConnectivityService _connectivity;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _connectivity = widget.connectivityService;
    _isConnected = _connectivity.isConnected.value;

    // Listen for changes
    _connectivity.isConnected.addListener(_onConnectivityChanged);

    // If somehow we're already connected, immediately go back to Home
    if (_isConnected) {
      _goToHome();
    }
  }

  void _onConnectivityChanged() {
    final connected = _connectivity.isConnected.value;
    if (mounted) {
      setState(() => _isConnected = connected);
    }
    if (connected) {
      _goToHome();
    }
  }

  void _goToHome() {
    if (!mounted) return;
    // Replace the NoNetworkPage with HomeScreen and pass the same connectivityService
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (ctx) => HomeScreen(connectivityService: _connectivity),
      ),
    );
  }

  @override
  void dispose() {
    _connectivity.isConnected.removeListener(_onConnectivityChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(canPop: false ,onPopInvokedWithResult:(didPop, result) {
      
    } ,
      child: Scaffold(
        appBar: CustomAppBarWidget(title: 'Network Down',removeBackBtn: true,),
        // appBar: AppBar(automaticallyImplyLeading: false,
        //   title:  Text('Network Down',style: abeezeeStyle(fontSize: 25 ,),),
        // ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.signal_wifi_off, size: 80, color: Colors.red),
                const SizedBox(height: 16),
                const Text(
                  'No internet connection',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                 Gap(10),
                Text(
                  _isConnected ? 'Reconnected — redirecting…' : 'Please check your connection.',
                  textAlign: TextAlign.center,
                ),
                Gap(16),
                TextButton(
                  onPressed: () {
                    // Manual retry: check the service value and navigate if connected
                    if (_connectivity.isConnected.value) {
                      _goToHome();
                    } else {
                      showCustomSnackBar(
                        context,
                        'Still no connection. Please try again later.',Colors.blueGrey
                      );
                    }
                  },
                  child:  Text('Retry',style: abeezeeStyle(color: Colors.green[400]),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
