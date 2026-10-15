# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT71 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/5e62c706a462f60c85f5d81a21a38717014db0f0.tar.gz"
  version "7.1.33"
  sha256 "32f62131bef57d27b047b75fa83474557541a3bbf7d2b93a3b5c5e3525b08f6a"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_golden_gate: "25541a584f42c88c47edfdd34a1d2e44132e765ddeaeb1641f20bcb809f179e2"
    sha256 cellar: :any, arm64_tahoe:       "9ad510010d21b9b19f770dbcce0cd18086e58c2edd5a69cfb0128157bc9024a2"
    sha256 cellar: :any, arm64_sequoia:     "c0f44370a18ea325d0b6efcb02c4afe711f9d864de1757a3fc92d70fccdea22a"
    sha256 cellar: :any, arm64_sonoma:      "2dc2e1b3028fff63c99b82409a4b52c6b4044a574180ee504dc57ea35cc6d7eb"
    sha256 cellar: :any, sonoma:            "260f7fde7668d05087826b6d859e44eaaaaaeda99a8d08a0c74964c7060b71d9"
    sha256 cellar: :any, arm64_linux:       "a154b1ea7cd2cadc8459637d59e84546757da523e3198b098de3e8ea876bd0ba"
    sha256 cellar: :any, x86_64_linux:      "fb289cc85751f77892c23dcde0f84e2da45a503ce506715d898cd933ee6d3688"
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
