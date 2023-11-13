# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT83 < AbstractPhpExtension
  init
  desc "V8js PHP extension"
  homepage "https://github.com/phpv8/v8js"
  url "https://github.com/phpv8/v8js/archive/7c40690ec0bb6df72a2ff7eaa510afc7f0adb8a7.tar.gz"
  version "2.1.2"
  sha256 "389cd0810f4330b7e503510892a00902ca3a481dc74423802e06decff966881f"
  head "https://github.com/phpv8/v8js.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 arm64_sonoma:   "28a32a1c7cfc076b63737119a5be34f9dbeb978fe3efe34dac4c0bb42a73e0d0"
    sha256 arm64_ventura:  "cada4a9c1a76ed49eb6864e0c4e3c092ed8d6f067839d559073935f072ce3426"
    sha256 arm64_monterey: "da87202169ec17044de20b7a5a2fa01d1520643df0f46ecd1c762b570008c6d6"
    sha256 ventura:        "9e6241f98381c5567ff7e653923225edd343cd66b53cb87133d064c240736a9b"
    sha256 monterey:       "1c7510da74e288dd5a514f3e0d51626479bbf6abd8a85221983af03ded4a659c"
    sha256 x86_64_linux:   "5cc8f5b886f695c92ae360e05e61430b57647e8bc0dc316a20aab93b8f67ea08"
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
