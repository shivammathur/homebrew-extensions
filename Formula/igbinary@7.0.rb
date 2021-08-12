# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT70 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.6.tar.gz"
  sha256 "87cf65d8a003a3f972c0da08f9aec65b2bf3cb0dc8ac8b8cbd9524d581661250"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "02f80fd14eb1046bf5fe2d599f636c1d8ac419be6526206dc1ba4718106f4cfc"
    sha256 cellar: :any_skip_relocation, big_sur:       "f83d306bb96e653202b925bb24949231d9e67bf1abd73bc4bfc4becad285edb4"
    sha256 cellar: :any_skip_relocation, catalina:      "c845ab3ab8a30340ba4c1e662c86451050b289ed0c935fb6bf2b04622f30c0e5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ef54a8d6f37d6d56506c1022bb2f4eb72e27ffdbe0c080b12e23167f52bd349b"
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
