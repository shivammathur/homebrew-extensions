# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT73 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.2.tar.gz"
  sha256 "3f8927d5578ae5536b966ff3dcedaecf5e8b87a8f33f7fe3a78a0a6da30f4005"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "7a5b1f5f8bb0cf9046a4be07eb9f1f3e6a8fe126f227ecf9972fa14d4d50c09f"
    sha256 cellar: :any_skip_relocation, big_sur:       "e412889d5b91894060c38f97e90982df5bcf0881bc233cd40df332e43408c75b"
    sha256 cellar: :any_skip_relocation, catalina:      "018a7ca6560f0b8b0a3bd6fbddcdaa94e4424bfae59fdaa8ab30be5994520d27"
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
