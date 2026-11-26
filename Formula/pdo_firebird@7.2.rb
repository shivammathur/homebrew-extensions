# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT72 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/31b9324026a97a5255ffa24107c48c6e2a9c0a8b.tar.gz"
  version "7.2.34"
  sha256 "c68605c387149e04a20b193fcb93c8b65a859b7ab3f4b77b12339f83d6583319"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    manifest_sha256 "e54f7231eb1fd8dd14370b8de71b98a958a7406b1f1b553939df258ea952d76d"
    sha256 cellar: :any, arm64_golden_gate: "dfd86bff61082993c001a165d0ebd79d27e43bd019d8fecbef1ddd2b46787c07"
    sha256 cellar: :any, arm64_tahoe:       "a0c2eb28ffc5c803754d06e7dab92256d6461b71e618dfc8d0be594d58d25a8a"
    sha256 cellar: :any, arm64_sequoia:     "6b8332188d42cb039d56ee4f6d0a3785725558c3e5b9f15de19716cbd4e5885d"
    sha256 cellar: :any, arm64_linux:       "db4c6bdd6f0e93e786289c620bfcd85314cc66705149e103befa2739a82d5d0d"
    sha256 cellar: :any, x86_64_linux:      "4f4519e2c5bef205ec058815f9a9ff7aacd6c4c6197d0bde9f80b287190d215d"
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
