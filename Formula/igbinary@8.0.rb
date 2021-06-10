# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT80 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.3.tar.gz"
  sha256 "c6bb38235e166ddf5713f464f9ab6d16e85783eefa7825824efd252eea6ac4e5"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "964c00189e5498104726060a3b734d323b861f39cff7f7ad66b1e7d197e24ffb"
    sha256 cellar: :any_skip_relocation, big_sur:       "7ca56ccbb91ee40ddb155e8cb8c15fa0592ea617b98e11ff2214e28435340c66"
    sha256 cellar: :any_skip_relocation, catalina:      "a4960df1f3b2de536a62e9ffd4cf4098dbdb99663039a8dbb2b3ad7d9ef35018"
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
