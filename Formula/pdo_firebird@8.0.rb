# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT80 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "75b6c04c22c37baa27603ee2dd8401a664d762d37546d7d1889968cd6a893c3b"
    sha256 cellar: :any,                 arm64_sequoia: "4ee46fb401285961e207bb601040ac3f5df824731d950f0faa3a8814acd80a49"
    sha256 cellar: :any,                 arm64_sonoma:  "33c82318065a5cacb357bd111cc48d03e4ba2ffa0095edd42684903a88f94462"
    sha256 cellar: :any,                 sonoma:        "87fea1ad017a4341b088eed2af24b8f3438d49aa556d37ce5e23d20e58afa774"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2e027ac3cf6d87d7a818861e009bb8c77ed8729c9de22a9d87ecf142d87d7af0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "884fc2b9c4b9bdd2399fc5ec37341e18e1394adff1f9387d6a7ac0dca0021b53"
  end
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/31b3988504b443365bfa4881257782b00919a751.tar.gz"
  version "8.0.30"
  sha256 "6f0f2a0dbb37e904859d7cc9ac12425434333a5c4b811b674621525430bd5472"
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
