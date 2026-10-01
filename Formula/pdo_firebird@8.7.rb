# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT87 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/940ff2098ea4cbc1ce711a07df958f7d531e51fa.tar.gz?commit=940ff2098ea4cbc1ce711a07df958f7d531e51fa"
  version "8.7.0"
  sha256 "52a0c3c3c924c3b1ced852e1306690dfdac516bf4c7c9077b80b4d65b44105f5"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_golden_gate: "1155a5ba9ecb20c97065932f7b7ee395e656f6616b197e3ea912250e29db659e"
    sha256 cellar: :any, arm64_tahoe:       "ffb5a2ec0814ebd706baae07f8c9935990ae6ab323e0512b9a709a1ed5c9f83d"
    sha256 cellar: :any, arm64_sequoia:     "adb4b7aeb893a0ae1d6c3d65cdc6bad0a3de9bc10b2754c1f9eb531f60542a81"
    sha256 cellar: :any, arm64_linux:       "ff6cf17d84827cec876eb752f382f1a3b4e0930a058beea973029f03611d4ced"
    sha256 cellar: :any, x86_64_linux:      "c9e3b036dace87eed9fa7e537a5da2d8a2242e9eaa8c69bab7c3b99f78e61d08"
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types" if OS.mac?
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
