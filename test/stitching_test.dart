import 'package:opencv_dart/opencv_dart.dart' as cv;
import 'package:test/test.dart';

void main() {
  test('cv.Stitcher', () {
    final stitcher = cv.Stitcher.create(mode: cv.StitcherMode.PANORAMA);
    final images = [
      cv.imread("test/images/barcode1.png", flags: cv.IMREAD_COLOR),
      cv.imread("test/images/barcode2.png", flags: cv.IMREAD_COLOR),
    ];
    final (status, pano) = stitcher.stitch(images.cvd);
    expect(status, cv.StitcherStatus.OK);
    expect(pano.isEmpty, false);
    // cv.imwrite('test/images_out/stitcher_test.jpg', pano);

    stitcher.dispose();
  });

  test('cv.Stitcher with mask', () {
    final stitcher = cv.Stitcher.create(mode: cv.StitcherMode.PANORAMA);
    final images = [
      cv.imread("test/images/barcode1.png", flags: cv.IMREAD_COLOR),
      cv.imread("test/images/barcode2.png", flags: cv.IMREAD_COLOR),
    ];

    final masks = [
      cv.imread("test/images/barcode_mask1.png", flags: cv.IMREAD_GRAYSCALE),
      cv.imread("test/images/barcode_mask2.png", flags: cv.IMREAD_GRAYSCALE),
    ];
    final (status, pano) = stitcher.stitch(images.cvd, masks: masks.cvd);
    expect(status, cv.StitcherStatus.OK);
    expect(pano.isEmpty, false);
    // cv.imwrite('test/images_out/stitcher_test_mask.jpg', pano);
  });

  test('cv.Stitcher getter/setter', () {
    final stitcher = cv.Stitcher.create(mode: cv.StitcherMode.PANORAMA);
    stitcher.registrationResol = 3.14159;
    expect(stitcher.registrationResol, 3.14159);

    stitcher.seamEstimationResol = 3.14159;
    expect(stitcher.seamEstimationResol, 3.14159);

    stitcher.panoConfidenceThresh = 3.14159;
    expect(stitcher.panoConfidenceThresh, 3.14159);

    stitcher.compositingResol = 3.14159;
    expect(stitcher.compositingResol, 3.14159);

    stitcher.waveCorrection = true;
    expect(stitcher.waveCorrection, true);

    stitcher.waveCorrectKind = cv.WaveCorrectKind.HORIZONTAL.index;
    expect(stitcher.waveCorrectKind, cv.WaveCorrectKind.HORIZONTAL.index);

    stitcher.interpolationFlags = cv.INTER_LINEAR;
    expect(stitcher.interpolationFlags, cv.INTER_LINEAR);

    expect(stitcher.component.length, greaterThanOrEqualTo(0));
  });

  test('Issue 48', () {
    final images = [
      cv.imread("test/images/barcode1.png", flags: cv.IMREAD_COLOR),
      cv.imread("test/images/barcode2.png", flags: cv.IMREAD_COLOR),
    ];

    // Create Stitcher object
    final cv.Stitcher stitcher = cv.Stitcher.create();

    // Estimate transformations and stitch images
    final cv.StitcherStatus status = stitcher.estimateTransform(images.cvd);
    expect(status, cv.StitcherStatus.OK);

    final result = stitcher.composePanorama();
    expect(result.$1, cv.StitcherStatus.OK);
    expect(result.$2.isEmpty, false);

    final result1 = stitcher.composePanorama(images: images.cvd);
    expect(result1.$1, cv.StitcherStatus.OK);
    expect(result1.$2.isEmpty, false);
  });
}
