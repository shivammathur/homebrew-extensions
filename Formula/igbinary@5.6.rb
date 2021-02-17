# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT56 < AbstractPhp56Extension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.8.tar.gz?init=true"
  sha256 "96d2ff56db2b307b03f848028decb780cb2ae7c75fa922871f5f3063c7a66cb2"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "5c572adb9b022732ed51f7a46770cc9ff7f1e69c8dab5ecfb8ae37db081b8bb7"
    sha256 cellar: :any_skip_relocation, big_sur:       "0d2820e2d668290b1153c0e0c5cbd339e38f96466edffb681048067c3b6c8a95"
    sha256 cellar: :any_skip_relocation, catalina:      "225ebcb7c38db5ca896b33f5d90f0711a0cce98341651fcb984e134d144dd9cc"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
    Dir.chdir "src/php5"
    add_include_files
  end
end
