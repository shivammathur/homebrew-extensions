# typed: false
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
    rebuild 4
    sha256 arm64_monterey: "f33374c3e31ec3947d755518c06390b9602033baa912ac3c7be4c43049d5a728"
    sha256 arm64_big_sur:  "4a08f8404c25c5a2bd7469bc90ad350c2d9ce537c7150fd94aed28e0bfe7a7a8"
    sha256 ventura:        "2b24f874b8ea2995e31f2a84027e32a15264544312159f714449f668e4a59aef"
    sha256 monterey:       "49bc59252e0037a10bc81386590b29b65a892fcdf792b5854d82eca9a8125d0e"
    sha256 big_sur:        "4c435ac2f2ac8d635eeadac09797e9e2925d17f7b3863bf8b196da29a4380fa9"
    sha256 x86_64_linux:   "68ad8ad660aacfbdca8ac0a19dd05b9a5e83f5d3004da485e0735b7cb561d814"
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
