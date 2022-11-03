# Changeslog

All notable changes to this project will be documented in this file.
`CITBottomSheet` adheres to [Semantic Versioning](https://semver.org/).

#### 1.x Releases
- `1.3.x` Releases - [1.3.0](#130)
- `1.2.x` Releases - [1.2.0](#120) | [1.2.1](#121)
- `1.1.x` Releases - [1.1.0](#110)
- `1.0.x` Releases - [1.0.0](#100)

#### 1.3.0

- fixed a lot of issues with the example app, including the following:
- fixed issue where after closing some sheets, the grabber and the overlay may remained, blocking the user interaction.
- fixed issue where after expanding to a full sheet size, and closing a sheet, opening another sheet would sometimes force it be shown in the larger expandable size.
- fixed issue where when closing the sheet, the overlay was closed instantly instead of being faded out.
- restored user feedback for dragging between normal and expanded size if the sheet is expandable.
- cleaned up code.
- other minor improvements.

#### 1.2.1

- improved readme and changelog

#### 1.2.0

- made package open source
- added Example App
- added LICENSE.md
- moved changelog to CHANGELOG.md


#### 1.1.0

- able to set background color
- able to set height (auto: package calculates height of view and fixed: app sets height of modal)
- able to set width (full: full width and fixed: app sets width of modal)
- able to set expendable bool (user can drag modal up to make it larger)
- able to set corner radius or squared for header corners
- able to set header accessories (grabber or close button) (optional)
- able to set overlay (optional)
- updated documentation


#### 1.0.0

- added HalfModalManager
