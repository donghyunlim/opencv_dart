import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/size.dart';
import '../opencv.g.dart' as cvg;

class CLAHE extends CvStruct<cvg.CLAHE> {
  CLAHE._(cvg.CLAHEPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory CLAHE.fromNative(cvg.CLAHEPtr ptr) => CLAHE._(ptr);
  factory CLAHE.empty() {
    final p = calloc<cvg.CLAHE>();
    CFFI.CLAHE_Create(p);
    return CLAHE._(p);
  }

  /// NewCLAHE returns a new CLAHE algorithm
  ///
  /// For further details, please see:
  /// https:///docs.opencv.org/master/d6/db6/classcv_1_1CLAHE.html
  factory CLAHE([double clipLimit = 40, (int width, int height) tileGridSize = (8, 8)]) {
    final p = calloc<cvg.CLAHE>();
    final size = calloc<cvg.Size>()
      ..ref.width = tileGridSize.$1
      ..ref.height = tileGridSize.$2;
    CFFI.CLAHE_CreateWithParams(clipLimit, size.ref, p);
    calloc.free(size);
    return CLAHE._(p);
  }

  /// Apply CLAHE.
  ///
  /// For further details, please see:
  /// https:///docs.opencv.org/master/d6/db6/classcv_1_1CLAHE.html#a4e92e0e427de21be8d1fae8dcd862c5e
  Mat apply(Mat src, {Mat? dst}) {
    dst ??= Mat.empty();
    cvRun(() => CFFI.CLAHE_Apply(ref, src.ref, dst!.ref));
    return dst;
  }

  double get clipLimit {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => CFFI.CLAHE_GetClipLimit(ref, p));
      return p.value;
    });
  }

  set clipLimit(double value) {
    cvRun(() => CFFI.CLAHE_SetClipLimit(ref, value));
  }

  Size get tilesGridSize {
    return cvRunArena<Size>((arena) {
      final p = arena<cvg.Size>();
      cvRun(() => CFFI.CLAHE_GetTilesGridSize(ref, p));
      return (p.ref.width, p.ref.height);
    });
  }

  set tilesGridSize(Size value) {
    cvRunArena((arena) {
      final p = arena<cvg.Size>()
        ..ref.width = value.$1
        ..ref.height = value.$2;
      cvRun(() => CFFI.CLAHE_SetTilesGridSize(ref, p.ref));
    });
  }

  static final finalizer = OcvFinalizer<cvg.CLAHEPtr>(CFFI.addresses.CLAHE_Close);

  void dispose() {
    finalizer.detach(this);
    CFFI.CLAHE_Close(ptr);
  }

  @override
  List<int> get props => [ptr.address];
  @override
  cvg.CLAHE get ref => ptr.ref;
}
