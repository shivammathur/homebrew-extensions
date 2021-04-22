# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT70 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.2.tar.gz"
  sha256 "3f8927d5578ae5536b966ff3dcedaecf5e8b87a8f33f7fe3a78a0a6da30f4005"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "195699e640f8886e51edffc7a0bfabc35e21be2a491e4cb13aa97fad399106e7"
    sha256 cellar: :any_skip_relocation, big_sur:       "4769039f1359d6cc6774e9469bf3f496c0c8b5d7eeaf66179a39211041c85e0e"
    sha256 cellar: :any_skip_relocation, catalina:      "d21176488bc471e7b80dd069e53748544222b118d129fa24027d85ecc0847427"
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
