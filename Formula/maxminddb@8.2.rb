# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT82 < AbstractPhpExtension
  init
  desc "MaxMind DB Reader PHP extension"
  homepage "https://github.com/maxmind/MaxMind-DB-Reader-php-ext"
  url "https://pecl.php.net/get/maxminddb-1.14.0.tgz"
  sha256 "c06351f1360bd651057ea73e0186d8fec744292839a4b49c71ce886072c4fff7"
  head "https://github.com/maxmind/MaxMind-DB-Reader-php-ext.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/maxminddb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "3b46a7f038687cfffc709db45c5b63f80df232e99dabf45103a8ea776aafe235"
    sha256 cellar: :any, arm64_sequoia: "130bfccd8258a494afb011dab57e860c98ea1b29dd8e4e7adaf21c43f971c21d"
    sha256 cellar: :any, arm64_sonoma:  "1af003ae55ba22f80e0b12e29e67c7ee31aa44828725b75eb960b935e74f16ef"
    sha256 cellar: :any, arm64_linux:   "caece8687a88c4fdb8d40eb3e2d7ecb430ed5325340372680ae2d4f2aede1cad"
    sha256 cellar: :any, x86_64_linux:  "4d7777cf4e939919ece7242522d5411e501535a689b03ff1ecb278534b66cd72"
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
