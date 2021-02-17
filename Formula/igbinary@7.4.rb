# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT74 < AbstractPhp74Extension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.1.tar.gz"
  sha256 "bc26f361f750bc9894741201e6851a3445a20d185969c08bf311264b7dc9cd6b"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "7aee5c6b77cb0e9b38124d26ec26cedea77dd794f6079ad56e90dfb975887ce7"
    sha256 cellar: :any_skip_relocation, big_sur:       "faabae0cc9a92e083d52f4cf6e13056501139d7fa4ffa95e56f433c175349156"
    sha256 cellar: :any_skip_relocation, catalina:      "04203017217f710bd549ff7393a435d8d3fce5433a398e9f63b14c6bf3afff9b"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
