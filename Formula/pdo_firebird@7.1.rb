# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT71 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/85accd17bbbe667724a4901e0b3eec4f5fabddaa.tar.gz"
  version "7.1.33"
  sha256 "f5c5326b49a1b2c0fb6049ba6e237e7ad3df4a3f75885509f591b71c15232f44"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any, arm64_golden_gate: "37da8947197de6dda500a685857afcffafac2431e28dc53221c0fc19c7935711"
    sha256 cellar: :any, arm64_tahoe:       "5911a6c50b9cd0c9c7aa358ea5a47d887e774762b47035f1445b10fe51cbe6f8"
    sha256 cellar: :any, arm64_sequoia:     "b13528907c1453348975b98cc3c1395c81f8ad00f66cbf815fc7f1fdeb3948b5"
    sha256 cellar: :any, arm64_linux:       "b1ee9bf8a66fd3dbf3e92accfd4f6d15ccaebdf355bdc2027a316bfa45c5c7d5"
    sha256 cellar: :any, x86_64_linux:      "4463d1cea102d94f1a9435d62abb4f884de730cd8f4484bce5730e138695b1b6"
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
