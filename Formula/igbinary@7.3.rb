# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT73 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.7.tar.gz"
  sha256 "21863908348f90a8a895c8e92e0ec83c9cf9faffcfd70118b06fe2dca30eaa96"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "9fa5b9af91b9e66e11494f28b7e4b2fc8597a9e1e5345d2e66ab4bfc7d77c503"
    sha256 cellar: :any_skip_relocation, big_sur:       "527186588027b9b0fa80d3f4a05572b54c5ead964989a75e26e4a28c4d2240e1"
    sha256 cellar: :any_skip_relocation, catalina:      "7c3afbef9b83d2c1ee20fa3c4a35c7ef22d2afa16071d9cd3944db81e030d431"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2664d36ba1a39b39620b109a60895b67be05ab5fa2ee6b0184a1b8de06cdfa1f"
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
