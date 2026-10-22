# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT56 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_golden_gate: "51dfc31dbc36d6c1610b9582bc512dcfb37d326fe7ab534fbc9634bfda321f65"
    sha256 cellar: :any, arm64_tahoe:       "63985d21c0fb43cf32542891a528465f0bb56e804a0ba9d80016ef408406e110"
    sha256 cellar: :any, arm64_sequoia:     "aa6607b5ff4b8de18fe19faa5b80bf9466941b2a2e3c45bfe959706ea21c147b"
    sha256 cellar: :any, arm64_linux:       "ba3562683173ec50e1b2b813db1aae846e7ef2606d3a596f22b4f71f1e3dabc5"
    sha256 cellar: :any, x86_64_linux:      "141643e08518c99e61ce1d10b77c0f9a2ed36bfa778857b39629e493bb8acdc1"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/2e922830b542a067a306870dffd20040f34fb05c.tar.gz"
  version "5.6.40"
  sha256 "04c58a4a21c99f3a8df74c37141231691497ebf50a5dce3479f168de7b6f3a5e"
  license "PHP-3.01"

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
    args = %W[
      --with-interbase=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/interbase" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-int-conversion"
      ENV.append "CFLAGS", "-Wno-incompatible-pointer-types"
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
