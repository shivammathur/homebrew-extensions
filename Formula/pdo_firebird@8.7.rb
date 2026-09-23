# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT87 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/10a2b0dae015c155a0e1d7486989738c22493a02.tar.gz?commit=10a2b0dae015c155a0e1d7486989738c22493a02"
  version "8.7.0"
  sha256 "5111af9822cf0422a45fdb1e5563590b2a6f5b2db5b035f13e5de6147d7a6849"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "352174c04e0ac91cb6bad4b6ffca6a435909d9fa99655be7550510e9336ed8bd"
    sha256 cellar: :any, arm64_tahoe:       "73809c99e900eb5ffcee27314c66f143bb68a245643b89fa0f374e7c102162a5"
    sha256 cellar: :any, arm64_sequoia:     "e0ab24018ca135370079f8be7f3f44d5892fd6a152a4472f37b0f546b29a8ee8"
    sha256 cellar: :any, arm64_linux:       "88177f4f256bcfed77834907825e4c4209e0eab2c9758c28475b0644dbec104b"
    sha256 cellar: :any, x86_64_linux:      "1ac5b940f65a51ba71ebdb539dc8e67891b5a526f0864c6ad99c1d9a1e0e5f23"
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types" if OS.mac?
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
