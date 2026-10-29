# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT71 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/b170cdd5baaf5c6b1efd4e78f9a668f10acebc28.tar.gz"
  version "7.1.33"
  sha256 "0120b9ba5bd74c7fb2787142973da29dc6868941e63c34fdf3fd5ea954acb2cd"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any, arm64_golden_gate: "738fb6a61283d533e9450c59845aec0de9e250afc78fe47f7f1f6fcf06387ebf"
    sha256 cellar: :any, arm64_tahoe:       "d924df1b0dab66259d15467badc0086d0a7ed1f7d88f80ae5f9377ea6171e783"
    sha256 cellar: :any, arm64_sequoia:     "cfcd351dfa0bfc42b9613d402f786f50d3386b34f6a663230b307c2f1c983372"
    sha256 cellar: :any, arm64_linux:       "78894f245535b137cc685be3f4c4c1f83a587ea8c12d2b4df5f2812f6513f2ae"
    sha256 cellar: :any, x86_64_linux:      "84fad23bf4a3b4fb516312811c7b0d887c078e5c946ee98bea1ea4611dbd90a3"
  end

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
