import 'package:opencv_dart/opencv_dart.dart' as cv;
import 'package:test/test.dart';

void main() async {
  test('cv.Fisheye.undistortImage', () {
    final img = cv.imread("test/images/fisheye_sample.jpg", flags: cv.IMREAD_UNCHANGED);
    expect(img.isEmpty, false);
    final k = cv.Mat.zeros(3, 3, cv.MatType.CV_64FC1);
    k.set<double>(0, 0, 689.21);
    k.set<double>(0, 1, 0.0);
    k.set<double>(0, 2, 1295.56);

    k.set<double>(1, 0, 0.0);
    k.set<double>(1, 1, 690.48);
    k.set<double>(1, 2, 942.17);

    k.set<double>(2, 0, 0.0);
    k.set<double>(2, 1, 0.0);
    k.set<double>(2, 2, 1.0);

    final d = cv.Mat.zeros(1, 4, cv.MatType.CV_64FC1);

    final dst = cv.Fisheye.undistortImage(img, k, d);
    expect(dst.isEmpty, false);
  });

  test('cv.undistortPoints', () {
    final k = cv.Mat.zeros(3, 3, cv.MatType.CV_64FC1);
    k.set<double>(0, 0, 1094.7249578198823);
    k.set<double>(0, 1, 0.0);
    k.set<double>(0, 2, 1094.7249578198823);

    k.set<double>(1, 0, 0.0);
    k.set<double>(1, 1, 1094.9945708128778);
    k.set<double>(1, 2, 536.4566143451868);

    k.set<double>(2, 0, 0.0);
    k.set<double>(2, 1, 0.0);
    k.set<double>(2, 2, 1.0);

    final d = cv.Mat.zeros(1, 4, cv.MatType.CV_64FC1);
    d.set<double>(0, 0, -0.05207412392075069);
    d.set<double>(0, 1, -0.089168300192224);
    d.set<double>(0, 2, 0.10465607695792184);
    d.set<double>(0, 3, -0.045693446831115585);

    final r = cv.Mat.empty();
    final src = cv.Mat.zeros(3, 1, cv.MatType.CV_64FC2);

    // This camera matrix is 1920x1080. Points where x < 960 and y < 540 should move toward the top left (x and y get smaller)
    // The centre point should be mostly unchanged
    // Points where x > 960 and y > 540 should move toward the bottom right (x and y get bigger)

    // The index being used for col here is actually the channel (i.e. the point's x/y dimensions)
    // (since there's only 1 column so the formula: (colNumber * numChannels + channelNumber) reduces to
    // (0 * 2) + channelNumber
    // so col = 0 is the x coordinate and col = 1 is the y coordinate

    src.set<double>(0, 0, 480.0);
    src.set<double>(0, 1, 270.0);

    src.set<double>(1, 0, 960.0);
    src.set<double>(1, 1, 540.0);

    src.set<double>(2, 0, 1920.0);
    src.set<double>(2, 1, 1080.0);

    cv.undistortPoints(src, k, d);
    final dst = cv.undistortPoints(src, k, d, R: r, P: k);
    expect(dst.isEmpty, false);
    expect(dst.at<double>(0, 0), lessThan(480));
    expect(dst.at<double>(0, 1), lessThan(270));
  });

  test('cv.Fisheye.undistortPoints', () {
    final k = cv.Mat.zeros(3, 3, cv.MatType.CV_64FC1);
    k.set<double>(0, 0, 1094.7249578198823);
    k.set<double>(0, 1, 0.0);
    k.set<double>(0, 2, 959.4907612030962);

    k.set<double>(1, 0, 0.0);
    k.set<double>(1, 1, 1094.9945708128778);
    k.set<double>(1, 2, 536.4566143451868);

    k.set<double>(2, 0, 0.0);
    k.set<double>(2, 1, 0.0);
    k.set<double>(2, 2, 1.0);

    final d = cv.Mat.zeros(1, 4, cv.MatType.CV_64FC1);
    d.set<double>(0, 0, -0.05207412392075069);
    d.set<double>(0, 1, -0.089168300192224);
    d.set<double>(0, 2, 0.10465607695792184);
    d.set<double>(0, 3, -0.045693446831115585);

    final r = cv.Mat.empty();
    final src = cv.Mat.zeros(3, 1, cv.MatType.CV_64FC2);
    final dst = cv.Mat.zeros(3, 1, cv.MatType.CV_64FC2);

    src.set<double>(0, 0, 480.0);
    src.set<double>(0, 1, 270.0);

    src.set<double>(1, 0, 960.0);
    src.set<double>(1, 1, 540.0);

    src.set<double>(2, 0, 1440.0);
    src.set<double>(2, 1, 810.0);

    final knew = k.clone();
    knew.set<double>(0, 0, 0.4 * k.at<double>(0, 0));
    knew.set<double>(1, 1, 0.4 * k.at<double>(1, 1));

    cv.Fisheye.estimateNewCameraMatrixForUndistortRectify(
      k,
      d,
      (1920, 1080),
      r,
      P: knew,
      balance: 1,
      newSize: (1920, 1080),
    );

    cv.Fisheye.undistortPoints(src, k, d);
    cv.Fisheye.undistortPoints(src, k, d, undistorted: dst, R: r, P: k);
    expect(dst.isEmpty, false);
    expect(dst.at<double>(0, 0) != 0, true);
  });

  test('cv.initUndistortRectifyMap', () {
    final img = cv.imread("test/images/distortion.jpg", flags: cv.IMREAD_UNCHANGED);
    expect(img.isEmpty, false);

    final k = cv.Mat.zeros(3, 3, cv.MatType.CV_64FC1);
    k.set<double>(0, 0, 842.0261028);
    k.set<double>(0, 1, 0.0);
    k.set<double>(0, 2, 667.7569792);

    k.set<double>(1, 0, 0.0);
    k.set<double>(1, 1, 707.3668897);
    k.set<double>(1, 2, 385.56476464);

    k.set<double>(2, 0, 0.0);
    k.set<double>(2, 1, 0.0);
    k.set<double>(2, 2, 1.0);

    final d = cv.Mat.zeros(1, 5, cv.MatType.CV_64FC1);
    d.set<double>(0, 0, -3.65584802e-01);
    d.set<double>(0, 1, 1.41555815e-01);
    d.set<double>(0, 2, -2.62985819e-03);
    d.set<double>(0, 3, 2.05841873e-04);
    d.set<double>(0, 4, -2.35021914e-02);

    final (newC, roi) = cv.getOptimalNewCameraMatrix(k, d, (img.cols, img.rows), 1);
    expect(newC.isEmpty, false);
    expect(roi.width, greaterThan(0));

    final r = cv.Mat.empty();
    final (map1, map2) = cv.initUndistortRectifyMap(k, d, r, newC, (img.cols, img.rows), 5);
    final dst = cv.remap(img, map1, map2, cv.INTER_LINEAR);
    expect(dst.isEmpty, false);
    final success = cv.imwrite("test/images/distortion-correct.png", dst);
    expect(success, true);
  });

  test('cv.findChessboardCorners, cv.drawChessboardCorners', () {
    final img = cv.imread("test/images/chessboard_4x6.png", flags: cv.IMREAD_UNCHANGED);
    expect(img.isEmpty, false);

    final (found, corners) = cv.findChessboardCorners(img, (4, 6), flags: 0);
    expect(found, true);
    expect(corners.isEmpty, false);

    final img2 = cv.Mat.zeros(150, 150, cv.MatType.CV_8UC1);
    cv.drawChessboardCorners(img2, (4, 6), corners, true);
    expect(img2.isEmpty, false);
  });

  test('cv.findChessboardCornersSB', () {
    final img = cv.imread("test/images/chessboard_4x6.png", flags: cv.IMREAD_UNCHANGED);
    expect(img.isEmpty, false);

    final (found, corners) = cv.findChessboardCornersSB(img, (4, 6), 0);
    expect(found, true);
    expect(corners.isEmpty, false);

    final img2 = cv.Mat.zeros(150, 150, cv.MatType.CV_8UC1);
    cv.drawChessboardCorners(img2, (4, 6), corners, true);
    expect(img2.isEmpty, false);
  });

  test('cv.findChessboardCornersSBWithMeta', () {
    final img = cv.imread("test/images/chessboard_4x6.png", flags: cv.IMREAD_UNCHANGED);
    expect(img.isEmpty, false);

    final (found, corners, meta) = cv.findChessboardCornersSBWithMeta(img, (4, 6), 0);
    expect(found, true);
    expect(corners.isEmpty, false);
    expect(meta.isEmpty, false);

    final img2 = cv.Mat.zeros(150, 150, cv.MatType.CV_8UC1);
    cv.drawChessboardCorners(img2, (4, 6), corners, true);
    expect(img2.isEmpty, false);
  });

  test('cv.calibrateCamera', () {
    final img = cv.imread("test/images/chessboard_4x6_distort.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    const patternSize = (4, 6);
    final (found, corners) = cv.findChessboardCorners(img, patternSize, flags: 0);
    expect(found, true);
    expect(corners.isEmpty, false);

    final pts = <cv.Point3f>[];
    for (var j = 0; j < patternSize.$2; j++) {
      for (var i = 0; i < patternSize.$1; i++) {
        pts.add(cv.Point3f(i.toDouble(), j.toDouble(), 0));
      }
    }
    final objectPointsVector = cv.Contours3f.fromList([pts]);
    final imagePointsVector = cv.Contours2f.fromList([
      cv.VecPoint2f.fromMat(corners).toList(),
    ]);

    final cameraMatrix = cv.Mat.empty();
    final distCoeffs = cv.Mat.empty();
    final (rmsErr, mtx, dist, rvecs, tvecs) = cv.calibrateCamera(
      objectPointsVector,
      imagePointsVector,
      (img.cols, img.rows),
      cameraMatrix,
      distCoeffs,
    );
    expect(rmsErr, greaterThan(0));
    expect(mtx.isEmpty || dist.isEmpty || rvecs.isEmpty || tvecs.isEmpty, false);

    final dst = cv.undistort(img, cameraMatrix, distCoeffs);
    final target = cv.imread("test/images/chessboard_4x6_distort_correct.png", flags: cv.IMREAD_GRAYSCALE);
    final xor = cv.bitwiseXOR(dst, target);
    final sum = xor.sum();
    expect(sum.val1, lessThan(img.rows * img.cols * 0.005));
  });

  test('cv.estimateAffinePartial2D', () {
    final src = [
      cv.Point2f(0, 0),
      cv.Point2f(10, 5),
      cv.Point2f(10, 10),
      cv.Point2f(5, 10),
    ].cvd;
    final dst = [
      cv.Point2f(0, 0),
      cv.Point2f(10, 0),
      cv.Point2f(10, 10),
      cv.Point2f(0, 10),
    ].cvd;
    final (m, inliers) = cv.estimateAffinePartial2D(
      src,
      dst,
    );
    expect(inliers.isEmpty, false);
    expect(m.isEmpty, false);
    expect((m.rows, m.cols), (2, 3));
  });

  test('cv.estimateAffine2D', () {
    final src = [
      cv.Point2f(0, 0),
      cv.Point2f(10, 5),
      cv.Point2f(10, 10),
      cv.Point2f(5, 10),
    ].cvd;
    final dst = [
      cv.Point2f(0, 0),
      cv.Point2f(10, 0),
      cv.Point2f(10, 10),
      cv.Point2f(0, 10),
    ].cvd;
    final (m, inliers) = cv.estimateAffine2D(
      src,
      dst,
    );
    expect(inliers.isEmpty, false);
    expect(m.isEmpty, false);
    expect((m.rows, m.cols), (2, 3));
  });
}
