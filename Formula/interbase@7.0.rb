# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT70 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_golden_gate: "7b669980778e1d7d983dddf566b2f8dd5126388e9fe47bd08b2a68aa679bcba4"
    sha256 cellar: :any, arm64_tahoe:       "be34ff4eceed10123c39cbca25377a0c5f9ab704f935bb62eea68e437fdbaca6"
    sha256 cellar: :any, arm64_sequoia:     "459a4b9b6653cb0d47667663227b6616403cb75fff8fdbefb602c7bdb86db53c"
    sha256 cellar: :any, arm64_linux:       "e1756d07890d9a9b4f9e2f79c0c84ca5b001fba8173ea0183862ab197de03f50"
    sha256 cellar: :any, x86_64_linux:      "8f515210d20e23277e70d40d0e68e1c746d5fe7bb53ebe054a2bef0889a0f3c6"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/e3a3b5ee45052f181393e7d9361895f169ab37a1.tar.gz"
  version "7.0.33"
  sha256 "2ce06a971c0029af7bec9247f2050e7f722eb28c094c639ea2d18acd780432ae"
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
