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
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "0e29953973285444da14ba5c0e06380854a772779a99caada5f439d467f0f30f"
    sha256 cellar: :any_skip_relocation, big_sur:       "351334b3cb5b1e3c9e67f7b22ae49d0e1640df7a295138c76f59e7e1517fcdce"
    sha256 cellar: :any_skip_relocation, catalina:      "f4e9cc6679644745f9ae2e0f9378f014e248659fac221740cc6d25a3d986290f"
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
