# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT81 < AbstractPhpExtension
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
    sha256 arm64_ventura:  "941c0f6b2215278e029bf4d95e89f43d11ffec2f8315c74458221538129fc6da"
    sha256 arm64_monterey: "26f9a41de198dbd69f6d2be57f7bb9e44754d80bc1fc9c41347200d9ca63bdc8"
    sha256 arm64_big_sur:  "d2220277725d2aa828ada948429745ca67fca067844ac53854223ec53609b6e4"
    sha256 ventura:        "cc9f71aa330c3d242439f76eff865a8fee8e84152b5511a8fe667d161cdc95b6"
    sha256 monterey:       "d953380b647be65667493bf7986b2b08d9864d0dd4a47c2b7a1b8af004e57829"
    sha256 big_sur:        "72dfed600b682fcb2edbfcc58a6a58fff828f7cab11bbc5f925a7a9cfc40d23c"
    sha256 x86_64_linux:   "724888f65e27bd8af9a15a5f7d8001b3a360a965e92e21c4ef812eec6e760d29"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
