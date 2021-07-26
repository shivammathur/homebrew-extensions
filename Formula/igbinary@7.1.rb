# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT71 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.4.tar.gz"
  sha256 "30a70eca00d0acaf4979ee532143aebe11cb325a5356b086f357cc3f69fe5550"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "fe24fcb418ca1d0d4731bdc1c1b9c95b930bf3c86cfefd10ac42fd010e741a2a"
    sha256 cellar: :any_skip_relocation, big_sur:       "81508695ee6226cbf677d761ce5ec1371032c5a651a866ca5208408043910e7f"
    sha256 cellar: :any_skip_relocation, catalina:      "be8a1d94ad49ab6c6823f33b91b56fa18c711627e344561b20ee1d4abb9055ff"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "aec4c949a499c49b716ff2e05571fc647d2dd2a5ec560ab605fd06ca60ed1b8a"
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
