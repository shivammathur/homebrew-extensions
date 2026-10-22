# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT56 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/2e922830b542a067a306870dffd20040f34fb05c.tar.gz"
  version "5.6.40"
  sha256 "04c58a4a21c99f3a8df74c37141231691497ebf50a5dce3479f168de7b6f3a5e"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_golden_gate: "05a068b73f1adeb383ee01530dd56e72fa490aa4b4cf423e37852bac523b9e0e"
    sha256 cellar: :any, arm64_tahoe:       "88784129ed1f07d1c7b8fb0afbded0f89627f0a1cdd7a99489ab4f62e9334f4b"
    sha256 cellar: :any, arm64_sequoia:     "608bde767a95b652daab6d58df630336e3d90f9e394938cac75ba9a313d7300d"
    sha256 cellar: :any, arm64_linux:       "3c01184f4de7bd05735963aee225c0818aa8d480cadaddd13a3bc678e4e097c1"
    sha256 cellar: :any, x86_64_linux:      "da8e61cf854409a423205ee5b84245003d35fcfa6a08228255e2de5ec5661291"
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
