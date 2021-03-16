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
    rebuild 15
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "bc22eddce3ba164afcbc54742b73b2fa8a621c470b996dd61711e897330a5ecb"
    sha256 cellar: :any_skip_relocation, big_sur:       "71a0b6e714c342acd5fe0f6d4cc74ff8a1c661c176d01ee186498c27ceace6f3"
    sha256 cellar: :any_skip_relocation, catalina:      "6d3037c265d15a7a3f7ccfcb17476ef1678717b290bb9fd117b38ab6d0500099"
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
