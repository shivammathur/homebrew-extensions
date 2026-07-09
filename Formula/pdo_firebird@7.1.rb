# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT71 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/dca4c0c085063632757e8f8d296e06aaff2159e9.tar.gz"
  version "7.1.33"
  sha256 "c16d623df64f5f4823b15880350923498ec0003af815a8c121a53b8755e14914"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_tahoe:   "9ad510010d21b9b19f770dbcce0cd18086e58c2edd5a69cfb0128157bc9024a2"
    sha256 cellar: :any, arm64_sequoia: "c0f44370a18ea325d0b6efcb02c4afe711f9d864de1757a3fc92d70fccdea22a"
    sha256 cellar: :any, arm64_sonoma:  "2dc2e1b3028fff63c99b82409a4b52c6b4044a574180ee504dc57ea35cc6d7eb"
    sha256 cellar: :any, sonoma:        "260f7fde7668d05087826b6d859e44eaaaaaeda99a8d08a0c74964c7060b71d9"
    sha256 cellar: :any, arm64_linux:   "a154b1ea7cd2cadc8459637d59e84546757da523e3198b098de3e8ea876bd0ba"
    sha256 cellar: :any, x86_64_linux:  "fb289cc85751f77892c23dcde0f84e2da45a503ce506715d898cd933ee6d3688"
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
