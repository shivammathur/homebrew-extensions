# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT71 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "ac62bfa2fe3762de270a49c5dd542e6ec3bc7c3861a0c04ab0838209af653d67"
    sha256 cellar: :any,                 arm64_sequoia: "fb6809755ebd7805b8de2f47f6780a3b4b129a5c251e9729161585d51698c8f9"
    sha256 cellar: :any,                 arm64_sonoma:  "ff59d588d0491f6f1a731c97f05374173add32a74387f8ff4139c56e58762637"
    sha256 cellar: :any,                 sonoma:        "5fdbe3aef7b1d3db94eb6d08b52ed43f8eeda74de34149532e38971a008d5d30"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ebba90553b06e6c51d69660400b45fc78c70316ec12146529db93f72208cf8d1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a9dbca91ec92e567f07e3646f45ddd90f04788b613cf2ec1ad1bdf9ff34d42d2"
  end
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/45db7daedb330abded7576b9c4dadf5ed13e2f0b.tar.gz"
  version "7.1.33"
  sha256 "c83694b44f2c2fedad3617f86d384d05e04c605fa61a005f5d51dfffaba39772"
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
