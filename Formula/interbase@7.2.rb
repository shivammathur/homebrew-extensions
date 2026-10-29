# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT72 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any, arm64_golden_gate: "bd5b89b7a39813304c405ed54f6f37fb16b554c12ff837af8039c3845f13ef10"
    sha256 cellar: :any, arm64_tahoe:       "442dae6ac7893b9ba32e46a741fe4a9a00a236c8ec9ab427531d4bf244d26560"
    sha256 cellar: :any, arm64_sequoia:     "b6718bf7e5a8b02e13d6ae66d560b8f9be0e9328c4459e21cfc54830a6082513"
    sha256 cellar: :any, arm64_linux:       "0d88bda770b576205ab2ee3280133590faac690e8e5b1dba4fbb347ab7b6a63c"
    sha256 cellar: :any, x86_64_linux:      "6ebebdc823be44c2e78fdb891e74999cf2397b1b500fd216105cbdc2fec2cb4f"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/591bc8d42c53199ad7fe8298dce65701006a2abf.tar.gz"
  version "7.2.34"
  sha256 "6c45203a66c02bf2800b32120103e10575a0df964750ed1d2b1e7d06f7139b3e"
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
