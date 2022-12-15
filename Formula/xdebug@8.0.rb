# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT80 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.2.0.tar.gz"
  sha256 "a5979f2060b92375523662f451bfebd76b718116921c60bcdf8e87be0c58dd72"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "85331b7322e2e19f8ca3c0f37a810753440aed6759f4d5df0ef8ae0901b4c144"
    sha256 arm64_big_sur:  "4420029a280f776b1faaf9bd520185de16676ea5f1f0f928d0f4141dcc3b50cf"
    sha256 monterey:       "208230b2409980eca50b730520da253e38d3210a603a35351d08e95660a082bd"
    sha256 big_sur:        "1fc7b8e54e5b3476c9e22b3ce60711ae7a5da7344cf5ba1b565d72e526d393b3"
    sha256 catalina:       "7fdd34283e6842f4424bcda3f9cf653aa141fe468d26f67fdc31ee5112790f2b"
    sha256 x86_64_linux:   "0250f445b79baf167dc2fce7627445da9734b727c4e82bb3e1cc138520e95e0c"
  end

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
