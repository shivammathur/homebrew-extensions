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
    rebuild 1
    sha256 arm64_monterey: "740b5bf2148b9079eee4512a04a7ae21290feefa3ce9be8571f33766c05eea97"
    sha256 arm64_big_sur:  "39e9abcd01c1fdb7c7e60ed150bd255875229de30befdd0d235972cdef839db8"
    sha256 monterey:       "f1abd703a8c0d074eb89014ba28c8bdeef6f98a704651f8649252a9a05ff2941"
    sha256 big_sur:        "9041fa9727c4987a4b4163d03bf5088290226e0a52b7b6d37b3f39fbd7b2bb3d"
    sha256 catalina:       "5807d67c116b0bb8348c90659204d342992dfadc4f9d0c7dcbf155be3c4f9f24"
    sha256 x86_64_linux:   "106f45843bb9529012c36c1d9b7932e57558b33b425183b265fda2797ce6485e"
  end

  depends_on "v8"

  def install
    args = %W[
      --with-v8js=#{Formula["v8"].opt_prefix}
    ]
    ENV.append "CPPFLAGS", "-DV8_COMPRESS_POINTERS"
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
