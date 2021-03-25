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
    rebuild 17
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "b48b2c4104708edb12dfa8dc90ac278feba2ba87ac2e705fc0bd37200e3e0a7e"
    sha256 cellar: :any_skip_relocation, big_sur:       "d985c522ca4ec67a9d1e005d2911b2bd221344d7507f4ac17bfee24f9e3adc34"
    sha256 cellar: :any_skip_relocation, catalina:      "2b3458190033749f341894bcf331da2e926fce383974befec3bc9dc4cd27ba32"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
