# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT71 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.12.tar.gz"
  sha256 "de41f25b7d3cf707332c0069ad2a7541f0265b6689de5e99da3c2cab4bf5465e"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://github.com/shivammathur/homebrew-extensions/releases/download/igbinary@7.1-3.2.12"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3752fd5765570706698a39ebbf2f518ee7919a3d03ced940002c96ecf6774855"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "6193b91bbb8984dc8baad15ddaedb7809494f5df74fcc02f48b8555ff2ebea49"
    sha256 cellar: :any_skip_relocation, monterey:       "ee820c8e4f6a2c07fdf361af84fc1e0fa3979be82b7068c9a6cb6d895108a37c"
    sha256 cellar: :any_skip_relocation, big_sur:        "c83fdae1e2fab6efd5e64bff1b000a4a07adc7ff484e0d276e7230d5e55ddcfd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ee92610cd79944e9bacc33bdfa6c6347b589b6e816c30805cc71dabca5d7e60a"
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
