# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/0006522211ea9fcbda0a63ad1bd7adee35f335cd.tar.gz?commit=0006522211ea9fcbda0a63ad1bd7adee35f335cd"
  version "8.5.0"
  sha256 "89bbfc6d344dd965cd0d8d7bbab297f1b99fb7298a605eda95eb65a6b7472c12"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 17
    sha256 cellar: :any,                 arm64_sequoia: "09c208615b38a4da099de11b77d387cd0bb419656aeb95d525c66cb46aac6aaa"
    sha256 cellar: :any,                 arm64_sonoma:  "97fc7fa7d9a4980dcc8c398cc4c06d4f01a8c56e7a9672bf9dcfb29f233879d6"
    sha256 cellar: :any,                 arm64_ventura: "af5c069f45fc12474a134d431e0c681365e9685caa42766115192af66f482178"
    sha256 cellar: :any,                 ventura:       "f3f9c5b4e77de026e6f156046d5974d843fc93604540eb8cccefbc2ffd509f37"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1899905f23a5bbc788863dc015a20d68cbc216e8e148a9c5f08e63a3ba258e4c"
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
