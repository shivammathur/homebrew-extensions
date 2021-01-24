# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT80 < AbstractPhp80Extension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.1.tar.gz"
  sha256 "bc26f361f750bc9894741201e6851a3445a20d185969c08bf311264b7dc9cd6b"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any_skip_relocation
    sha256 "1c05fbf825ac0ddb021f4da53ed23f50de894c1a7eb21a5f8141d326783c8929" => :big_sur
    sha256 "50ff1629fe647aceebea8da91fb5ecd88e1c957897cb9e25bb48f2222e1f036f" => :arm64_big_sur
    sha256 "5366f00f49aca259e503d9f3a15fedd43ddb1fa9802da8f4722005214129c0ec" => :catalina
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/igbinary.so"
    write_config_file
  end
end
