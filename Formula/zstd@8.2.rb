# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT82 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.13.3.tgz"
  sha256 "e4dfa6e5501736f2f5dbfedd33b214c0c47fa98708f0a7d8c65baa95fd6d7e06"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

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
