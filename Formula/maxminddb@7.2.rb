# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT72 < AbstractPhpExtension
  init
  desc "MaxMind DB Reader PHP extension"
  homepage "https://github.com/maxmind/MaxMind-DB-Reader-php-ext"
  url "https://pecl.php.net/get/maxminddb-1.15.0.tgz"
  sha256 "49412f02d31d28861f56c05f043ed21a1e8c444b53ac47292da502a4d1fdaa2b"
  head "https://github.com/maxmind/MaxMind-DB-Reader-php-ext.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/maxminddb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "2aa10434315ab585260d8877aba03d9a8b2101b15d0dd39c6d34129ea157310a"
    sha256 cellar: :any, arm64_tahoe:       "f4876df063b140b009e545be55e25f604c0381a0da3656a197ad337b73d68b15"
    sha256 cellar: :any, arm64_sequoia:     "e52ba78319a40aef2eab880a9575b0eb2913f8410cab658fbf7161ac86573f83"
    sha256 cellar: :any, arm64_linux:       "12cb04f47ea7fa2c1bb44394cd99d829b4c12ae7e2c46219f8b8007068fa5975"
    sha256 cellar: :any, x86_64_linux:      "3013ec5d4cf4e1bb248a9d7722433237f59a9e4d8341f331e53fd653505ab733"
  end

  depends_on "libmaxminddb"

  def install
    Dir.chdir "maxminddb-#{version}/ext"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-maxminddb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
