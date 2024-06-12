# Contributing

- [Contributing](#contributing)
  - [Contribute new modules](#contribute-new-modules)
  - [Contribute to Documentation](#contribute-to-documentation)
  - [Contribute to Testing](#contribute-to-testing)

<!-- Created by https://github.com/ekalinin/github-markdown-toc -->

## Contribute new modules

If you want to add new opencv API/Module,

1. take a look at https://github.com/rainyl/opencv_dart?tab=readme-ov-file#for-developers to build this project from source
2. add new C wrappers in `src` and make sure it is correctly build
3. add your `.h` file to ffigen.yaml and run `dart run ffigen --config ffigen.yaml`
4. add corresponding dart code in `lib`
5. write testing code and test whether it works as expected

## Contribute to Documentation

1. `git clone https://github.com/rainyl/opencv_dart`
2. open project in IDE and write doc strings above functions and classes in source codes.
3. follow the dart documentation recommendations, https://dart.dev/effective-dart/documentation

## Contribute to Testing

For Windows:

1. `git clone https://github.com/rainyl/opencv_dart`
2. cd `opencv_dart`
3. dart run opencv_dart:setup windows -a x64
4. now write new dart tests and place them in `test/` directory.
5. run `dart test`
6. (Optional) add the **absolute** path of opencv_dart/windows to PATH environment variable, which can ebable the testing sidebar of VSCode.

Other platforms are similar.
