# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT84 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "b566efc80b8c4b821cae70eb889d9838caa4b1b6aaf1220ca415d1817a1988fb"
    sha256 cellar: :any,                 arm64_sequoia: "79904c06819666cb158d070aa9781eb1e8f209ff4559caeb9cf7527e4a2ba894"
    sha256 cellar: :any,                 arm64_sonoma:  "49a4a8a0dfce95ed4067d35f1e9b921788ded150dd2d020e3197390942de8003"
    sha256 cellar: :any,                 sonoma:        "2d88f5c14b9b14a42e7114eea7295451c005cbf8ef26b1a7b27cfc73b3e543c7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "740b928cc6082cbbabc937f4f43bc74cef442876f7ba3e74bc7f229a12d6d2e7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9f14deedbb64f5f0cd59ef1f448135b8cc7dfb96f3cebebf38f859b16a98c87c"
  end
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.4.18.tar.xz"
  sha256 "957a9b19b4a8e965ee0cc788ca74333bfffaadc206b58611b6cd3cc8b2f40110"
  head "https://github.com/php/php-src.git", branch: "PHP-8.4"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.4.\d+)\.t/i)
  end
  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client"].opt_prefix
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
