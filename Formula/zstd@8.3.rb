# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT83 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.13.3.tgz"
  sha256 "e4dfa6e5501736f2f5dbfedd33b214c0c47fa98708f0a7d8c65baa95fd6d7e06"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "04eac2d653229a5fbf588ca8b547ed888aa8017849b29a5b6b0f043e4a274bbd"
    sha256 cellar: :any,                 arm64_sonoma:  "ec4ae91bd879af8882e250d1ad9d20e6cc9f0b9b7b356ffa1583e0cd01a2af45"
    sha256 cellar: :any,                 arm64_ventura: "234364fe4b56aec83d594e86f951731c1b162310584983b5c120ef53fb3af7c2"
    sha256 cellar: :any,                 ventura:       "0e1cd9fc6475a722c17b0fd52d12acf4f6cc78259127ae07aadd2e987b0a8fef"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6c10466b634cf37be2e19f813100f6732b6ba678973b738b6da7a6837894f84c"
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
