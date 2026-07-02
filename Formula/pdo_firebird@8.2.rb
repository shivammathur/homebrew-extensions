# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT82 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.32.tar.xz"
  sha256 "e02aa173c236c12791696254d607da680e6d5516f8f5c2339642de7c4f944bd2"
  head "https://github.com/php/php-src.git", branch: "PHP-8.2"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.2(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "6c2d2b8299c39760875ee1228a380e08e6c2d6a1aa4f704b315d668d4a4e2b17"
    sha256 cellar: :any,                 arm64_sequoia: "c0d307e53aa5ee6d6dd489ab5be417c66a29615543589bc015acf689a8ae2b04"
    sha256 cellar: :any,                 arm64_sonoma:  "4a52ba7813c574f4ab6556dc0e50e9008d36dae47c05808f473e54d1ddde7373"
    sha256 cellar: :any,                 sonoma:        "116f7ee00430db701e9f386e8a34ec23cb15e057c238b038b3fc99ef742f9c69"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "cac41f21a78046b33115b3a12a04aed37bb5432b52af17f97d78cf05d29ad611"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3754f3d4f956b19fa40a9903901839119a5b8c75472b436be6b5d8b73d00a1d1"
  end

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
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
