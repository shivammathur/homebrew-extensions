# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT82 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "945bda159e526990884266ce16603f808a80410b9c9305dfb3d651bad60570e0"
    sha256 cellar: :any,                 arm64_sequoia: "5ab1acd93aebe17559bf7825afa2ad0258a4ff62bf62cc53cd233993dd00d091"
    sha256 cellar: :any,                 arm64_sonoma:  "68cc3147b8e8cefd0b145544f0e8f6ed70203885669c91710021f30734bc8e45"
    sha256 cellar: :any,                 sonoma:        "c5f69f18e0eff449d5a2766de5e19a68ce36d71098c0366c24572d962848bd9f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "debde73504dab9282d2f7b831742dd23b719f54cf9307bbd5805f10de7a2a6d3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "78421c61e1b7f9f4863e64f69448bc80b614a334df85f1af7bd9ca19ef7eac86"
  end
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.30.tar.xz"
  sha256 "bc90523e17af4db46157e75d0c9ef0b9d0030b0514e62c26ba7b513b8c4eb015"
  head "https://github.com/php/php-src.git", branch: "PHP-8.2"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.2.\d+)\.t/i)
  end
  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client@3"].opt_prefix
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
