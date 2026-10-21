# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT82 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.35.tar.xz"
  sha256 "5737b98601fe5ab1b8c5db0c82ed3158acb9283ed3081ffe2faffb9ac81455e6"
  head "https://github.com/php/php-src.git", branch: "PHP-8.2"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.2(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "21cd807fb0442f3a8a32f8eabc0d9f6144862e7352dac11fe5c4e06542c402de"
    sha256 cellar: :any, arm64_tahoe:       "13bc4712869f786bef8e47567c07533a3d0f4b79326762ea817fb73b6bbcae66"
    sha256 cellar: :any, arm64_sequoia:     "5cd4329c798d276048db10f803daa179130a461da84648d07613ee958ba926f6"
    sha256 cellar: :any, arm64_linux:       "793bab789bac2557a2c61f6866d7c9277af075a6f557b949d4d030fa63a66d09"
    sha256 cellar: :any, x86_64_linux:      "954b5ad87041a2aa80cae32fbb56368bbc4da5b8af7e1056734f87b77e419884"
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
