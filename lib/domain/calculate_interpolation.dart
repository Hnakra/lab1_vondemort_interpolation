import 'package:vondemort_interpolation/data/models/dot.dart';

class CalculateInterpolation{
  static calculate(double t, List<Dot> list){
    double z = 0;
    double p1;
    double p2;
    int n = list.length;
    for(int j = 0; j < n; j++){
      p1 = 1;
      p2 = 1;
      for(int i = 0; i < n; i++){
        if(i != j){
          p1 = p1*(t-list[i].x);
          p2 = p2*(list[j].x - list[i].x);
        }
      }
      z = z+ list[j].y*p1/p2;
    }
    return z;
  }
}
