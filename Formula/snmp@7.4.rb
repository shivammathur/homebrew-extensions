# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT74 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/9608f3152844986efc1ce94e9a4a603e252f58de.tar.gz"
  version "7.4.33"
  sha256 "f2c7d3c82fdf553f8f3c5f0dcaf6334b22a4e0d02f36bce64433cd835ec30978"
  revision 3
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    manifest_sha256 "397b4336b3dd07887f196348bebf6fe6ab20b3f138ac6525aad7e9e200742543"
    sha256 cellar: :any, arm64_golden_gate: "140315c670d1cdd75ff9b1abc0548e08aad5d9daa997ccf8a05dda4d26e3080e"
    sha256 cellar: :any, arm64_tahoe:       "95d36c5287987bfc382ddf317d86e994d147abd89eba4b48d8961aa9f020f104"
    sha256 cellar: :any, arm64_sequoia:     "d9014ab7f78c76a7306625446867ac70e9f8780f079def905cb763666a6175c3"
    sha256 cellar: :any, arm64_linux:       "a6050ba0f93fd50e6acaa7703f051cd2af83cfbc3f1db1652f65b137536a5ed7"
    sha256 cellar: :any, x86_64_linux:      "d56b982c7b95c606edbd244af7f1b7e436c102250f8ab452db78158779041867"
  end

  depends_on "net-snmp"
  depends_on "openssl@4"

  def install
    args = %W[
      --with-snmp=#{Utils::Path.formula_opt_prefix("net-snmp")}
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@4")}
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
