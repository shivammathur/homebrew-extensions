# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT56 < AbstractPhp56Extension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.8.tar.gz"
  sha256 "96d2ff56db2b307b03f848028decb780cb2ae7c75fa922871f5f3063c7a66cb2"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any_skip_relocation
    sha256 "ce77ae5adfa384b8acac31639a639a8ecc99f7aa594aa0a9a96236741f4f4cef" => :big_sur
    sha256 "b06b0d01440a218adc773f6e9d08e414ba92ee646df9b61e842eac9d196d08d0" => :arm64_big_sur
    sha256 "d0e14ee7a6860263af42e4243a990e393e3ef925eb830bc3a3349f2c6508063d" => :catalina
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/igbinary.so"
    write_config_file
  end
end
