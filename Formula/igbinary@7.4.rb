# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT74 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.7.tar.gz"
  sha256 "21863908348f90a8a895c8e92e0ec83c9cf9faffcfd70118b06fe2dca30eaa96"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "596da3185a76b018e5ac190c64df71f5f2bfef6513b3848b8cd42097fc3d1a13"
    sha256 cellar: :any_skip_relocation, big_sur:       "d0795fbfc5f44d8ed93bb146a644c0c42ca5c67dcbcf90aab1a9e2d524c92317"
    sha256 cellar: :any_skip_relocation, catalina:      "387937050bad2e0446ce2661bab6178610f9df2d10fbcb8f020290902b379d1f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "46b40afff16e373a71b0715fbcdd2c310c8a0886ae119d40f7425aa3ec25c1b1"
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
