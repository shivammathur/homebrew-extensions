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
    rebuild 11
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "9e82350f8e8ced245bb235bfb9d2ba41d3b8ebfc3fad116bcc24658707de5e48"
    sha256 cellar: :any_skip_relocation, big_sur:       "ba8e67997b8003d763fdc9ddafcc7a7ec8e7d7830c2f3306aac50e39c001f022"
    sha256 cellar: :any_skip_relocation, catalina:      "89baccac87daa065e98e909463685cd5b48ccdf0942ebc6c6fe53bc648ed913d"
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
