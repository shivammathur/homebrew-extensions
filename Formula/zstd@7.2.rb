# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT72 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.13.3.tgz"
  sha256 "e4dfa6e5501736f2f5dbfedd33b214c0c47fa98708f0a7d8c65baa95fd6d7e06"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "276e66fb8b78f7540753e942594bc856c4078ebf3dbeb1150547eb48a46d08b4"
    sha256 cellar: :any,                 arm64_sonoma:  "05e2cf50969447205c60f4aef3b7f3542706308e1bc618f3c4f94048b4880df2"
    sha256 cellar: :any,                 arm64_ventura: "411c3a6917af4b0c3b469e1fdce7898ad52b27104a9c9a794d46795ef2c1ebec"
    sha256 cellar: :any,                 ventura:       "a803ee5f5ae8dc8241c7d726fcd485616a18af526fda0da7f7521c7d827bb183"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c41abcee5eaebb7cd4ff91eee4e3ca87d549171b83abc62e2b7867ed9e187d36"
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
