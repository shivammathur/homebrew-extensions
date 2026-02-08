# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT73 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "6d98247a6e0b6278d80304ecc4759f737e978a82cf78238b5393e08d1f4ee0a7"
    sha256 cellar: :any,                 arm64_sequoia: "e21f73a009851ed6792c4d725d7aded9d533101e65082fa91102c958bab90847"
    sha256 cellar: :any,                 arm64_sonoma:  "79ec6500203ba13dec8ab056e982f009a7add022dd91dd2fbf0d2fbc91e46865"
    sha256 cellar: :any,                 sonoma:        "acfec4fcc14987735c6dedf64a9b0ceafc3afda5250c762a1fd5d8061b0098af"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7b3e2abb761205579189f2689ab2039df52870424c0b521a861b1edeee9f9e71"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3969984578392bf74eb381e8b61635b8a1c1c096fcc2e7533a4cbbb12ac8e1be"
  end
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/2c97539020cfaadf6998f23fd301cb5158464fbc.tar.gz"
  version "7.3.33"
  sha256 "c9bc90d6c3d7b2d3a9e17581d36382f4db3e20e3e43225db5437c52e2f2de7bf"
  license "PHP-3.01"
  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client@3"].opt_prefix
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
