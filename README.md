# Route Planner

This project is a Flutter-based route planner app that uses a monorepo structure and is managed with Melos. It integrates map-based routing, weather fetching, and rich UI features like a carousel for step-by-step navigation.


## General

- Workspace is managed by [Melos](https://melos.invertase.dev/)

- Flutter version is managed by [FVM](https://fvm.app/).

- Preferred code editor is [Visual Studio Code](https://code.visualstudio.com/)

- All applications should be created under the `apps` directory.

- All packages should be created under the `packages` directory.

- For available scripts, see the [melos.yaml](melos.yaml) file.

## Getting started

Install specified Flutter version
```sh
fvm use
fvm flutter doctor
```

Melos: Install Melos globally:
```sh
dart pub global activate melos
```

Update used Flutter version
```sh
fvm use x.y.z
fvm flutter doctor
```

Get workspace dependencies
```sh
dart pub get
```

Run melos to boostrap the workspace
```sh
melos bootstrap
```

### Create a package
```sh
fvm flutter create -t package <package_name>
```

### Create an app
```sh
fvm flutter create -t app apps/<app_name>
```