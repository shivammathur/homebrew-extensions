# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT74 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.19.1.tgz"
  sha256 "b280d9e9c146586648b0d4c14720220b9e1aaa1a3083a31ab1665784c90601d0"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "9b3c8625f2a8809f8450bc90cf2545cfa663eb63c3bce4805178cd0f5f819511"
    sha256 cellar: :any, arm64_golden_gate: "fc9845aab70441bdd92aa34bd948a67a3dc0ec80f7e71c31d238e9fb07b93668"
    sha256 cellar: :any, arm64_tahoe:       "cc4d668f0ffbb1eda9ebad107720d3881e40ea79b1b3a64e7567978ea815ba4d"
    sha256 cellar: :any, arm64_sequoia:     "9c2ddcb29e8ea5681b8b47bcd4737f2721f72d5dde5ab8b58c5d3294f846a4e5"
    sha256 cellar: :any, arm64_linux:       "47f212c5be24b9d90c9780c29cdad1a847c3bc0e211ea3ceefa5052922bd824b"
    sha256 cellar: :any, x86_64_linux:      "1d75bfcd0d1472c5fc527b46220fea214143ca671ae1aeba8177450589f863ea"
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
