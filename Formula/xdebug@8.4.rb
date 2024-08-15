# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/be05421fe5301263b013f5a882735bfc0510efbd.tar.gz"
  sha256 "3893126a8fb414d58d7dbc010b9433452198d2ee943e4625bbed327a23cbf641"
  version "3.3.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 19
    sha256 arm64_sonoma:   "c225561f2e7480e9b62a4810ef944b0bd151b4fa7c8dbe2d5439c61ce651b813"
    sha256 arm64_ventura:  "6ab0f6120d569d19f6586ddd2458fb059d61dc9d3de0a958286b621b01387758"
    sha256 arm64_monterey: "c1c76f5192a614de631ffb5850235366c035b4b2f0167b794f0458c837d1f95d"
    sha256 ventura:        "0a7894307162fd91ea3949ed97ff2d03d22fd24fa943d1dc953c7129a0e5fb8c"
    sha256 monterey:       "b4c2eaad109d0ea8b63c5281c0c1533a89a06d1d60c3746b146334f3a436d8a1"
    sha256 x86_64_linux:   "f4c1f735ee70da1ae6f991ef7f74754fe0ae6e8400517bc77d97c1f0934230a1"
  end

  uses_from_macos "zlib"

  def install
    inreplace "src/lib/usefulstuff.c", "ext/standard/php_lcg.h", "ext/random/php_random.h"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
