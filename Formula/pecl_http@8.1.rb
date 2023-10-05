# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT81 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.4.tgz"
  sha256 "fb1e10c2e5edfb011ff8dc2e473cdbd2bbe0127d1279dfce4d98570555ac6ded"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "1d6dc3dab30906d3ae0d929ebba9edbb22e104f1c465c44ff12bdf08f31502ed"
    sha256 cellar: :any,                 arm64_ventura:  "5093b86f0241ddc12210813691a305c06ffd97e7ce6db1b8c0ca3b8653901ab6"
    sha256 cellar: :any,                 arm64_monterey: "133fd125181ddd5af5fddc5cd46da8fb376e323ed048b299405646ba64e93c3c"
    sha256 cellar: :any,                 ventura:        "63b4e68ab9f6360c191b0505d398e4812981afec57e94da254c9b5c64a833233"
    sha256 cellar: :any,                 monterey:       "c0be829464e41104a34898af2b114fd19753fd33536c595367a55e368d7c132d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9ea01abf43689cdc8ff431417095d3c47ea82243b1cca0275e4a3b25b41f126c"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.1"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.1"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.1"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
