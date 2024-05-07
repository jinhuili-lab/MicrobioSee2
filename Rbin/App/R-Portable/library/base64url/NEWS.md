# base64url 1.4

* Disabled tests which compared encodings of non-ascii strings to encodings in
  packages `base64enc` and `openssl` on some systems.

# base64url 1.3

* Fixed decoding on windows for input encoded in native encoding.

# base64url 1.2

* Native routines are now registered.
* Vignette builds without `microbenchmark` installed.
* Update to new backports.

# base64url 1.1

* Added `base32_encode()` and `base32_decode()`.
* Changed license to GPL-3.
* Fixed vignette title.

# base64url 1.0

* Initial release.
