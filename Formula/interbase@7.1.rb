# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT71 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any, arm64_golden_gate: "542153d0af6b69fab6d4af7cd0970d6c35d970068203b27a62e117cbe89a076d"
    sha256 cellar: :any, arm64_tahoe:       "295018591e001429af31bf2578a84b028fb190a53509487d26a4d513efb1082c"
    sha256 cellar: :any, arm64_sequoia:     "2f6bd31cd5fef1ea4e4bb987097b4744a4d1ab11dccbfd9b4ae5d529dce811c7"
    sha256 cellar: :any, arm64_linux:       "0ea7cccc8ec1578ddec59a2644c8571275a9d3c12e31f426a28dbf79b055d20a"
    sha256 cellar: :any, x86_64_linux:      "c19b1fbca135d46cefc5eca90d9a6328e5aa736b621395e6cfb76dd347284d51"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/5e62c706a462f60c85f5d81a21a38717014db0f0.tar.gz"
  version "7.1.33"
  sha256 "32f62131bef57d27b047b75fa83474557541a3bbf7d2b93a3b5c5e3525b08f6a"
  license "PHP-3.01"

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
    args = %W[
      --with-interbase=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/interbase" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
