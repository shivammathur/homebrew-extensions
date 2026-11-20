# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT82 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.36.tar.xz"
  sha256 "df50a00d2b453096608bf2bd98a9fab9a3df8678a77b93011b65c3cfe9a018fa"
  head "https://github.com/php/php-src.git", branch: "PHP-8.2"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.2(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "fa9a3c24fde0d5725c512ec3f537ccdfd7b7a4011a801d561e0ef52884fe0cbd"
    sha256 cellar: :any, arm64_tahoe:       "ce587f42e18f984834dd32f105579bb33f57363d1f98a6295a70500a8032badd"
    sha256 cellar: :any, arm64_sequoia:     "bffc357600055ccafc1279f8e69694bf1fc3e9dc97f80cf11425dbc9b866a302"
    sha256 cellar: :any, arm64_linux:       "4e2bd2592e26dbbb3c107e92a4080b605db48811349ab2cf7f198cd3309df94a"
    sha256 cellar: :any, x86_64_linux:      "146b86c7254f83897149e171480f342fe69438f6777116ebe8403159c6461149"
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
