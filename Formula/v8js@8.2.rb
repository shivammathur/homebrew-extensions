# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT82 < AbstractPhpExtension
  init
  desc "V8js PHP extension"
  homepage "https://github.com/phpv8/v8js"
  url "https://github.com/phpv8/v8js/archive/7c40690ec0bb6df72a2ff7eaa510afc7f0adb8a7.tar.gz"
  version "2.1.2"
  sha256 "389cd0810f4330b7e503510892a00902ca3a481dc74423802e06decff966881f"
  head "https://github.com/phpv8/v8js.git", branch: "php8"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 arm64_sonoma:   "87ff05188a77e84faa49c0daba45604aedc6fb5f370d0615c28c5f68619d7f40"
    sha256 arm64_ventura:  "96cf8399384caaa6394836dc11c0412198554ab2cf1fcab456033a959c9ee3a9"
    sha256 arm64_monterey: "5e60be9e77c71351c8276ce0712af0fe07b3136cb3d078ed8d37af36e3e8a1d1"
    sha256 ventura:        "5089e493e54fd671bcafe7d1ce10d7828f8e9634f10d25461608313877b746ba"
    sha256 monterey:       "c1f564695533377dfe4df5eccc9e235f9158a1bc488bcea6b55390d8f68148d5"
    sha256 x86_64_linux:   "4dc52133c2b468b35da0bcec92572d157f61b6d6fafe35fe607946bb356b9f71"
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
    inreplace "v8js_variables.cc", ", v8::PROHIBITS_OVERWRITING, v8::ReadOnly", ""
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
