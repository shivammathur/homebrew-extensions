# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT71 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    manifest_sha256 "37150746088b6019aaf79a10dd7a69f8fb97d2e2ef6056d83e2c18c0ac4e0658"
    sha256 cellar: :any, arm64_golden_gate: "0f3bc9ca163f7f5207143d158303bf2938831b05c425af53800d4a462108f327"
    sha256 cellar: :any, arm64_tahoe:       "e3fad68c08bea849aaa07a1e6f56b5173fb44a30f5c598d530b592d3c64a6aa3"
    sha256 cellar: :any, arm64_sequoia:     "13fd19b5fe9236ff5251615586b03d165ce163f1a364aee79dc0888a9ee09e57"
    sha256 cellar: :any, arm64_linux:       "a37b6d227c886e4a374e0761a525338039d369ee0a2ba3666ebd5b4b95b5d0be"
    sha256 cellar: :any, x86_64_linux:      "cf4480dbc43f1640773c97c0cefd821977e8a8f5c942f84c148c22d05c4c02d4"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/19db02dfc0c93c3dcddf34df282ee6db125203df.tar.gz"
  version "7.1.33"
  sha256 "053573e6077d61663bb95d2130b661efa52c5b10f9379243fcbdac9ce01b1e99"
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
