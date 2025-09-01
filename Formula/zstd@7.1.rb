# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT71 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.15.2.tgz"
  sha256 "fd8d3fbf7344854feb169cf3f1e6698ed22825d35a3a5229fe320c8053306eaf"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "7d9ecf3a3fddb715bf6bde550b780b92bf70cff94e4bee0c3e4dab8236c9ea9f"
    sha256 cellar: :any,                 arm64_sonoma:  "7dbd1487e064ba287996c5de31fa8da30ec72922550ec6fd97891bec0e513a3b"
    sha256 cellar: :any,                 arm64_ventura: "bba299291cae7294b1903d4c2d65dd9cf69ba83c04f5a428f11991dd615dcf76"
    sha256 cellar: :any,                 ventura:       "cb219578b840854904366bf3ba848ae592f51a0138630418e91a02a379d11ede"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6d937eb49befdac6857eb022d65614613e8bc312a62f742c615d174723a92c23"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "31e50fefb41532300118a2e817fd68a749820106ab4dbd4949a83895b72aebed"
  end

  depends_on "zstd"

  def install
    Dir.chdir "zstd-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-libzstd", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
