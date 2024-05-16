# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/446ff6a742dd7c2545b1d0c55e85fadf7b8f424b.tar.gz?commit=446ff6a742dd7c2545b1d0c55e85fadf7b8f424b"
  version "8.4.0"
  sha256 "f695826acdd3bdb060006001a98119f9acf2644cce33537f56946b6965e42f90"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 42
    sha256 cellar: :any,                 arm64_sonoma:   "b85f8bd42b0bf9a5e93b68df55bac272355b5436bf46116c9ff80ba3aa580f05"
    sha256 cellar: :any,                 arm64_ventura:  "acdd396394e3bd541d4cbf3c5d7894df1ec9326a8c90af5cb4856972fd43c7ce"
    sha256 cellar: :any,                 arm64_monterey: "5663c045a5ece964affd2f10386c4c334fb11bb485149c5d843f711492d38201"
    sha256 cellar: :any,                 ventura:        "c41f1c7e4144f34d09cc0a0fcad9102b784a66fcf27a44af86b7f50553d737d8"
    sha256 cellar: :any,                 monterey:       "893a9b31c79f11af8d7605bddbc4e72f53bd96b229790cd787b0f3e148703576"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3dd94da3c29663b9109e91e0381a4f8935e1832b93252f739b3c99dbb338efb9"
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
