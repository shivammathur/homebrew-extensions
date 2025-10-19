# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT86 < AbstractPhpExtension
  init
  desc "V8js PHP extension"
  homepage "https://github.com/phpv8/v8js"
  url "https://github.com/phpv8/v8js/archive/dde1c5a87bf702a6e43a432cd6295abd9867af2b.tar.gz"
  version "2.1.2"
  sha256 "aa392706a4b5672954a1efb4ef8c13136253043257b575abe472a3eb848a7446"
  head "https://github.com/phpv8/v8js.git", branch: "php8"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_tahoe:   "f12aae81db18b10a70407fc1e1ac893b064bdb7a273a9794bc2e2d7a641d526b"
    sha256 arm64_sequoia: "e333c65adcd1110cea1843c471f22c7929fc35132f8552b59803ede2c6af9083"
    sha256 arm64_sonoma:  "5aea7ab00a3acfc2ba3c61d4e69ab40713923a6763cef12663ae444cc95d0f16"
    sha256 sonoma:        "051cddfe347e67d3348b6adae1d616267be0b9b7aca386dda47e7acfce778d2a"
    sha256 arm64_linux:   "c55431e8aaa36dd1beddfe7c84e0756f2f88615d0589de49a0c3614898128eef"
    sha256 x86_64_linux:  "475188cb427687d14de33970665f33ab479a4e2fbf781b95a881e886f47b8058"
  end

  depends_on "v8"

  def install
    args = %W[
      --with-v8js=#{Formula["v8"].opt_prefix}
    ]
    ENV.append "CPPFLAGS", "-DV8_COMPRESS_POINTERS"
    ENV.append "CPPFLAGS", "-DV8_ENABLE_SANDBOX"
    ENV.append "CXXFLAGS", "-Wno-c++11-narrowing"
    ENV.append "LDFLAGS", "-lstdc++"
    inreplace "config.m4", "$PHP_LIBDIR", "libexec"
    inreplace "config.m4", "c++17", "c++20"
    inreplace "v8js_exceptions.cc", "zend_exception_get_default()", "zend_ce_exception"
    inreplace "v8js_object_export.cc", "info.Holder()", "info.This()"
    inreplace "v8js_v8object_class.cc", "static int v8js_v8object_get" \
                                      , "static zend_result v8js_v8object_get"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
