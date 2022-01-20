# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT80 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.7.tar.gz"
  sha256 "21863908348f90a8a895c8e92e0ec83c9cf9faffcfd70118b06fe2dca30eaa96"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "85189526ee4dda865bb71571aa61f40adedf2e57d6bcb5ec383cc4388ff4731c"
    sha256 cellar: :any_skip_relocation, big_sur:       "c92b297067aed8a61f2713e02b9109390c9cb6313d598c916634072e5e350a38"
    sha256 cellar: :any_skip_relocation, catalina:      "4e53b26513b8192936a78e26c4ac03e9a45bb122d36990d1cea463e0c1b39a49"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "72d347e1eea9052b3a483008b192ec0cee012ca374635e2888da1b9635042920"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
