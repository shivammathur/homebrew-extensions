# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/1ac68e7b079b33b012c9f69b986b31852370f2ee.tar.gz?commit=1ac68e7b079b33b012c9f69b986b31852370f2ee"
  version "8.5.0"
  sha256 "5c3b494034eb0aef6dbc1ea15a2245610008c8d5c12b54698e508b6e30cba88f"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 44
    sha256 cellar: :any,                 arm64_tahoe:   "4fa9d1cff76e910e55c3516837280a958c45cca6f3c57209383405732dd71f17"
    sha256 cellar: :any,                 arm64_sequoia: "c826396e558febf56feba0cc1f501e33941b733742a47c646b69a36cc044476e"
    sha256 cellar: :any,                 arm64_sonoma:  "e7766accd2b37364abb7388bd144fbaf70bf283c1fd73f4fdeb3b810737a3a92"
    sha256 cellar: :any,                 sonoma:        "07466614c012321d4d293ab59bff850bb5acfea3949b82fe81f629244c55552e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0a15c20dc48593e5b02dd630af3f58b1b23d43227f8ee993e926882050c06fe3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cd0615484f0f1af56001891de67fdc36cf7a9a2d36731d9937617040ed62b8ef"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
    ]
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
