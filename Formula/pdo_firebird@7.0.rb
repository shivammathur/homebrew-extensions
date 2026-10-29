# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT70 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/67a075e9b509891ae7b95e8ff48e73c16f63a19d.tar.gz"
  version "7.0.33"
  sha256 "29b56e2126d94f5f8fa848194fb4073f33c30ce1f484c94dd52f77de668fe850"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any, arm64_golden_gate: "22dae6675746a9b94c9ba7e96d70b3e77dad62871973030e2c19d109aa623a4b"
    sha256 cellar: :any, arm64_tahoe:       "eb364547ac0084312c0693325f969aa1c95ffacd513ded69b78da0b762190328"
    sha256 cellar: :any, arm64_sequoia:     "ae833c0b89a5e630ac45fbdf78797c522f3887b97fe41de5ba26f5bc46b6c6fd"
    sha256 cellar: :any, arm64_linux:       "3df0eae52b4d387d9451403be55296fc4d295db4067e7c60aac38456cd08360b"
    sha256 cellar: :any, x86_64_linux:      "0851ed379e83ccec63d10ca294843fa7d5811a36959a52c05f52cdbedb60b19c"
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
