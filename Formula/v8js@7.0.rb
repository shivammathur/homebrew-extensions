# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT70 < AbstractPhpExtension
  init
  desc "V8js PHP extension"
  homepage "https://github.com/phpv8/v8js"
  url "https://github.com/phpv8/v8js/archive/9afd1a941eb65c02a076550fa7fa4648c6087b03.tar.gz"
  version "2.1.2"
  sha256 "505416bc7db6fed9d52ff5e6ca0cafe613a86b4a73c4630d777ae7e89db59250"
  head "https://github.com/phpv8/v8js.git", branch: "php7"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 arm64_sonoma:   "e548c125bc69f6793898d4b0756f21afa3dc1abc9bc57ff04e00a6db77e95d02"
    sha256 arm64_ventura:  "86d973285b8a653dfab216cea9d5202dc21e7fd3b23b97f48e7478bc83b128e0"
    sha256 arm64_monterey: "bef81dba22a8eb2107b8791131316d218bc3a6a33589dbafc9be61bbbd63790b"
    sha256 ventura:        "1e29cae3809bff9f3d8bbf3cf313702ec9397b33974e16c9a2aa290d93fea672"
    sha256 monterey:       "559dfe2c112a3ad044e6b87bdc9b793e38205d42bbf59f0a4074afb7cc6a5683"
    sha256 x86_64_linux:   "9525d07b3c695d4b2f5d2700a06213eb37db262bac1aa3fdb043b6b612b5093c"
  end

  depends_on "v8"

  def install
    args = %W[
      --with-v8js=#{Formula["v8"].opt_prefix}
    ]
    ENV.append "CPPFLAGS", "-DV8_COMPRESS_POINTERS"
    ENV.append "CPPFLAGS", "-DV8_ENABLE_SANDBOX"
    ENV.append "CXXFLAGS", "-Wno-c++11-narrowing -Wno-deprecated-register -Wno-register"
    ENV.append "LDFLAGS", "-lstdc++"
    inreplace "config.m4", "$PHP_LIBDIR", "libexec"
    inreplace "v8js_variables.cc", ", v8::PROHIBITS_OVERWRITING, v8::ReadOnly", ""
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
