# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT71 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.7.tar.gz"
  sha256 "21863908348f90a8a895c8e92e0ec83c9cf9faffcfd70118b06fe2dca30eaa96"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "fcb4663b9b7cf19f15c0003630890739be039a3eb1e51010265f58ef7fcb9021"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "09569fcb2565a7a027cef53231b600a0e61855176f3cb6c9c3913cd42a8c1ea0"
    sha256 cellar: :any_skip_relocation, monterey:       "cd9c636c59f1b1b2e53f0d095579dbd22fa17aa1350b4c7cd8bcb887020c4c24"
    sha256 cellar: :any_skip_relocation, big_sur:        "8ba12d6274648e3c2ccdee796453f18e3a0abe828edd5915f9e6ca552ca7d401"
    sha256 cellar: :any_skip_relocation, catalina:       "685eb84d281d546a84f79c1931779c57ae95d7f12010aae7b84fc8042cc0ea2b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3e2cd2137d5e8ddb1ccab749cb03463c3b65b095f8f473ae1d9c72358705d414"
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
