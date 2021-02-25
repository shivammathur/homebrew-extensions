# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT74 < AbstractPhp74Extension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.0.3.tar.gz"
  sha256 "1143f8f9677c677106e846f0d22fc82f4ee5ffb52bdd1498a28cb0748186a8c9"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 "e60c29921cf0b0c7be81fc30c5bce624e1f41a3cd51ba8144ce3f7fe1e0bc1fc" => :big_sur
    sha256 "ddfc0038bbcf7fb2f0cc73829f491c565e3ae52027a591338c7568a1a8eff027" => :arm64_big_sur
    sha256 "a04f4f84ff821d9911eee4bf865af81db2de2c6beb057d527944dafad76a4586" => :catalina
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
