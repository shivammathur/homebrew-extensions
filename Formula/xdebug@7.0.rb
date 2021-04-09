# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT70 < AbstractPhp70Extension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/2.9.0.tar.gz"
  sha256 "d388ad2564a94c52b19eab26983c3686fae8670e13001b51d2cc3b8a1ac4b733"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "6c312503e93358753ba98ed8598d58694c838f00a013a879a7c89b79a51d5f54"
    sha256 cellar: :any_skip_relocation, big_sur:       "120570f8b53a5de19d77783c9d2448d97e4139844110b22460bdfe4f2aa55942"
    sha256 cellar: :any_skip_relocation, catalina:      "34d32d37617c0cb5b133bd6e69f73d6a9a53ef538f44686df79237ab532de3dc"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
