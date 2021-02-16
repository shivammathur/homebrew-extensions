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
    rebuild 9
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "4c7c404dc1baa077b983f1b5c29443a65cc9560ef0b70511125185565488752b"
    sha256 cellar: :any_skip_relocation, big_sur:       "23da53c28549a04d43c91ddb50db94bb93ee70a545cfdfd167b1f391cbd866c0"
    sha256 cellar: :any_skip_relocation, catalina:      "ed7afcd1fdf343c90b17d97f11248cb47a37f5a6b2b109fad7103a7983327f85"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
    add_include_files
  end
end
