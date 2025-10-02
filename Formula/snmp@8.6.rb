# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT86 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/a3f0861f2e5c287b200bd5692e00569b10bb9173.tar.gz?commit=a3f0861f2e5c287b200bd5692e00569b10bb9173"
  version "8.5.0"
  sha256 "9c1bc56952dd5bd685653c09ab418cfb6de030491f8df86e7200a47cc49809ac"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_tahoe:   "2686c40463d46d366d1efb10e190ac22876dfac6b1eec043e18097be46137cef"
    sha256 cellar: :any,                 arm64_sequoia: "8aea7781fe421347f6ddcb53a4cf17c9f73fa3c6c730708cf0d1b93227083a82"
    sha256 cellar: :any,                 arm64_sonoma:  "df5054674f3cf24eb02d5fa7da9ed8c85610ea5d15e386b75c8ef639e55351b9"
    sha256 cellar: :any,                 sonoma:        "9b05d8d71c025604d1f13cc8b8fa6873f0c21c5f00f713d83558b4002d9371c5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a07be1752ba49de9eed19d1a54daf4e3060a80765b93151b927566ef9d686877"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "31c90bfc13a723d68356d3d2f33ddcb90a0e92f36c9ea3063da0b9583b7c7e5f"
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
