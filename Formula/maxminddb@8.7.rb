# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT87 < AbstractPhpExtension
  init
  desc "MaxMind DB Reader PHP extension"
  homepage "https://github.com/maxmind/MaxMind-DB-Reader-php-ext"
  url "https://pecl.php.net/get/maxminddb-1.14.0.tgz"
  sha256 "c06351f1360bd651057ea73e0186d8fec744292839a4b49c71ce886072c4fff7"
  revision 2
  head "https://github.com/maxmind/MaxMind-DB-Reader-php-ext.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/maxminddb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "75304609377d87e838be35f4ce055cbc0b9843eed72414eee22c24e6adbd3c4b"
    sha256 cellar: :any, arm64_tahoe:       "20b1aee0643d579fdbdb711d81b42a9bf0fb3bc48a0ffbbd91d8772c9538910f"
    sha256 cellar: :any, arm64_sequoia:     "45ee784649d3c9b3a823f10b26a14d1798fdbc62373fc4aaa85b373a629268d0"
    sha256 cellar: :any, arm64_linux:       "f9d0e44c6335649f79a603ad9d4364992dd076195e70e3e8ce5055dfa80a716e"
    sha256 cellar: :any, x86_64_linux:      "ba5d6169726e1d60937bb2c43a510910c2ebd038db861b077756c0e003e5ef10"
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
