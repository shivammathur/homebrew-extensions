# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT81 < AbstractPhp81Extension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.1.tar.gz"
  sha256 "bc26f361f750bc9894741201e6851a3445a20d185969c08bf311264b7dc9cd6b"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any_skip_relocation, big_sur: "84fb72a6acbfb638a48c7a3892abbc0dcd2c8346d4ffb45aeb3104c873037c35"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "9e3e70b3bfd9abb0dfd157df6a3bce3ef784a33916e7ae5a504f8c99c736ebf0"
    sha256 cellar: :any_skip_relocation, catalina: "96de6be965232115489fbab01c1df7cdb44c02fa329b192332ed715778e5532f"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
