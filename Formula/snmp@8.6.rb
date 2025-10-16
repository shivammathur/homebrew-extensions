# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT86 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/e2da92b15c71d2a97420ca590fa6579f049d008a.tar.gz?commit=e2da92b15c71d2a97420ca590fa6579f049d008a"
  version "8.5.0"
  sha256 "322352048aa6cf9ed238a18a149461cce9b27111fd8cc82d3da7b1c2e9603537"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_tahoe:   "4d9d2f0951581d61802fa4d44b9b4e3092ad2b2a8807032a660a7833efe607c3"
    sha256 cellar: :any,                 arm64_sequoia: "977dd0a8d05223866871216a4713c9aa12c92f0823e260892d17aa11db0ab236"
    sha256 cellar: :any,                 arm64_sonoma:  "bda91cf9fd3122d4e0d577a35b240fe5c2a554e272bc5d0e044737d41ffcb3c8"
    sha256 cellar: :any,                 sonoma:        "86c0acff7100da768ebb60ff7b00bbd92382373f0f272ee652799440a318e9e2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "cbc513e412503a0245df2a3b81147f58c0f9f1bca0861f7700a6b8777346bd86"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6efd81e3efcd6f542b7d610fe07900d271cc5fcefdd4249bb772a935ed0b619d"
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
