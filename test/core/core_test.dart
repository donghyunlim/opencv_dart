// ignore_for_file: avoid_print

import 'package:opencv_dart/opencv_dart.dart' as cv;
import 'package:test/test.dart';

void main() async {
  test('openCvVersion', () {
    final version = cv.openCvVersion();
    print(version);
    expect(version.length, greaterThan(0));
  });

  test('cv.getBuildInformation', () {
    final info = cv.getBuildInformation();
    print(info);
    expect(info.length, greaterThan(0));
  });

  test('cv.AsyncArray', () {
    final arr = cv.AsyncArray.empty();
    expect(arr.ptr, isNotNull);
  });

  test('cv.absDiff', () {
    final mat0 = cv.Mat.ones(100, 100, cv.MatType.CV_8UC3);
    final mat1 = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC3);
    final dst = cv.Mat.empty();
    cv.absDiff(mat0, mat1, dst);
    expect(dst.at<int>(0, 0, 0), equals(1));
  });

  test('cv.Add', () {
    final mat0 = cv.Mat.ones(100, 100, cv.MatType.CV_8UC3);
    final mat1 = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC3);
    final dst = cv.Mat.empty();
    cv.add(mat0, mat1, dst);
    expect(dst.at<int>(0, 0, 0), equals(1));
  });

  test('cv.addWeighted', () {
    final mat0 = cv.Mat.ones(100, 100, cv.MatType.CV_8UC3).setTo(cv.Scalar.all(100));
    final mat1 = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC3).setTo(cv.Scalar.all(50));
    final dst = cv.addWeighted(mat0, 0.5, mat1, 0.5, 1);
    expect(dst.at<int>(0, 0, 0), equals(75 + 1));
  });

  test('cv.bitwise_and', () {
    final mat0 = cv.Mat.ones(100, 100, cv.MatType.CV_8UC3).setTo(cv.Scalar.all(100));
    final mat1 = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC3).setTo(cv.Scalar.all(50));
    final dst = cv.bitwiseAND(mat0, mat1);
    expect(dst.at<int>(0, 0, 0), equals(100 & 50));
  });

  test('cv.bitwise_not', () {
    final mat0 = cv.Mat.ones(100, 100, cv.MatType.CV_8UC3).setTo(cv.Scalar.all(100));
    final dst = cv.bitwiseNOT(mat0);
    expect(dst.at<int>(0, 0, 0), equals(155));
  });

  test('cv.bitwise_or', () {
    final mat0 = cv.Mat.ones(100, 100, cv.MatType.CV_8UC3).setTo(cv.Scalar.all(100));
    final mat1 = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC3).setTo(cv.Scalar.all(50));
    final dst = cv.bitwiseOR(mat0, mat1);
    expect(dst.at<int>(0, 0, 0), equals(100 | 50));
  });

  test('cv.bitwise_xor', () {
    final mat0 = cv.Mat.ones(100, 100, cv.MatType.CV_8UC3).setTo(cv.Scalar.all(100));
    final mat1 = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC3).setTo(cv.Scalar.all(50));
    final dst = cv.bitwiseXOR(mat0, mat1);
    expect(dst.at<int>(0, 0, 0), equals(100 ^ 50));
  });

  test('cv.batchDistance', () {
    final mat0 = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC1);
    final mat1 = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC1);
    final mask = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC1);
    final (dist, _) = cv.batchDistance(mat0, mat1, -1, K: 15, mask: mask);
    expect(dist.isEmpty, equals(false));
  });

  test('cv.borderInterpolate', () {
    final n = cv.borderInterpolate(1, 5, cv.BORDER_DEFAULT);
    expect(n != 0, equals(true));
  });

  test('cv.calcCovarMatrix', () {
    final samples = cv.Mat.zeros(10, 10, cv.MatType.CV_32FC1);
    final mean = cv.Mat.empty();
    final (covar, _) = cv.calcCovarMatrix(samples, mean, cv.COVAR_ROWS);
    expect(covar.isEmpty, equals(false));
  });

  test('cv.cartToPolar', () {
    final x = cv.Mat.zeros(100, 100, cv.MatType.CV_32FC1);
    final y = cv.Mat.zeros(100, 100, cv.MatType.CV_32FC1);
    final (magnitude, angle) = cv.cartToPolar(x, y, angleInDegrees: false);
    expect(magnitude.isEmpty || angle.isEmpty, equals(false));
  });

  test('cv.checkRange', () {
    final mat1 = cv.Mat.zeros(101, 102, cv.MatType.CV_8UC1);
    final (success, pos) = cv.checkRange(mat1);
    expect(success, equals(true));
    expect(pos, equals(cv.Point(0, 0)));
  });

  test('cv.compare', () {
    final mat1 = cv.Mat.zeros(101, 102, cv.MatType.CV_8UC1);
    final mat2 = cv.Mat.zeros(101, 102, cv.MatType.CV_8UC1);
    final dst = cv.compare(mat1, mat2, cv.CMP_EQ);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.countNonZero', () {
    final mat1 = cv.Mat.ones(101, 102, cv.MatType.CV_8UC1);
    final n = cv.countNonZero(mat1);
    expect(n, equals(101 * 102));
  });

  test('cv.completeSymm', () {
    final mat1 = cv.Mat.randn(100, 100, cv.MatType.CV_32FC1);
    cv.completeSymm(mat1);
    expect(mat1.at<double>(99, 0), equals(mat1.at<double>(0, 99)));
  });

  test("cv.convertScaleAbs", () {
    final src = cv.Mat.create(cols: 100, rows: 100, type: cv.MatType.CV_32FC1);
    final dst = cv.convertScaleAbs(src, alpha: 1, beta: 0);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.copyMakeBorder', () {
    final src = cv.Mat.randn(100, 100, cv.MatType.CV_32FC1);
    final dst = cv.copyMakeBorder(src, 10, 10, 10, 10, cv.BORDER_REFLECT, value: cv.Scalar.all(0));
    expect(dst.isEmpty, equals(false));
  });

  test('cv.dct', () {
    final src = cv.Mat.randn(100, 100, cv.MatType.CV_32FC1);
    final dst = cv.dct(src);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.determinant', () {
    final src = cv.Mat.zeros(101, 101, cv.MatType.CV_32FC1);
    final ret = cv.determinant(src);
    expect(ret, equals(0));
  });

  test('cv.dft', () {
    final src = cv.Mat.randn(101, 102, cv.MatType.CV_32FC1);
    final m = cv.getOptimalDFTSize(101);
    final n = cv.getOptimalDFTSize(102);
    expect(m, equals(108));
    expect(n, equals(108));
    final dst = cv.dft(src);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.divide', () {
    final mat1 = cv.Mat.ones(101, 102, cv.MatType.CV_32FC1);
    final mat2 = cv.Mat.ones(101, 102, cv.MatType.CV_32FC1);
    final dst = cv.divide(mat1, mat2);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.eigen', () {
    final src = cv.Mat.randn(10, 10, cv.MatType.CV_32FC1);
    final eigenValues = cv.Mat.empty();
    final eigenVectors = cv.Mat.empty();
    cv.eigen(src, eigenvalues: eigenValues, eigenvectors: eigenVectors);
    expect(eigenValues.isEmpty || eigenVectors.isEmpty, equals(false));
  });

  test('cv.eigenNonSymmetric', () {
    final src = cv.Mat.randn(10, 10, cv.MatType.CV_32FC1);
    final eigenValues = cv.Mat.empty();
    final eigenVectors = cv.Mat.empty();
    cv.eigenNonSymmetric(src, eigenvalues: eigenValues, eigenvectors: eigenVectors);
    expect(eigenValues.isEmpty || eigenVectors.isEmpty, equals(false));
  });

  test('cv.PCACompute', () {
    final src = cv.Mat.randn(10, 10, cv.MatType.CV_32FC1);
    final mean = cv.Mat.empty();
    final eigenvectors = cv.Mat.empty();
    final eigenvalues = cv.Mat.empty();
    cv.PCACompute(
      src,
      mean,
      eigenvalues: eigenvalues,
      eigenvectors: eigenvectors,
      maxComponents: 2,
    );
    expect(mean.isEmpty || eigenvectors.isEmpty || eigenvalues.isEmpty, equals(false));
    expect(eigenvectors.rows, equals(2));
  });

  test('cv.exp', () {
    final src = cv.Mat.zeros(10, 10, cv.MatType.CV_32FC1);
    final dst = cv.exp(src);
    expect(dst.isEmpty, equals(false));
    expect(dst.at<double>(0, 0), equals(1));
  });

  test('cv.extractChannel', () {
    final src = cv.Mat.randn(10, 10, cv.MatType.CV_32FC3);
    final dst = cv.extractChannel(src, 2);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.findNonZero', () {
    final src = cv.Mat.randu(10, 10, cv.MatType.CV_8UC1);
    final dst = cv.findNonZero(src);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.flip', () {
    final src = cv.Mat.randu(10, 10, cv.MatType.CV_8UC1);
    final dst = cv.flip(src, 0);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.gemm', () {
    final src1 = cv.Mat.randu(3, 4, cv.MatType.CV_32FC1);
    final src2 = cv.Mat.randu(4, 3, cv.MatType.CV_32FC1);
    final src3 = cv.Mat.empty();
    final dst = cv.gemm(src1, src2, 1, src3, 0);
    expect(dst.isEmpty, equals(false));
    expect(dst.rows, equals(src1.rows));
  });

  test('cv.hconcat', () {
    final src = cv.Mat.zeros(10, 10, cv.MatType.CV_32FC1);
    final dst = cv.hconcat(src, src);
    expect(dst.isEmpty, equals(false));
    expect(dst.cols, equals(src.cols * 2));
  });

  test('cv.vconcat', () {
    final src = cv.Mat.zeros(10, 10, cv.MatType.CV_32FC1);
    final dst = cv.vconcat(src, src);
    expect(dst.isEmpty, equals(false));
    expect(dst.rows, equals(src.rows * 2));
  });

  test('cv.rotate', () {
    final src = cv.Mat.zeros(10, 20, cv.MatType.CV_8UC1);
    final dst = cv.rotate(src, cv.ROTATE_90_CLOCKWISE);
    expect(dst.isEmpty, equals(false));
    expect((dst.rows, dst.cols), (src.cols, src.rows));
  });

  test('cv.idct', () {
    final src = cv.Mat.randu(4, 4, cv.MatType.CV_32FC1);
    final dst = cv.idct(src);
    expect(dst.isEmpty, equals(false));
    expect(dst.rows, equals(src.rows));
  });

  test('cv.idft', () {
    final src = cv.Mat.randu(4, 4, cv.MatType.CV_32FC1);
    final dst = cv.idft(src);
    expect(dst.isEmpty, equals(false));
    expect(dst.rows, equals(src.rows));
  });

  test('cv.inRange', () {
    final mat1 = cv.Mat.randu(101, 102, cv.MatType.CV_8UC1);
    final lb = cv.Mat.fromScalar(1, 1, cv.MatType.CV_8UC1, cv.Scalar(20, 100, 100, 0));
    final ub = cv.Mat.fromScalar(1, 1, cv.MatType.CV_8UC1, cv.Scalar(20, 100, 100, 0));
    final dst = cv.inRange(mat1, lb, ub);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.inRangebyScalar', () {
    final mat1 = cv.Mat.randu(101, 102, cv.MatType.CV_8UC1);
    final lb = cv.Scalar(20, 100, 100, 0);
    final ub = cv.Scalar(20, 100, 100, 0);
    final dst = cv.inRangebyScalar(mat1, lb, ub);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.insertChannel', () {
    final src = cv.Mat.randu(4, 4, cv.MatType.CV_8UC1);
    final dst = cv.Mat.randu(4, 4, cv.MatType.CV_8UC3);
    cv.insertChannel(src, dst, 1);
    expect(dst.channels, equals(3));
  });

  test('cv.invert', () {
    final src = cv.Mat.randu(4, 4, cv.MatType.CV_32FC1);
    final (_, dst) = cv.invert(src);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.kmeans', () {
    final src = cv.Mat.randu(4, 4, cv.MatType.CV_32FC1);
    final bestLabels = cv.Mat.empty();
    const criteria = (cv.TERM_COUNT, 10, 1.0);
    final (_, _, centers) = cv.kmeans(src, 2, bestLabels, criteria, 2, cv.KMEANS_RANDOM_CENTERS);
    expect(centers.isEmpty, equals(false));
  });

  test('cv.kmeansByPoints', () {
    final src = <cv.Point2f>[cv.Point2f(0, 0), cv.Point2f(1, 1)].cvd;
    final bestLabels = cv.Mat.empty();
    const criteria = (cv.TERM_COUNT, 10, 1.0);
    final (_, _, centers) = cv.kmeansByPoints(src, 2, bestLabels, criteria, 2, cv.KMEANS_RANDOM_CENTERS);
    expect(centers.isEmpty, equals(false));
  });

  test('cv.log', () {
    final src = cv.Mat.randu(4, 3, cv.MatType.CV_32FC1);
    final dst = cv.log(src);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.LUT', () {
    void testOneLUT(cv.Mat src, cv.Mat lut) {
      expect(lut.channels == src.channels || lut.channels == 1, true);
      expect(lut.isContinus, true);
      final sw = Stopwatch();
      sw.start();
      final dst = cv.LUT(src, lut);
      sw.stop();
      // print('${src.type} -> ${lut.type}(${src.rows}x${src.cols}): ${sw.elapsedMilliseconds}ms');
      expect(dst.isEmpty, false);
      expect(src.shape, dst.shape);
    }

    final depthSrc = [cv.MatType.CV_8U, cv.MatType.CV_8S, cv.MatType.CV_16U, cv.MatType.CV_16S];
    final depthLut = [
      cv.MatType.CV_8U,
      cv.MatType.CV_8S,
      cv.MatType.CV_16U,
      cv.MatType.CV_16S,
      cv.MatType.CV_32S,
      cv.MatType.CV_32F,
      cv.MatType.CV_64F,
    ];
    for (final int channel in [1, 2, 3, 4]) {
      for (final depth in depthSrc) {
        final srcType = cv.MatType.makeType(depth, channel);
        final src = cv.Mat.randu(3, 3, srcType, low: cv.Scalar.all(0), high: cv.Scalar.all(255));
        final lutSize = switch (depth) {
          cv.MatType.CV_8U || cv.MatType.CV_8S => 256,
          cv.MatType.CV_16U || cv.MatType.CV_16S => 65536,
          _ => throw Exception("Unsupported type"),
        };
        for (final lutDepth in depthLut) {
          final lutType = cv.MatType.makeType(lutDepth, channel);
          // 0-1: 65536-1-0 2-3: 65536-1-1 3-4: 65536-1-2
          final lutData = switch (lutDepth) {
            cv.MatType.CV_32F ||
            cv.MatType.CV_64F =>
              List.generate(lutSize * lutType.channels, (i) => (lutSize - (i ~/ channel) - 1).toDouble()),
            _ => List.generate(lutSize * lutType.channels, (i) => lutSize - (i ~/ channel) - 1),
          };
          final lutInverse = cv.Mat.fromList(1, lutSize, lutType, lutData);
          testOneLUT(src, lutInverse);
        }
      }
    }
  });

  test('cv.LUT 1', () {
    final mat = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    final src = mat.convertTo(cv.MatType.CV_16UC3, alpha: 65536.0 / 255.0);
    final lutData = List.generate(65536 * 3, (i) => 65536 - (i ~/ 3) - 1);
    final lut = cv.Mat.fromList(1, 65536, cv.MatType.CV_16UC3, lutData);
    final dst = cv.LUT(src, lut);
    expect(dst.isEmpty, equals(false));
    expect(dst.shape, src.shape);
    // cv.imwrite("lut.png", dst.convertTo(cv.MatType.CV_8UC3, alpha: 255.0/65536.0));
  });

  test('cv.magnitude', () {
    final src1 = cv.Mat.randu(4, 4, cv.MatType.CV_32FC1);
    final src2 = cv.Mat.randu(4, 4, cv.MatType.CV_32FC1);
    final dst = cv.magnitude(src1, src2);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.max', () {
    final src1 = cv.Mat.randu(4, 4, cv.MatType.CV_32FC1);
    final src2 = cv.Mat.randu(4, 4, cv.MatType.CV_32FC1);
    final dst = cv.max(src1, src2);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.min', () {
    final src1 = cv.Mat.randu(4, 4, cv.MatType.CV_32FC1);
    final src2 = cv.Mat.randu(4, 4, cv.MatType.CV_32FC1);
    final dst = cv.min(src1, src2);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.meanStdDev', () {
    final src = cv.Mat.randu(101, 102, cv.MatType.CV_8UC3);
    final (mean, stdDev) = cv.meanStdDev(src);
    expect(mean.val, isNotEmpty);
    expect(stdDev.val, isNotEmpty);
  });

  test('cv.merge', () {
    final src = [
      cv.Mat.randu(101, 102, cv.MatType.CV_8UC1),
      cv.Mat.randu(101, 102, cv.MatType.CV_8UC1),
      cv.Mat.randu(101, 102, cv.MatType.CV_8UC1),
    ].cvd;
    final dst = cv.merge(src);
    expect(dst.isEmpty, equals(false));
    expect(dst.channels, equals(3));
  });

  test('cv.minMaxIdx', () {
    final src = cv.Mat.randu(10, 10, cv.MatType.CV_32FC1);
    final (min, max, minIdx, maxIdx) = cv.minMaxIdx(src);
    expect(minIdx, greaterThanOrEqualTo(0));
    expect(maxIdx, greaterThanOrEqualTo(0));
    expect(max > min, equals(true));
  });

  test('cv.minMaxLoc', () {
    final src = cv.Mat.randu(10, 10, cv.MatType.CV_32FC1);
    final (min, max, minLoc, maxLoc) = cv.minMaxLoc(src);
    expect(minLoc.x, greaterThanOrEqualTo(0));
    expect(maxLoc.x, greaterThanOrEqualTo(0));
    expect(max > min, equals(true));
  });

  test('cv.mixChannels', () {
    final bgra = cv.Mat.fromScalar(100, 100, cv.MatType.CV_8UC4, cv.Scalar(255, 0, 0, 255));
    final bgr = cv.Mat.create(cols: bgra.cols, rows: bgra.rows, type: cv.MatType.CV_8UC3);
    final alpha = cv.Mat.create(cols: bgra.cols, rows: bgra.rows, type: cv.MatType.CV_8UC1);
    final out = [bgr, alpha].cvd;
    final fromTo = [0, 2, 1, 1, 2, 0, 3, 3].i32;
    final dst = cv.mixChannels([bgra].cvd, out, fromTo);
    expect(dst.isEmpty, false);
  });

  test('cv.mulSpectrums', () {
    final a = cv.Mat.zeros(101, 102, cv.MatType.CV_32FC1);
    final b = cv.Mat.zeros(101, 102, cv.MatType.CV_32FC1);

    final dst = cv.mulSpectrums(a, b, 0);
    expect(dst.isEmpty, false);

    final dst1 = cv.mulSpectrums(a, b, cv.DFT_ROWS);
    expect(dst1.isEmpty, false);
  });

  test('cv.multiply', () {
    final mat1 = cv.Mat.randn(101, 102, cv.MatType.CV_64FC1);
    final mat2 = cv.Mat.randn(101, 102, cv.MatType.CV_64FC1);
    final mat3 = cv.multiply(mat1, mat2);
    expect(mat3.isEmpty, equals(false));
    expect(mat3.at<double>(0, 0), equals(mat1.at<double>(0, 0) * mat2.at<double>(0, 0)));
  });

  test('cv.normalize', () {
    final src = cv.Mat.randn(101, 102, cv.MatType.CV_8UC1);
    final dst = cv.Mat.empty();
    cv.normalize(src, dst);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.norm', () {
    final src1 = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC1);
    final n = cv.norm(src1);
    expect(n, equals(0));

    final src2 = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC1);
    final n1 = cv.norm1(src1, src2);
    expect(n1, equals(0));
  });

  test('cv.perspectiveTransform', () {
    final src = cv.Mat.zeros(100, 1, cv.MatType.CV_32FC2);
    final tm = cv.Mat.zeros(3, 3, cv.MatType.CV_32FC1);
    final dst = cv.perspectiveTransform(src, tm);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.solve', () {
    final a = cv.Mat.zeros(3, 3, cv.MatType.CV_32FC1);
    final b = cv.Mat.zeros(3, 1, cv.MatType.CV_32FC1);
    final testPoints = [
      (1.0, 1.0, 1.0, 0.0),
      (0.0, 0.0, 1.0, 2.0),
      (9.0, 3.0, 1.0, 2.0),
    ];
    for (var i = 0; i < testPoints.length; i++) {
      a.set<double>(i, 0, testPoints[i].$1);
      a.set<double>(i, 1, testPoints[i].$2);
      a.set<double>(i, 2, testPoints[i].$3);
      b.set<double>(i, 0, testPoints[i].$4);
    }
    final (solved, solve) = cv.solve(a, b, flags: cv.DECOMP_LU);
    expect(solved, equals(true));
    expect((solve.at<double>(0, 0), solve.at<double>(1, 0), solve.at<double>(2, 0)), (1, -3, 2));
  });

  test('cv.solveCubic', () {
    final coeffs = cv.Mat.zeros(1, 4, cv.MatType.CV_32FC1);
    coeffs.set<double>(0, 0, 2.0);
    coeffs.set<double>(0, 1, 3.0);
    coeffs.set<double>(0, 2, -11.0);
    coeffs.set<double>(0, 3, -6.0);

    final (rootsCount, roots) = cv.solveCubic(coeffs);
    expect(rootsCount, equals(3));
    expect((roots.at<double>(0, 0), roots.at<double>(0, 1), roots.at<double>(0, 2)), (-3.0, 2.0, -0.5));
  });

  test('cv.solvePoly', () {
    final coeffs = cv.Mat.zeros(1, 3, cv.MatType.CV_32FC1);
    coeffs.set<double>(0, 0, 49.0);
    coeffs.set<double>(0, 1, -14.0);
    coeffs.set<double>(0, 2, 1.0);

    final (diffError, roots) = cv.solvePoly(coeffs);
    expect(diffError, lessThan(1.0e-61));
    expect(roots.at<double>(0, 0), equals(7.0));
  });

  test('cv.reduce', () {
    final src = cv.Mat.randu(2, 3, cv.MatType.CV_8UC1);
    for (var i = 0; i < src.rows; i++) {
      for (var j = 0; j < src.cols; j++) {
        src.set<int>(i, j, j + 1);
      }
    }
    final dst = cv.reduce(src, 0, cv.REDUCE_SUM, dtype: cv.MatType.CV_32FC1.value);
    expect((dst.rows, dst.cols), equals((1, 3)));
    expect((dst.at<double>(0, 0), dst.at<double>(0, 1), dst.at<double>(0, 2)), (2, 4, 6));

    final dst1 = cv.reduce(src, 1, cv.REDUCE_SUM, dtype: cv.MatType.CV_32FC1.value);
    expect((dst1.rows, dst1.cols), equals((2, 1)));
    expect((dst1.at<double>(0, 0), dst1.at<double>(1, 0)), (6, 6));
  });

  test('cv.reduceArgMax', () {
    final src = cv.Mat.randu(2, 3, cv.MatType.CV_8UC1);
    for (var i = 0; i < src.rows; i++) {
      for (var j = 0; j < src.cols; j++) {
        src.set<int>(i, j, j + 1);
      }
    }
    final dst = cv.reduceArgMax(src, 1);
    expect((dst.rows, dst.cols), equals((2, 1)));
    expect((dst.at<int>(0, 0), dst.at<int>(1, 0)), (2, 2));
  });

  test('cv.reduceArgMin', () {
    final src = cv.Mat.randu(2, 3, cv.MatType.CV_8UC1);
    for (var i = 0; i < src.rows; i++) {
      for (var j = 0; j < src.cols; j++) {
        src.set<int>(i, j, j + 1);
      }
    }
    final dst = cv.reduceArgMin(src, 1);
    expect((dst.rows, dst.cols), equals((2, 1)));
    expect((dst.at<int>(0, 0), dst.at<int>(1, 0)), (0, 0));
  });

  test('cv.repeat', () {
    final src = cv.Mat.randu(1, 3, cv.MatType.CV_8UC1);
    for (var i = 0; i < src.rows; i++) {
      for (var j = 0; j < src.cols; j++) {
        src.set<int>(i, j, j);
      }
    }
    final dst = cv.repeat(src, 3, 1);
    expect((dst.rows, dst.cols), equals((3, 3)));
  });

  test('cv.scaleAdd', () {
    final src = cv.Mat.randu(2, 3, cv.MatType.CV_64FC1);
    final src2 = cv.Mat.randu(2, 3, cv.MatType.CV_64FC1);
    final dst = cv.scaleAdd(src, 0.6, src2);
    expect(dst.at<double>(0, 0), closeTo(src.at<double>(0, 0) * 0.6 + src2.at<double>(0, 0), 1e-4));
  });

  test('cv.setIdentity', () {
    final src = cv.Mat.randu(4, 3, cv.MatType.CV_64FC1);
    cv.setIdentity(src, s: 2.5);
    expect(src.isEmpty, false);
    expect((src.at<double>(0, 0), src.at<double>(1, 1), src.at<double>(2, 2)), (2.5, 2.5, 2.5));
  });

  test('cv.sort', () {
    final src = cv.Mat.randu(2, 3, cv.MatType.CV_8UC1);
    for (var i = 0; i < src.rows; i++) {
      for (var j = 0; j < src.cols; j++) {
        src.set<int>(i, j, j);
      }
    }
    final dst = cv.sort(src, cv.SORT_EVERY_ROW + cv.SORT_DESCENDING);
    expect(dst.isEmpty, false);
    expect(dst.at<int>(0, 0), 2);
  });

  test('cv.sortIdx', () {
    final src = cv.Mat.randu(2, 3, cv.MatType.CV_8UC1);
    for (var i = 0; i < src.rows; i++) {
      for (var j = 0; j < src.cols; j++) {
        src.set<int>(i, j, j);
      }
    }
    final dst = cv.sortIdx(src, cv.SORT_EVERY_ROW + cv.SORT_DESCENDING);
    expect(dst.isEmpty, false);

    expect(dst.at<int>(0, 0), 2);
  });

  test('cv.split', () {
    final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    final chans = cv.split(src);
    expect(chans.length, equals(src.channels));

    final dst = cv.merge(chans);
    expect(dst.isEmpty, false);

    final diff = cv.absDiff(src, dst);
    expect(diff.isEmpty, false);

    final sum = diff.sum();
    expect(sum, equals(cv.Scalar.black));
  });

  test('cv.subtract', () {
    final src1 = cv.Mat.zeros(10, 10, cv.MatType.CV_8UC3);
    final src2 = cv.Mat.ones(10, 10, cv.MatType.CV_8UC3);
    final dst = cv.subtract(src2, src1);
    expect(dst.isEmpty, false);
    expect(dst.at<int>(0, 0), equals(1));
  });

  test('cv.trace', () {
    final src = cv.Mat.randu(3, 3, cv.MatType.CV_8UC1);
    for (var row = 0; row < src.rows; row++) {
      for (var col = 0; col < src.cols; col++) {
        if (row == col) {
          src.set<int>(row, col, 1);
        }
      }
    }

    final trace = cv.trace(src);
    expect(trace, equals(cv.Scalar(3, 0, 0, 0)));
  });

  test('cv.transform', () {
    final src = cv.Mat.randu(3, 3, cv.MatType.CV_8UC3);
    final tm = cv.Mat.zeros(4, 4, cv.MatType.CV_8UC4);
    final dst = cv.transform(src, tm);
    expect(dst.isEmpty, false);
  });

  test('cv.transpose', () {
    final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    final dst = cv.transpose(src);
    expect((dst.rows, dst.cols), (src.cols, src.rows));
  });

  test('cv.pow', () {
    final src = cv.Mat.fromScalar(512, 512, cv.MatType.CV_8UC3, cv.Scalar.all(2));
    final dst = cv.pow(src, 3);
    expect(dst.at<int>(0, 0), 8);
  });

  test('cv.polarToCart', () {
    final magnitude = cv.Mat.zeros(101, 102, cv.MatType.CV_32FC1);
    final angle = cv.Mat.zeros(101, 102, cv.MatType.CV_32FC1);
    final (x, y) = cv.polarToCart(magnitude, angle);
    expect(x.isEmpty || y.isEmpty, false);
  });

  test('cv.phase', () {
    final x = cv.Mat.fromScalar(1, 1, cv.MatType.CV_32FC1, cv.Scalar(1.1, 2.2, 3.3, 4.4));
    final y = cv.Mat.fromScalar(1, 1, cv.MatType.CV_32FC1, cv.Scalar(5.5, 6.6, 7.7, 8.8));
    final angle = cv.phase(x, y);
    expect(angle.isEmpty, false);
    expect(angle.rows, equals(x.rows));
  });

  test('cv.getTickCount, cv.getTickFrequency', () {
    final freq = cv.getTickFrequency();
    expect(freq, greaterThan(0));
    final count = cv.getTickCount();
    expect(count, greaterThan(0));
  });

  test('cv.randn', () {
    final dst = cv.Mat.zeros(10, 10, cv.MatType.CV_32FC1);
    cv.randn(dst, cv.Scalar.all(10), cv.Scalar.all(1));
    expect(dst.isEmpty, false);
  });

  test('cv.randu', () {
    final dst = cv.Mat.zeros(10, 10, cv.MatType.CV_32FC1);
    cv.randu(dst, cv.Scalar.all(10), cv.Scalar.all(100));
    expect(dst.isEmpty, false);
  });

  test('cv.theRNG', () {
    final rng = cv.theRNG();
    for (var i = 0; i < 10000; i++) {
      expect(rng.next(), isA<int>());
    }
  });

  test('cv.randShuffle', () {
    final dst = cv.Mat.zeros(10, 10, cv.MatType.CV_32FC1);
    cv.randShuffle(dst);
    expect(dst.isEmpty, false);
  });

  test(
    'cv.setNumThreads',
    onPlatform: {
      "mac-os":
          const Skip("seems won't work properly on macos, https://github.com/opencv/opencv/issues/5150"),
    },
    () {
      cv.setNumThreads(2);
      final n = cv.getNumThreads();
      expect(n, equals(2));
    },
  );

  test('cv.getNumThreads', () {
    final n = cv.getNumThreads();
    expect(n, greaterThan(0));
  });
}
