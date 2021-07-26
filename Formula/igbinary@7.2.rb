# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT72 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.4.tar.gz"
  sha256 "30a70eca00d0acaf4979ee532143aebe11cb325a5356b086f357cc3f69fe5550"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "2967efdf827d483c00594efea9ffaebd3f6ab0d855dbef9a765abdfd73d9e074"
    sha256 cellar: :any_skip_relocation, big_sur:       "cd308bcf645c0056c4b3c62f345df9c826bff4ca417e33f5db0d4773f7c82f71"
    sha256 cellar: :any_skip_relocation, catalina:      "37595c9a2b5599f351ccd00ce9bca0c829581f75ded28b15b5a15cda67ff09fb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fb8a343cde881d64fd3de508d1771bbc0c00e79a6f76c9bed60c66c7bad5d38e"
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
