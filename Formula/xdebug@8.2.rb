# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.2.0alpha2.tar.gz"
  sha256 "3db2ca7b20830b790e3a4ddca93a0cbc12bc768beeb50b930c9cfc0b4874846e"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 arm64_monterey: "3053438275245d40ad3448ca209bb3a1d7c42fce4b6f9a68cae21073fa708694"
    sha256 arm64_big_sur:  "c65440a03f2e9ea703860ae5e705c3436bf0ea6e1546e013a9e319cb2b0ddd29"
    sha256 monterey:       "531d379737ba5aeed46520a920a58eec902f7b621e8d1a07ee339e51e774c4ef"
    sha256 big_sur:        "74f6b32d94d00c01649c9decc59fa586fbf52c26c3914125976b9563bd6d4ccf"
    sha256 catalina:       "68401b3e2d797d3ea673efdbd8f9934aa93320eebd601512fc80198aabc4265f"
    sha256 x86_64_linux:   "b80b62811668b8eef686c71721690632c2505406970610950b3758eb3aa8121c"
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
