# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/2b1437efe991f67203ba07bc02b9735310c463ad.tar.gz"
  sha256 "1a8292930ee5abe3725fd09dd39a98a529a2172de125131f95547f4e69e416a9"
  version "3.5.0"
  revision 1
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256                               arm64_tahoe:   "62561ed562c9122a2e49ddfa0af7f7eaa16f7716f33958435f783769aa4703e6"
    sha256                               arm64_sequoia: "7229f08df3674232a73cd49fa382f1a66100e8de8a907ed3f3ad812987b6e4bd"
    sha256                               arm64_sonoma:  "668b7584b8947cb4e925b83f824e5b64ef0140e35f25c2417239fef3e7723103"
    sha256 cellar: :any_skip_relocation, sonoma:        "6ac961a37587903a8b688881bd316ade378b9bf263718bc23b6ed201784a4dca"
    sha256                               arm64_linux:   "75f4bce6a0e28907b2c125dd16c5d406e843f1e1f1eafe522f25d89f87642567"
    sha256                               x86_64_linux:  "8ae4ecc01ed97e9627534bb8829b30addc1161efd2bb03fdbd3f7aa46cbedd7f"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    inreplace "src/develop/stack.c" do |s|
      s.gsub! "INI_STR((char*) ", "zend_ini_string_literal("
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
