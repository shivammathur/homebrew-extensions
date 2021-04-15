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
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 20
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "bb51e071addfc699463214b98182e50fea4f15145321f271764f64464d1ea34a"
    sha256 cellar: :any_skip_relocation, big_sur:       "1c3fa65a183fd5afcc6e3377fa68ded2dc8780348bde9d180b01094475f97e9b"
    sha256 cellar: :any_skip_relocation, catalina:      "5a710e6afe2ace4c109657758a2ecd6037139de3b8c8842b8dec6c7aa5676d9e"
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
