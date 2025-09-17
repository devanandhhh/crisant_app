
import 'package:crisant_app/presentation/bloc/theme_bloc/theme_bloc_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomThemeSwitch extends StatelessWidget {
  const CustomThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBlocCubit, bool>(
      builder: (context, isDarkMode) {
        return GestureDetector(
          onTap: () {
            context.read<ThemeBlocCubit>().toggleTheme();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 90,
            height: 40,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isDarkMode ? Colors.grey : const Color(0xFF292929),
            ),
            child: Stack(
              children: [
                AnimatedAlign(
                  duration: const Duration(milliseconds: 300),
                  alignment:
                      isDarkMode ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    child: Icon(
                      isDarkMode ? Icons.done : Icons.remove_circle_outline,
                      color: isDarkMode ? Colors.black : Colors.white,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    isDarkMode ? 'ON' : 'OFF',
                    style: TextStyle(
                      color: isDarkMode ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
