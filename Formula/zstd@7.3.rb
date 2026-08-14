# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT73 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.18.0.tgz"
  sha256 "223d0f77eb5a5e73cf5e7a0652dd8fde7ffdcc843e7f30eeb3998283dec847b9"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "b7be536047a8e910630dbaad317dbe0a2b0678bb5dd393bdcac71328c271e854"
    sha256 cellar: :any, arm64_sequoia: "3f2e6f9dc6be60466b1b93524a024ff0f7dfefd1881eb40060fef72dcb1e4d62"
    sha256 cellar: :any, arm64_sonoma:  "2cddbd7c0e9d0fdccdd5a5491d04539bd54c3b2f36ae2d734a6cf9e9a0472b6b"
    sha256 cellar: :any, sonoma:        "0284a26224cd7bf564dae60de7acfc18e89dacac49cd6f225ed07ae48d32b648"
    sha256 cellar: :any, arm64_linux:   "f76156162f51ecde04bfe6e18a925c73b04db2306791e6d0be9006947237b10f"
    sha256 cellar: :any, x86_64_linux:  "7da32987e59d6faed429f1269a54da03015e4ff11aba6e3db34f3cfa4974589c"
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
