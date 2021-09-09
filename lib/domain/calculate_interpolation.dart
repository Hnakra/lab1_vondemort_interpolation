import 'package:vondemort_interpolation/data/models/dot.dart';

class CalculateInterpolation{
  static calculate(double x, List<Dot> list){
    print(list);
    print (x);
    double sum = 0;
    int n = list.length;
    for(int i = 0; i < n; i++){
      double p = 1;
      for(int j = 0; j < n; j++) {
        if( j != i) {
          p *=(x-list[j].x)/(list[i].x-list[j].x);
        }
      }
      sum += p * list[i].y;
    }

    return sum;
  }
}
