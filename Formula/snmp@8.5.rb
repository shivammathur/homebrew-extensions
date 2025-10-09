# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/f77be081e1c8c40d0c1c4bafbc79bfa984306830.tar.gz?commit=f77be081e1c8c40d0c1c4bafbc79bfa984306830"
  version "8.5.0"
  sha256 "7e72e57ac42742618e67725e74dd83ccbce8db7d5522f463bd78d3900889d98f"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_tahoe:   "5957f7973df8b1315819e1486e94fd8d7d0dc89b06ac10abf65e2836cfa501d9"
    sha256 cellar: :any,                 arm64_sequoia: "7a3c7a2dbe911376f56669a4ea7216c259fe9e6a2254b0209d7def803cd61da5"
    sha256 cellar: :any,                 arm64_sonoma:  "4c92fc340d22a6be9a404796cf6345e34f9f77320c9327c9adae9d4b129e44aa"
    sha256 cellar: :any,                 sonoma:        "fc8688a4e72e8b77e6f2de6d7a4a558d7cb0cc429e05b305f4a0bffbca8e03d4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8444328bb75d4efe240b6cbabe3d335469fe86f8834f04fae5165d7199ebdf4a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f9af133b34f25409cb3970fdbf4b9fc675dd8943bb5a040ef2d22d27d32074e2"
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
